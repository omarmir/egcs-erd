/**
 * DBML Exporter (with TableGroup per Sheet)
 * - Each sheet (except "Enums") becomes a TableGroup
 * - Tables are still defined normally; groups are appended at the end
 */

const ChartDB_DBMLExport = (() => {
  let tables = new Map();      // tableName -> { fields: [], refs: [], indexes: [], checks: [] }
  let enumsMap = new Map();    // enumName -> [values]
  let tableGroups = new Map(); // sheetName -> Set<tableNameSanitized>

  function onOpen() {
    SpreadsheetApp.getUi()
      .createMenu('DBML')
      .addItem('Export DBML (Flat)', 'exportDBML')
      .addToUi();
  }

  function exportDBML() {
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    tables.clear();
    enumsMap.clear();
    tableGroups.clear();

    // --- 1. Load Enums sheet if exists ---
    const enumsSheet = ss.getSheetByName("Enums");
    if (enumsSheet) {
      const data = enumsSheet.getDataRange().getValues();
      let currentEnum = null;
      let values = [];

      data.forEach((row) => {
        const cell = (row[0] || '').toString().trim();
        if (!cell) return;

        // Detect start of a new enum by assuming any row with text and no indent
        if (/^[A-Z]/.test(cell)) {
          if (currentEnum) enumsMap.set(currentEnum, values);
          currentEnum = sanitizeEnumName(cell);
          values = [];
        } else {
          values.push(cell);
        }
      });

      if (currentEnum) enumsMap.set(currentEnum, values);
    }

    // --- 2. Process all sheets as tables ---
    const sheets = ss.getSheets();
    sheets.forEach(sheet => {
      const sheetName = sheet.getName();
      if (sheetName === "Enums") return;

      // ✅ Each sheet is a group
      if (!tableGroups.has(sheetName)) tableGroups.set(sheetName, new Set());
      const groupSet = tableGroups.get(sheetName);

      const data = sheet.getDataRange().getValues();
      let currentTableName = null;
      let mode = null; // "fields" | "indexes" | "checks"

      // Column maps for dynamic index/check layouts
      let indexColMap = null;
      let checkColMap = null;

      for (let i = 0; i < data.length; i++) {
        const row = data[i];
        const firstCell = String(row[0] || '').trim();

        // Blank row: allow multiline description continuation for fields
        if (!firstCell) {
          if (mode === "fields" && currentTableName && tables.get(currentTableName).fields.length > 0) {
            const continuation = String(row[6] || '').trim();
            if (continuation) {
              const t = tables.get(currentTableName);
              const lastField = t.fields[t.fields.length - 1];
              lastField.description += '\n' + continuation;
            }
          }
          continue;
        }

        // Detect table header row (single cell row, next row contains "logical")
        if (
          row.filter(c => String(c).trim() !== '').length === 1 &&
          i + 1 < data.length &&
          String(data[i + 1][0]).toLowerCase().includes('logical')
        ) {
          currentTableName = firstCell; // keep original table name (sanitize later)
          if (!tables.has(currentTableName)) {
            tables.set(currentTableName, { fields: [], refs: [], indexes: [], checks: [] });
          }

          // ✅ Register this table under the current sheet’s TableGroup
          groupSet.add(sanitize(currentTableName));

          mode = "fields";
          indexColMap = null;
          checkColMap = null;
          i++; // skip header row (the "Logical Name" line)
          continue;
        }

        if (!currentTableName) continue;

        // Section switches (capture header row so we can map columns, including "Where")
        if (firstCell.toLowerCase() === 'index name') {
          mode = "indexes";
          indexColMap = buildIndexColumnMap(row); // map header row (supports Where)
          continue; // header row for index section
        }
        if (firstCell.toLowerCase() === 'check name') {
          mode = "checks";
          checkColMap = buildCheckColumnMap(row); // more robust
          continue; // header row for checks section
        }

        // Skip field header row
        if (mode === "fields" && firstCell.toLowerCase() === 'logical name') continue;

        const t = tables.get(currentTableName);

        // --- Parse INDEX rows (supports Where + Functions) ---
        if (mode === "indexes") {
          const indexName = String(row[indexColMap?.name ?? 0] || '').trim();
          const indexFieldRaw = String(row[indexColMap?.expr ?? 1] || '').trim();
          const indexTypeRaw = String(row[indexColMap?.type ?? 2] || '').trim();
          const whereRaw = String(row[indexColMap?.where ?? -1] || '').trim();
          const constraintRaw = String(row[indexColMap?.constraint ?? 5] || '').trim();
          const functionsRaw = String(row[indexColMap?.functions ?? -1] || '').trim();

          if (!indexName && !indexFieldRaw) continue;

          t.indexes.push({
            name: indexName,
            expr: indexFieldRaw,
            type: indexTypeRaw,
            where: whereRaw,
            functions: functionsRaw,
            constraint: constraintRaw
          });
          continue;
        }

        // --- Parse CHECK rows ---
        if (mode === "checks") {
          const checkName = String(row[checkColMap?.name ?? 0] || '').trim();
          const checkExpr = String(row[checkColMap?.expr ?? 5] || '').trim(); // expression usually in "Constraint" col

          if (!checkName || !checkExpr) continue;

          t.checks.push({
            name: checkName,
            expr: checkExpr
          });
          continue;
        }

        // --- Parse FIELD rows (default) ---
        if (mode !== "fields") continue;

        const logicalName = firstCell;
        const fieldName = String(row[1] || '').trim(); // kept for compatibility (unused in DBML output)
        const optional = String(row[2] || '').trim().toUpperCase();
        const typeRaw = String(row[3] || '').trim();
        const relationRaw = String(row[4] || '').trim();
        const constraints = String(row[5] || '').trim();
        const description = String(row[6] || '').trim();

        let fieldType = mapTypeExact(typeRaw);

        // Handle enums/base types
        if (relationRaw) {
          const relLower = relationRaw.toLowerCase();
          if (relLower.startsWith('enum') || relLower.match(/base/i)) {
            const parts = relationRaw.split(',');
            if (parts[1]) fieldType = sanitizeEnumName(parts[1].trim());
          }
        }

        const settings = [];

        // Existing rules
        if (logicalName.toLowerCase() === 'id') settings.push('pk');
        if (optional === 'N') settings.push('not null');

        // pull in anything from the Constraints column (col F)
        settings.push(...parseFieldConstraintsToSettings(constraints));

        t.fields.push({
          name: logicalName,
          type: fieldType,
          settings,
          description
        });

        // Only generate Ref if it is a ForeignKey
        if (relationRaw && relationRaw.toLowerCase().startsWith('foreignkey')) {
          const target = relationRaw.split(',')[1].trim(); // "TableName.field"
          const parts = target.split('.');
          const targetTable = sanitize(parts[0]);
          const targetCol = parts[1] || "id";
          t.refs.push(`Ref: ${sanitize(currentTableName)}.${sanitize(logicalName)} > ${targetTable}.${targetCol}`);
        }
      }
    });

    // --- 3. Build DBML ---
    let dbml = '';

    // Enums first
    enumsMap.forEach((values, name) => {
      dbml += `Enum ${name} {\n  ${values.join("\n  ")}\n}\n\n`;
    });

    // Tables + indexes/checks + refs
    tables.forEach((table, tableName) => {
      dbml += `Table ${sanitize(tableName)} {\n`;
      dbml += `  _deleted boolean [not null, default: false]\n`;

      // Fields
      table.fields.forEach(f => {
        dbml += `  ${sanitize(f.name)} ${f.type}`;
        if (f.settings.length) dbml += ` [${f.settings.join(', ')}]`;
        if (f.description) {
          const safeDescription = f.description.replace(/\*\//g, '* /');
          if (safeDescription.includes('\n')) {
            dbml += ` /*\n${safeDescription}\n  */`;
          } else {
            dbml += ` // ${safeDescription}`;
          }
        }
        dbml += '\n';
      });

      // Indexes (inside table) — outputs "where:" for partial indexes
      if (table.indexes.length) {
        dbml += `\n  Indexes {\n`;
        table.indexes.forEach(ix => {
          const expr = normalizeIndexExprWithFunctions(ix.expr, ix.functions);
          const attrs = [];

          if (ix.name) attrs.push(`name: '${escapeSingleQuotes(ix.name)}'`);
          if (ix.type) attrs.push(`type: ${ix.type.trim()}`);

          const c = (ix.constraint || '').toLowerCase().trim();
          if (c) {
            c.split(/[,\s]+/).filter(Boolean).forEach(tok => {
              if (tok === 'unique' || tok === 'pk') attrs.push(tok);
            });
          }

          // Partial index WHERE
          if (ix.where) {
            attrs.push(`where: ${normalizeWhereExpr(ix.where)}`);
          }

          dbml += `    ${expr}`;
          if (attrs.length) dbml += ` [${attrs.join(', ')}]`;
          dbml += `\n`;
        });
        dbml += `  }\n`;
      }

      // Checks (inside table)
      if (table.checks.length) {
        dbml += `\n  checks {\n`;
        table.checks.forEach(ch => {
          const expr = normalizeCheckExpr(ch.expr);
          const attrs = [];
          if (ch.name) attrs.push(`name: '${escapeSingleQuotes(ch.name)}'`);
          dbml += `    ${expr}`;
          if (attrs.length) dbml += ` [${attrs.join(', ')}]`;
          dbml += `\n`;
        });
        dbml += `  }\n`;
      }

      dbml += '}\n';

      // Refs after table
      if (table.refs.length) dbml += table.refs.join('\n') + '\n';
      dbml += '\n';
    });

    // ✅ 3b. TableGroups (each sheet is a group)
    // Put at the end (definitions first, organization last)
    tableGroups.forEach((set, sheetName) => {
      const names = Array.from(set).filter(Boolean);
      if (!names.length) return;

      dbml += `TableGroup ${sanitize(sheetName)} {\n`;
      names.forEach(tn => {
        dbml += `  ${tn}\n`;
      });
      dbml += `}\n\n`;
    });

    // --- 4. Output dialog ---
    const encodedDBML = encodeURIComponent(dbml);
    const htmlOutput = HtmlService.createHtmlOutput(`
      <textarea style="width:100%; height:400px;">${escapeHtml(dbml)}</textarea>
      <br/>
      <a href="data:text/plain;charset=utf-8,${encodedDBML}" download="export.dbml"
        style="display:inline-block;padding:8px 12px;background:#1a73e8;color:#fff;text-decoration:none;border-radius:4px;">
        ⬇ Download DBML
      </a>
    `).setWidth(700).setHeight(500);

    SpreadsheetApp.getUi().showModalDialog(htmlOutput, 'DBML Export');
  }

  // --- Helpers ---
  function sanitize(name) {
    return String(name).trim().replace(/\s+/g, '_').replace(/[^a-zA-Z0-9_]/g, '');
  }

  function sanitizeEnumName(name) {
    return String(name).trim().replace(/\s+/g, '_').replace(/[^a-zA-Z0-9_]/g, '');
  }

  function mapTypeExact(type) {
    if (!type) return 'varchar';
    const t = type.toLowerCase();
    if (t.startsWith('bigint')) return 'bigint';
    if (t.startsWith('bigserial')) return 'bigserial';
    if (t.startsWith('smallint')) return 'smallint';
    if (t.startsWith('int')) return 'int';
    if (t.startsWith('jsonb')) return 'jsonb';
    if (t.startsWith('json')) return 'json';
    if (t.startsWith('varchar')) return 'varchar';
    if (t.startsWith('text')) return 'text';
    if (t.startsWith('date')) return 'date';
    if (t.startsWith('timestamp') || t.startsWith('datetime')) return 'timestamp';
    if (t.startsWith('boolean') || t.startsWith('bool')) return 'boolean';
    if (t.startsWith('decimal') || t.startsWith('numeric')) return t;
    return 'varchar';
  }

  function parseFieldConstraintsToSettings(constraintsRaw) {
    const c = String(constraintsRaw || '').trim();
    if (!c) return [];

    const lower = c.toLowerCase();
    const out = [];

    if (/\bunique\b/.test(lower)) out.push('unique');
    if (/\bnot\s*null\b/.test(lower)) out.push('not null');
    if (/\bpk\b|\bprimary\s*key\b/.test(lower)) out.push('pk');

    const defMatch = c.match(/default\s*[:=]?\s*(.+)$/i);
    if (defMatch && defMatch[1]) {
      const val = defMatch[1].trim();
      out.push(`default: ${val}`);
    }

    const noteMatch = c.match(/note\s*[:=]?\s*(.+)$/i);
    if (noteMatch && noteMatch[1]) {
      const note = noteMatch[1].trim().replace(/'/g, "\\'");
      out.push(`note: '${note}'`);
    }

    return out;
  }

  // Convert "a,b" -> "(a, b)" unless already "(...)" or "`...`"
  function normalizeIndexExpr(exprRaw) {
    const e = String(exprRaw || '').trim();
    if (!e) return '(id)';
    if (e.startsWith('(') || e.startsWith('`')) return e;
    if (e.includes(',')) {
      return `(${e.split(',').map(s => s.trim()).join(', ')})`;
    }
    return e;
  }

  // Wrap check expressions in backticks unless already backticked
  function normalizeCheckExpr(exprRaw) {
    const e = String(exprRaw || '').trim();
    if (!e) return '``';
    if (e.startsWith('`') && e.endsWith('`')) return e;
    return `\`${e}\``;
  }

  // Wrap WHERE expressions in backticks unless already
  function normalizeWhereExpr(whereRaw) {
    const w = String(whereRaw || '').trim();
    if (!w) return '';
    if (w.startsWith('`') && w.endsWith('`')) return w;
    return `\`${w}\``;
  }

  function escapeSingleQuotes(s) {
    return String(s).replace(/'/g, "\\'");
  }

  function escapeDoubleQuotes(s) {
    return String(s).replace(/\\/g, '\\\\').replace(/"/g, '\\"');
  }

  function escapeHtml(s) {
    return String(s)
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;");
  }

  // Header-driven mapping for indexes (supports a "Where" column)
  function buildIndexColumnMap(headerRow) {
    const map = {};
    headerRow.forEach((col, idx) => {
      const h = String(col || '').trim().toLowerCase();
      if (!h) return;

      if (h === 'index name') map.name = idx;
      if (h.includes('field')) map.expr = idx;            // "Index Field"
      if (h === 'type') map.type = idx;                   // "Type"
      if (h === 'where') map.where = idx;                 // Where
      if (h.includes('constraint')) map.constraint = idx; // "Constraint"
      if (h === 'functions' || h === 'function') map.functions = idx;
    });
    return map;
  }

  // Header-driven mapping for checks (more robust than hardcoding col 5)
  function buildCheckColumnMap(headerRow) {
    const map = {};
    headerRow.forEach((col, idx) => {
      const h = String(col || '').trim().toLowerCase();
      if (!h) return;

      if (h === 'check name') map.name = idx;
      if (h.includes('constraint') || h === 'expression' || h === 'check' || h === 'where') map.expr = idx;
    });
    return map;
  }

  function normalizeIndexExprWithFunctions(exprRaw, functionsRaw) {
    const base = String(exprRaw || '').trim();
    if (!base) return '(id)';

    // If it’s a raw expression, don’t try to rewrite it
    // e.g. `id*2` or (`id*3`,`getdate()`)
    if (base.startsWith('`')) return base;

    // Turn base into a list of "items" (fields/expressions)
    let items = [];

    if (base.startsWith('(') && base.endsWith(')')) {
      const inner = base.slice(1, -1).trim();
      items = splitByCommaRespectingParens(inner);
    } else if (base.includes(',')) {
      items = splitByCommaRespectingParens(base);
    } else {
      items = [base];
    }

    // No functions provided => behave like old normalizeIndexExpr
    const fRaw = String(functionsRaw || '').trim();
    if (!fRaw) {
      if (items.length > 1) return `(${items.map(s => s.trim()).join(', ')})`;
      return items[0].trim();
    }

    // Functions cell can be:
    //  - one wrapper applied to all columns: "lower({col})"
    //  - or comma-separated list aligned with items: ", md5(lower({col}))"
    // Placeholder: {col} -> actual column/expression
    let fParts = splitByCommaRespectingParens(fRaw);

    // If only 1 function pattern, apply to every item
    const applyToAll = fParts.length === 1 && items.length > 1;

    const outItems = items.map((it, idx) => {
      const col = it.trim();
      const pat = (applyToAll ? fParts[0] : (fParts[idx] ?? '')).trim();

      if (!pat) return col;

      // If pattern doesn't include {col}, support shorthands:
      //  1) "lower"            -> lower(col)
      //  2) "md5(lower)"       -> md5(lower(col))
      //  3) "md5(lower(trim))" -> md5(lower(trim(col)))
      if (!pat.includes('{col}')) {
        const p = pat.trim();

        // If it looks like outer(inner(...)) without args, inject col as the innermost arg.
        // Example: "md5(lower)" => outer="md5", inner="lower"
        //          "md5(lower(trim))" => outer="md5", inner="lower(trim)"
        const m = p.match(/^([a-zA-Z_][a-zA-Z0-9_]*)\((.+)\)$/);
        if (m) {
          const outer = m[1];
          const inner = m[2].trim();
          const innerApplied = applyWrapperChain(inner, col);
          return `${outer}(${innerApplied})`;
        }

        // Otherwise treat it as a simple wrapper name
        return `${p}(${col})`;
      }

      return pat.replace(/\{col\}/g, col);
    });

    return outItems.length > 1
      ? `(${outItems.join(', ')})`
      : outItems[0];
  }

  // Splits "a, md5(lower(b)), c" safely
  function splitByCommaRespectingParens(s) {
    const out = [];
    let cur = '';
    let depth = 0;
    let inTicks = false;

    for (let i = 0; i < s.length; i++) {
      const ch = s[i];

      if (ch === '`') {
        inTicks = !inTicks;
        cur += ch;
        continue;
      }

      if (!inTicks) {
        if (ch === '(') depth++;
        if (ch === ')') depth = Math.max(0, depth - 1);

        if (ch === ',' && depth === 0) {
          out.push(cur.trim());
          cur = '';
          continue;
        }
      }

      cur += ch;
    }

    if (cur.trim()) out.push(cur.trim());
    return out;
  }

  function applyWrapperChain(chainRaw, col) {
    const chain = String(chainRaw || '').trim();
    if (!chain) return col;

    // If user already wrote something like "lower({col})", respect it
    if (chain.includes('{col}')) return chain.replace(/\{col\}/g, col);

    // Support nested shorthand like "lower(trim)" meaning lower(trim(col))
    const m = chain.match(/^([a-zA-Z_][a-zA-Z0-9_]*)\((.+)\)$/);
    if (m) {
      const outer = m[1];
      const inner = m[2].trim();
      return `${outer}(${applyWrapperChain(inner, col)})`;
    }

    // Simple wrapper name like "lower"
    return `${chain}(${col})`;
  }

  return { onOpen, export: exportDBML };
})();

// If your menu calls `exportDBML` by name, keep this global wrapper:
function exportDBML() {
  ChartDB_DBMLExport.export();
}
