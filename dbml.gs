const ChartDB_DBMLExport = (() => {
  let tables = new Map(); // tableName -> { fields: [], refs: [], indexes: [], checks: [] }
  let enumsMap = new Map(); // enumName -> [values]

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
      if (sheet.getName() === "Enums") return;

      const data = sheet.getDataRange().getValues();
      let currentTableName = null;
      let mode = null; // "fields" | "indexes" | "checks"

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
          mode = "fields";
          i++; // skip header row (the "Logical Name" line)
          continue;
        }

        if (!currentTableName) continue;

        // Section switches
        if (firstCell.toLowerCase() === 'index name') {
          mode = "indexes";
          continue; // header row for index section
        }
        if (firstCell.toLowerCase() === 'check name') {
          mode = "checks";
          continue; // header row for checks section
        }

        // Skip field header row
        if (mode === "fields" && firstCell.toLowerCase() === 'logical name') continue;

        const t = tables.get(currentTableName);

        // --- Parse INDEX rows ---
        if (mode === "indexes") {
          const indexName = String(row[0] || '').trim();
          const indexFieldRaw = String(row[1] || '').trim();
          const indexTypeRaw = String(row[2] || '').trim();
          const constraintRaw = String(row[5] || '').trim(); // "unique", "pk", etc.

          // Stop indexes if we hit a new table header (rare, but safe)
          if (!indexName) continue;

          t.indexes.push({
            name: indexName,
            expr: indexFieldRaw,
            type: indexTypeRaw,
            constraint: constraintRaw
          });
          continue;
        }

        // --- Parse CHECK rows ---
        if (mode === "checks") {
          const checkName = String(row[0] || '').trim();
          const checkExpr = String(row[5] || '').trim(); // expression is in "Constraint" column

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
        const fieldName = String(row[1] || '').trim();
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

        // NEW: pull in anything from the Constraints column (col F)
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

      // Indexes (inside table)
      if (table.indexes.length) {
        dbml += `\n  Indexes {\n`;
        table.indexes.forEach(ix => {
          const expr = normalizeIndexExpr(ix.expr);
          const attrs = [];

          if (ix.name) attrs.push(`name: '${escapeSingleQuotes(ix.name)}'`);
          if (ix.type) attrs.push(`type: ${ix.type.trim()}`);

          const c = (ix.constraint || '').toLowerCase().trim();
          if (c) {
            // allow values like "unique", "pk", or "unique, pk"
            c.split(/[,\s]+/).filter(Boolean).forEach(tok => {
              if (tok === 'unique' || tok === 'pk') attrs.push(tok);
            });
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

    // Simple flags
    if (/\bunique\b/.test(lower)) out.push('unique');
    if (/\bnot\s*null\b/.test(lower)) out.push('not null'); // if you ever store it here
    if (/\bpk\b|\bprimary\s*key\b/.test(lower)) out.push('pk');

    // default: ...
    // supports "default: false", "default=false", "default (false)"
    const defMatch = c.match(/default\s*[:=]?\s*(.+)$/i);
    if (defMatch && defMatch[1]) {
      const val = defMatch[1].trim();
      // keep as-is; DBML expects default: <expr>
      out.push(`default: ${val}`);
    }

    // note: ...
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
    if (!e) return '(id)'; // fallback; you can remove if you prefer blank to error
    if (e.startsWith('(') || e.startsWith('`')) return e;

    // If comma separated, assume composite
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

  function escapeSingleQuotes(s) {
    return String(s).replace(/'/g, "\\'");
  }

  function escapeHtml(s) {
    return String(s)
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;");
  }

  return { onOpen, export: exportDBML };
})();

// If your menu calls `exportDBML` by name, keep this global wrapper:
function exportDBML() {
  ChartDB_DBMLExport.export();
}
