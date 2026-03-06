/**
 * DBML Exporter (with optional TableGroup / Enum output)
 * - Preserves varchar(n), char(n), numeric(p,s), citext, jsonb, etc.
 * - Export all sheets
 * - Export current sheet
 * - Export current sheet tables only (no enums, no table groups)
 */

const ChartDB_DBMLExport = (() => {
  let tables = new Map();      // tableName -> { fields: [], refs: [], indexes: [], checks: [], _fieldSet, _indexSet, _refSet }
  let enumsMap = new Map();    // enumName -> [values]
  let tableGroups = new Map(); // sheetName -> Set<tableNameSanitized>

  function onOpen() {
    SpreadsheetApp.getUi()
      .createMenu('DBML')
      .addItem('Export DBML (All Sheets)', 'exportDBML')
      .addItem('Export DBML (Current Sheet)', 'exportCurrentSheetDBML')
      .addItem('Export DBML (Current Sheet, Tables Only)', 'exportCurrentSheetTablesOnlyDBML')
      .addToUi();
  }

  function exportDBML() {
    buildAndShowDBML({
      currentSheetOnly: false,
      includeEnums: true,
      includeTableGroups: true
    });
  }

  function exportCurrentSheetDBML() {
    buildAndShowDBML({
      currentSheetOnly: true,
      includeEnums: true,
      includeTableGroups: true
    });
  }

  function exportCurrentSheetTablesOnlyDBML() {
    buildAndShowDBML({
      currentSheetOnly: true,
      includeEnums: false,
      includeTableGroups: false
    });
  }

  function buildAndShowDBML({ currentSheetOnly, includeEnums, includeTableGroups }) {
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const activeSheet = ss.getActiveSheet();

    tables.clear();
    enumsMap.clear();
    tableGroups.clear();

    // --- 1. Load Enums sheet if exists ---
    const enumsSheet = ss.getSheetByName('Enums');
    if (enumsSheet) {
      const data = enumsSheet.getDataRange().getValues();
      let currentEnum = null;
      let values = [];

      data.forEach((row) => {
        const cell = (row[0] || '').toString().trim();
        if (!cell) return;

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

    // --- 2. Choose sheets to process ---
    let sheets = ss.getSheets().filter(sheet => sheet.getName() !== 'Enums');

    if (currentSheetOnly) {
      if (!activeSheet || activeSheet.getName() === 'Enums') {
        SpreadsheetApp.getUi().alert('The active sheet is "Enums" or invalid. Please select a table sheet first.');
        return;
      }
      sheets = [activeSheet];
    }

    // --- 3. Process sheets as tables ---
    sheets.forEach(sheet => {
      const sheetName = sheet.getName();

      if (!tableGroups.has(sheetName)) tableGroups.set(sheetName, new Set());
      const groupSet = tableGroups.get(sheetName);

      const data = sheet.getDataRange().getValues();
      let currentTableName = null;
      let mode = null; // "fields" | "indexes" | "checks" | "refs"

      let indexColMap = null;
      let checkColMap = null;
      let refColMap = null;

      for (let i = 0; i < data.length; i++) {
        const row = data[i];
        const firstCell = String(row[0] || '').trim();

        // Blank row: allow multiline description continuation for fields
        if (!firstCell) {
          if (mode === 'fields' && currentTableName && tables.get(currentTableName).fields.length > 0) {
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
          String(data[i + 1][0] || '').toLowerCase().includes('logical')
        ) {
          currentTableName = firstCell;

          if (!tables.has(currentTableName)) {
            tables.set(currentTableName, {
              fields: [],
              refs: [],
              indexes: [],
              checks: [],
              _fieldSet: new Set(),
              _indexSet: new Set(),
              _refSet: new Set()
            });
          }

          groupSet.add(sanitize(currentTableName));

          mode = 'fields';
          indexColMap = null;
          checkColMap = null;
          refColMap = null;
          i++; // skip logical header row
          continue;
        }

        if (!currentTableName) continue;

        // Section switches
        if (firstCell.toLowerCase() === 'index name') {
          mode = 'indexes';
          indexColMap = buildIndexColumnMap(row);
          checkColMap = null;
          refColMap = null;
          continue;
        }

        if (firstCell.toLowerCase() === 'check name') {
          mode = 'checks';
          checkColMap = buildCheckColumnMap(row);
          indexColMap = null;
          refColMap = null;
          continue;
        }

        if (firstCell.toLowerCase() === 'ref name') {
          mode = 'refs';
          refColMap = buildRefColumnMap(row);
          indexColMap = null;
          checkColMap = null;
          continue;
        }

        if (mode === 'fields' && firstCell.toLowerCase() === 'logical name') continue;

        const t = tables.get(currentTableName);

        // --- Parse INDEX rows ---
        if (mode === 'indexes') {
          const indexName = String(row[indexColMap?.name ?? 0] || '').trim();
          const indexFieldRaw = String(row[indexColMap?.expr ?? 1] || '').trim();
          const indexTypeRaw = String(row[indexColMap?.type ?? 2] || '').trim();
          const whereRaw = String(row[indexColMap?.where ?? -1] || '').trim();
          const constraintRaw = String(row[indexColMap?.constraint ?? 5] || '').trim();
          const functionsRaw = String(row[indexColMap?.functions ?? -1] || '').trim();

          if (!indexName && !indexFieldRaw) continue;

          const indexKey = [
            indexName,
            indexFieldRaw,
            indexTypeRaw,
            whereRaw,
            functionsRaw,
            constraintRaw
          ].join('|');

          if (!t._indexSet.has(indexKey)) {
            t._indexSet.add(indexKey);
            t.indexes.push({
              name: indexName,
              expr: indexFieldRaw,
              type: indexTypeRaw,
              where: whereRaw,
              functions: functionsRaw,
              constraint: constraintRaw
            });
          }
          continue;
        }

        // --- Parse CHECK rows ---
        if (mode === 'checks') {
          const checkName = String(row[checkColMap?.name ?? 0] || '').trim();
          const checkExpr = String(row[checkColMap?.expr ?? 5] || '').trim();

          if (!checkName || !checkExpr) continue;

          t.checks.push({
            name: checkName,
            expr: checkExpr
          });
          continue;
        }

        // --- Parse REF rows ---
        if (mode === 'refs') {
          const refName = String(row[refColMap?.name ?? 0] || '').trim();
          const sourceRaw = String(row[refColMap?.source ?? 1] || '').trim();
          const targetRaw = refColMap?.target != null
            ? String(row[refColMap.target] || '').trim()
            : '';

          if (!sourceRaw || !targetRaw) continue;

          const sourceExpr = normalizeRefSectionSource(sourceRaw, currentTableName);
          const targetExpr = normalizeTargetRefSide(targetRaw);

          if (!sourceExpr || !targetExpr) continue;

          const refLine = refName
            ? `Ref ${sanitize(refName)}: ${sourceExpr} > ${targetExpr}`
            : `Ref: ${sourceExpr} > ${targetExpr}`;

          if (!t._refSet.has(refLine)) {
            t._refSet.add(refLine);
            t.refs.push(refLine);
          }

          continue;
        }

        // --- Parse FIELD rows ---
        if (mode !== 'fields') continue;

        const logicalName = firstCell;
        const optional = String(row[2] || '').trim().toUpperCase();
        const typeRaw = String(row[3] || '').trim();
        const relationRaw = String(row[4] || '').trim();
        const constraints = String(row[5] || '').trim();
        const description = String(row[6] || '').trim();

        let fieldType = mapTypeExact(typeRaw);

        if (relationRaw) {
          const relLower = relationRaw.toLowerCase();
          if (relLower.startsWith('enum') || relLower.match(/base/i)) {
            const parts = relationRaw.split(',');
            if (parts[1]) fieldType = sanitizeEnumName(parts[1].trim());
          }
        }

        const settings = [];
        if (logicalName.toLowerCase() === 'id') settings.push('pk');
        if (optional === 'N') settings.push('not null');
        settings.push(...parseFieldConstraintsToSettings(constraints));

        const fieldKey = `${sanitize(logicalName)}|${fieldType}|${settings.join(',')}|${description}`;
        if (!t._fieldSet.has(fieldKey)) {
          t._fieldSet.add(fieldKey);
          t.fields.push({
            name: logicalName,
            type: fieldType,
            settings,
            description
          });
        }

        // Only generate Ref if it is a simple field-level ForeignKey
        if (relationRaw && relationRaw.toLowerCase().startsWith('foreignkey')) {
          const fkSpec = relationRaw.split(',').slice(1).join(',').trim();

          const isCompositeRef = fkSpec.includes('>') || /\.\s*\(.+\)/.test(fkSpec);

          if (!isCompositeRef) {
            const parsedRef = parseForeignKeySpec(fkSpec, logicalName, currentTableName);
            if (parsedRef && !t._refSet.has(parsedRef)) {
              t._refSet.add(parsedRef);
              t.refs.push(parsedRef);
            }
          }
        }
      }
    });

    // --- 4. Build DBML ---
    let dbml = '';

    if (includeEnums) {
      enumsMap.forEach((values, name) => {
        dbml += `Enum ${name} {\n  ${values.join('\n  ')}\n}\n\n`;
      });
    }

    tables.forEach((table, tableName) => {
      dbml += `Table ${sanitize(tableName)} {\n`;
      dbml += `  _deleted boolean [not null, default: false]\n`;

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

          if (ix.where) {
            attrs.push(`where: ${normalizeWhereExpr(ix.where)}`);
          }

          dbml += `    ${expr}`;
          if (attrs.length) dbml += ` [${attrs.join(', ')}]`;
          dbml += `\n`;
        });
        dbml += `  }\n`;
      }

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

      if (table.refs.length) dbml += table.refs.join('\n') + '\n';
      dbml += '\n';
    });

    if (includeTableGroups) {
      tableGroups.forEach((set, sheetName) => {
        const names = Array.from(set).filter(Boolean);
        if (!names.length) return;

        dbml += `TableGroup ${sanitize(sheetName)} {\n`;
        names.forEach(tn => {
          dbml += `  ${tn}\n`;
        });
        dbml += `}\n\n`;
      });
    }

    // --- 5. Output dialog ---
    let fileName = 'export.dbml';
    let dialogTitle = 'DBML Export (All Sheets)';

    if (currentSheetOnly && includeEnums && includeTableGroups) {
      fileName = `${sanitize(activeSheet.getName())}.dbml`;
      dialogTitle = 'DBML Export (Current Sheet)';
    } else if (currentSheetOnly && !includeEnums && !includeTableGroups) {
      fileName = `${sanitize(activeSheet.getName())}_tables_only.dbml`;
      dialogTitle = 'DBML Export (Current Sheet, Tables Only)';
    } else if (currentSheetOnly) {
      fileName = `${sanitize(activeSheet.getName())}_partial.dbml`;
      dialogTitle = 'DBML Export (Current Sheet)';
    }

    const encodedDBML = encodeURIComponent(dbml);
    const htmlOutput = HtmlService.createHtmlOutput(`
      <textarea style="width:100%; height:400px;">${escapeHtml(dbml)}</textarea>
      <br/>
      <a href="data:text/plain;charset=utf-8,${encodedDBML}" download="${fileName}"
        style="display:inline-block;padding:8px 12px;background:#1a73e8;color:#fff;text-decoration:none;border-radius:4px;">
        ⬇ Download DBML
      </a>
    `).setWidth(700).setHeight(500);

    SpreadsheetApp.getUi().showModalDialog(htmlOutput, dialogTitle);
  }

  // --- Helpers ---
  function sanitize(name) {
    return String(name).trim().replace(/\s+/g, '_').replace(/[^a-zA-Z0-9_]/g, '');
  }

  function sanitizeEnumName(name) {
    return String(name).trim().replace(/\s+/g, '_').replace(/[^a-zA-Z0-9_]/g, '');
  }

  function mapTypeExact(type) {
    const raw = String(type || '').trim();
    if (!raw) return 'varchar';

    const t = raw.toLowerCase();

    if (/^varchar\s*\(\s*\d+\s*\)$/.test(t)) return t;
    if (/^character varying\s*\(\s*\d+\s*\)$/.test(t)) return t;
    if (/^char\s*\(\s*\d+\s*\)$/.test(t)) return t;
    if (/^character\s*\(\s*\d+\s*\)$/.test(t)) return t;
    if (/^(numeric|decimal)\s*\(\s*\d+\s*(,\s*\d+\s*)?\)$/.test(t)) return t;
    if (/^timestamp\s*(with(out)?\s+time\s+zone)?$/.test(t)) return t;
    if (/^time\s*(with(out)?\s+time\s+zone)?$/.test(t)) return t;
    if (/^bit\s*\(\s*\d+\s*\)$/.test(t)) return t;
    if (/^varbit\s*\(\s*\d+\s*\)$/.test(t)) return t;

    const exactTypes = new Set([
      'bigint',
      'bigserial',
      'smallint',
      'serial',
      'int',
      'integer',
      'json',
      'jsonb',
      'text',
      'date',
      'timestamp',
      'timestamptz',
      'datetime',
      'boolean',
      'bool',
      'uuid',
      'citext',
      'bytea',
      'real',
      'double precision',
      'money',
      'inet',
      'cidr',
      'macaddr',
      'macaddr8',
      'xml',
      'tsvector',
      'tsquery'
    ]);

    if (exactTypes.has(t)) return t;

    if (t.startsWith('varchar')) return t;
    if (t.startsWith('character varying')) return t;
    if (t.startsWith('char(') || t.startsWith('character(')) return t;
    if (t.startsWith('numeric')) return t;
    if (t.startsWith('decimal')) return t;
    if (t.startsWith('jsonb')) return 'jsonb';
    if (t.startsWith('json')) return 'json';
    if (t.startsWith('citext')) return 'citext';
    if (t.startsWith('text')) return 'text';
    if (t.startsWith('date')) return 'date';
    if (t.startsWith('timestamp')) return t;
    if (t.startsWith('datetime')) return 'timestamp';
    if (t.startsWith('boolean') || t.startsWith('bool')) return 'boolean';
    if (t.startsWith('bigint')) return 'bigint';
    if (t.startsWith('bigserial')) return 'bigserial';
    if (t.startsWith('smallint')) return 'smallint';
    if (t === 'integer' || t.startsWith('integer')) return 'integer';
    if (t === 'int' || t.startsWith('int')) return 'int';

    return t;
  }

  function parseForeignKeySpec(fkSpec, logicalName, currentTableName) {
    const spec = String(fkSpec || '').trim();
    if (!spec) return null;

    if (spec.includes('>')) {
      const parts = spec.split('>');
      if (parts.length !== 2) return null;

      const sourceRaw = parts[0].trim();
      const targetRaw = parts[1].trim();

      const sourceExpr = normalizeRefSide(sourceRaw, true);
      const targetExpr = normalizeTargetRefSide(targetRaw);

      if (!sourceExpr || !targetExpr) return null;

      return `Ref: ${sourceExpr} > ${targetExpr}`;
    }

    const dotIndex = spec.indexOf('.');
    if (dotIndex === -1) return null;

    const targetTableRaw = spec.slice(0, dotIndex).trim();
    const targetColsRaw = spec.slice(dotIndex + 1).trim();

    const targetExpr = normalizeTargetRefSide(`${targetTableRaw}.${targetColsRaw}`);
    if (!targetExpr) return null;

    if (targetColsRaw.startsWith('(') && targetColsRaw.endsWith(')')) {
      const sourceExpr = normalizeRefSide(logicalName, false);
      if (!sourceExpr.startsWith('(')) {
        return null;
      }
      return `Ref: ${sourceExpr} > ${targetExpr}`;
    }

    return `Ref: ${sanitize(currentTableName)}.${sanitize(logicalName)} > ${targetExpr}`;
  }

  function forceTupleIfCommaSeparated(raw) {
    const s = String(raw || '').trim();
    if (!s) return s;
    if (s.startsWith('(') && s.endsWith(')')) return s;
    if (s.includes(',')) return `(${s})`;
    return s;
  }

  function normalizeRefSectionSource(sourceRaw, currentTableName) {
    const s = String(sourceRaw || '').trim();
    if (!s) return '';

    if (s.includes('.')) {
      const dotIndex = s.indexOf('.');
      const tableRaw = s.slice(0, dotIndex).trim();
      const colsRaw = s.slice(dotIndex + 1).trim();
      return `${sanitize(tableRaw)}.${normalizeRefColumns(forceTupleIfCommaSeparated(colsRaw))}`;
    }

    return `${sanitize(currentTableName)}.${normalizeRefColumns(forceTupleIfCommaSeparated(s))}`;
  }

  function normalizeTargetRefSide(targetRaw) {
    const s = String(targetRaw || '').trim();
    const dotIndex = s.indexOf('.');
    if (dotIndex === -1) return null;

    const tableRaw = s.slice(0, dotIndex).trim();
    const colsRaw = s.slice(dotIndex + 1).trim();

    const tableName = sanitize(tableRaw);
    const colExpr = normalizeRefColumns(colsRaw);

    if (!tableName || !colExpr) return null;
    return `${tableName}.${colExpr}`;
  }

  function normalizeRefSide(sideRaw, allowQualified) {
    const s = String(sideRaw || '').trim();
    if (!s) return '';

    if (allowQualified && s.includes('.')) {
      const dotIndex = s.indexOf('.');
      const tableRaw = s.slice(0, dotIndex).trim();
      const colsRaw = s.slice(dotIndex + 1).trim();

      return `${sanitize(tableRaw)}.${normalizeRefColumns(colsRaw)}`;
    }

    return normalizeRefColumns(s);
  }

  function normalizeRefColumns(colsRaw) {
    const s = String(colsRaw || '').trim();
    if (!s) return '';

    if (s.startsWith('(') && s.endsWith(')')) {
      const inner = s.slice(1, -1).trim();
      const parts = splitByCommaRespectingParens(inner).map(x => sanitize(x));
      return `(${parts.join(', ')})`;
    }

    return sanitize(s);
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

  function normalizeCheckExpr(exprRaw) {
    const e = String(exprRaw || '').trim();
    if (!e) return '``';
    if (e.startsWith('`') && e.endsWith('`')) return e;
    return `\`${e}\``;
  }

  function normalizeWhereExpr(whereRaw) {
    const w = String(whereRaw || '').trim();
    if (!w) return '';
    if (w.startsWith('`') && w.endsWith('`')) return w;
    return `\`${w}\``;
  }

  function escapeSingleQuotes(s) {
    return String(s).replace(/'/g, "\\'");
  }

  function escapeHtml(s) {
    return String(s)
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;');
  }

  function buildIndexColumnMap(headerRow) {
    const map = {};
    headerRow.forEach((col, idx) => {
      const h = String(col || '').trim().toLowerCase();
      if (!h) return;

      if (h === 'index name') map.name = idx;
      if (h.includes('field')) map.expr = idx;
      if (h === 'type') map.type = idx;
      if (h === 'where') map.where = idx;
      if (h.includes('constraint')) map.constraint = idx;
      if (h === 'functions' || h === 'function') map.functions = idx;
    });
    return map;
  }

  function buildRefColumnMap(headerRow) {
    const map = {};
    headerRow.forEach((col, idx) => {
      const h = String(col || '').trim().toLowerCase();
      if (!h) return;

      if (h === 'ref name') map.name = idx;
      if (h === 'source') map.source = idx;
      if (h === 'target') map.target = idx;
    });
    return map;
  }

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

    if (base.startsWith('`')) return base;

    let items = [];

    if (base.startsWith('(') && base.endsWith(')')) {
      const inner = base.slice(1, -1).trim();
      items = splitByCommaRespectingParens(inner);
    } else if (base.includes(',')) {
      items = splitByCommaRespectingParens(base);
    } else {
      items = [base];
    }

    const fRaw = String(functionsRaw || '').trim();
    if (!fRaw) {
      if (items.length > 1) return `(${items.map(s => s.trim()).join(', ')})`;
      return items[0].trim();
    }

    const fParts = splitByCommaRespectingParens(fRaw);
    const applyToAll = fParts.length === 1 && items.length > 1;

    const outItems = items.map((it, idx) => {
      const col = it.trim();
      const pat = (applyToAll ? fParts[0] : (fParts[idx] ?? '')).trim();

      if (!pat) return col;

      if (!pat.includes('{col}')) {
        const p = pat.trim();
        const m = p.match(/^([a-zA-Z_][a-zA-Z0-9_]*)\((.+)\)$/);
        if (m) {
          const outer = m[1];
          const inner = m[2].trim();
          const innerApplied = applyWrapperChain(inner, col);
          return `${outer}(${innerApplied})`;
        }

        return `${p}(${col})`;
      }

      return pat.replace(/\{col\}/g, col);
    });

    return outItems.length > 1
      ? `(${outItems.join(', ')})`
      : outItems[0];
  }

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

    if (chain.includes('{col}')) return chain.replace(/\{col\}/g, col);

    const m = chain.match(/^([a-zA-Z_][a-zA-Z0-9_]*)\((.+)\)$/);
    if (m) {
      const outer = m[1];
      const inner = m[2].trim();
      return `${outer}(${applyWrapperChain(inner, col)})`;
    }

    return `${chain}(${col})`;
  }

  return {
    onOpen,
    export: exportDBML,
    exportCurrentSheet: exportCurrentSheetDBML,
    exportCurrentSheetTablesOnly: exportCurrentSheetTablesOnlyDBML
  };
})();

// Global wrappers for menu callbacks
function exportDBML() {
  ChartDB_DBMLExport.export();
}

function exportCurrentSheetDBML() {
  ChartDB_DBMLExport.exportCurrentSheet();
}

function exportCurrentSheetTablesOnlyDBML() {
  ChartDB_DBMLExport.exportCurrentSheetTablesOnly();
}