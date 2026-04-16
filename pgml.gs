/**
 * PGML Exporter
 * - Reads the same spreadsheet structure as dbml.gs
 * - Emits native PGML with VersionSet / Workspace / Version / Snapshot
 * - Includes enums, sequences, tables, refs, constraints, functions, procedures, triggers, and table groups
 */

const ChartDB_PGMLExport = (() => {
  let tables = new Map();
  let enumsMap = new Map();
  let tableGroups = new Map();
  let refs = [];
  let sequences = new Map();
  let functions = [];
  let procedures = [];
  let triggers = [];

  function exportPGML() {
    buildAndShowPGML({
      currentSheetOnly: false,
      includeEnums: true,
      includeTableGroups: true,
      includeExtraExecutableSheets: true
    });
  }

  function exportCurrentSheetPGML() {
    buildAndShowPGML({
      currentSheetOnly: true,
      includeEnums: true,
      includeTableGroups: true,
      includeExtraExecutableSheets: false
    });
  }

  function exportCurrentSheetTablesOnlyPGML() {
    buildAndShowPGML({
      currentSheetOnly: true,
      includeEnums: false,
      includeTableGroups: false,
      includeExtraExecutableSheets: false
    });
  }

  function buildAndShowPGML({ currentSheetOnly, includeEnums, includeTableGroups, includeExtraExecutableSheets }) {
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const activeSheet = ss.getActiveSheet();
    const exportedAt = new Date().toISOString();
    const documentName = sanitizeVersionSetName(ss.getName() || 'Spreadsheet Export');
    const versionId = 'v_initial';
    const viewId = 'view_default';

    resetState();
    loadEnums(ss);

    let sheets = ss.getSheets().filter(sheet => !isSpecialNonTableSheet(sheet.getName()));

    if (currentSheetOnly) {
      if (!activeSheet || isSpecialNonTableSheet(activeSheet.getName())) {
        SpreadsheetApp.getUi().alert('The active sheet is not a table sheet. Please select a table sheet first.');
        return;
      }
      sheets = [activeSheet];
    }

    sheets.forEach(parseTableSheet);

    if (!currentSheetOnly && includeExtraExecutableSheets) {
      loadExecutableSheets(ss);
    }

    const snapshot = buildSnapshot({
      includeEnums,
      includeTableGroups
    });

    const pgml = buildVersionSetDocument({
      documentName,
      exportedAt,
      versionId,
      viewId,
      snapshot
    });

    let fileName = 'export.pgml';
    let dialogTitle = 'PGML Export (All Sheets)';

    if (currentSheetOnly && includeEnums && includeTableGroups) {
      fileName = `${sanitize(activeSheet.getName())}.pgml`;
      dialogTitle = 'PGML Export (Current Sheet)';
    } else if (currentSheetOnly && !includeEnums && !includeTableGroups) {
      fileName = `${sanitize(activeSheet.getName())}_tables_only.pgml`;
      dialogTitle = 'PGML Export (Current Sheet, Tables Only)';
    } else if (currentSheetOnly) {
      fileName = `${sanitize(activeSheet.getName())}_partial.pgml`;
      dialogTitle = 'PGML Export (Current Sheet)';
    }

    const encodedPGML = encodeURIComponent(pgml);
    const htmlOutput = HtmlService.createHtmlOutput(`
      <textarea style="width:100%; height:400px;">${escapeHtml(pgml)}</textarea>
      <br/>
      <a href="data:text/plain;charset=utf-8,${encodedPGML}" download="${fileName}"
        style="display:inline-block;padding:8px 12px;background:#1a73e8;color:#fff;text-decoration:none;border-radius:4px;">
        ⬇ Download PGML
      </a>
    `).setWidth(760).setHeight(520);

    SpreadsheetApp.getUi().showModalDialog(htmlOutput, dialogTitle);
  }

  function resetState() {
    tables.clear();
    enumsMap.clear();
    tableGroups.clear();
    refs = [];
    sequences.clear();
    functions = [];
    procedures = [];
    triggers = [];
  }

  function loadEnums(ss) {
    const enumsSheet = ss.getSheetByName('Enums');
    if (!enumsSheet) return;

    const data = enumsSheet.getDataRange().getValues();
    let currentEnum = null;
    let values = [];

    data.forEach((row) => {
      const cell = (row[0] || '').toString().trim();
      if (!cell) return;

      if (/^[A-Z]/.test(cell)) {
        if (currentEnum) {
          enumsMap.set(currentEnum, values);
        }
        currentEnum = normalizeTypeName(cell);
        values = [];
      } else {
        values.push(sanitizeEnumValue(cell));
      }
    });

    if (currentEnum) {
      enumsMap.set(currentEnum, values);
    }
  }

  function parseTableSheet(sheet) {
    const sheetName = sheet.getName();
    const groupName = sanitize(sheetName);

    if (!tableGroups.has(groupName)) {
      tableGroups.set(groupName, new Set());
    }

    const groupSet = tableGroups.get(groupName);
    const data = sheet.getDataRange().getValues();
    let currentTableKey = null;
    let mode = null;
    let indexColMap = null;
    let checkColMap = null;
    let refColMap = null;

    for (let i = 0; i < data.length; i++) {
      const row = data[i];
      const firstCell = String(row[0] || '').trim();

      if (!firstCell) {
        if (mode === 'fields' && currentTableKey && tables.get(currentTableKey).fields.length > 0) {
          const continuation = String(row[6] || '').trim();
          if (continuation) {
            const table = tables.get(currentTableKey);
            const lastField = table.fields[table.fields.length - 1];
            lastField.description += '\n' + continuation;
          }
        }
        continue;
      }

      if (
        row.filter(c => String(c).trim() !== '').length === 1 &&
        i + 1 < data.length &&
        String(data[i + 1][0] || '').toLowerCase().includes('logical')
      ) {
        const normalizedTableName = normalizeTableName(firstCell);

        if (!tables.has(normalizedTableName)) {
          tables.set(normalizedTableName, {
            name: normalizedTableName,
            groupName,
            fields: [],
            indexes: [],
            constraints: [],
            refs: [],
            _fieldSet: new Set(),
            _indexSet: new Set(),
            _constraintSet: new Set(),
            _refSet: new Set()
          });
        }

        currentTableKey = normalizedTableName;
        groupSet.add(normalizedTableName);
        mode = 'fields';
        indexColMap = null;
        checkColMap = null;
        refColMap = null;
        i++;
        continue;
      }

      if (!currentTableKey) continue;

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

      const table = tables.get(currentTableKey);

      if (mode === 'indexes') {
        parseIndexRow(table, row, indexColMap);
        continue;
      }

      if (mode === 'checks') {
        parseCheckRow(table, row, checkColMap);
        continue;
      }

      if (mode === 'refs') {
        parseRefRow(table, row, refColMap);
        continue;
      }

      if (mode !== 'fields') continue;

      parseFieldRow(table, row);
    }
  }

  function parseIndexRow(table, row, indexColMap) {
    const indexName = String(row[indexColMap?.name ?? 0] || '').trim();
    const indexFieldRaw = String(row[indexColMap?.expr ?? 1] || '').trim();
    const indexTypeRaw = String(row[indexColMap?.type ?? 2] || '').trim();
    const whereRaw = String(row[indexColMap?.where ?? -1] || '').trim();
    const constraintRaw = String(row[indexColMap?.constraint ?? 5] || '').trim();
    const functionsRaw = String(row[indexColMap?.functions ?? -1] || '').trim();

    if (!indexName && !indexFieldRaw) return;

    const indexKey = [
      indexName,
      indexFieldRaw,
      indexTypeRaw,
      whereRaw,
      functionsRaw,
      constraintRaw
    ].join('|');

    if (table._indexSet.has(indexKey)) return;

    table._indexSet.add(indexKey);
    table.indexes.push({
      name: sanitize(indexName),
      expr: indexFieldRaw,
      type: indexTypeRaw,
      where: whereRaw,
      functions: functionsRaw,
      constraint: constraintRaw
    });
  }

  function parseCheckRow(table, row, checkColMap) {
    const checkName = String(row[checkColMap?.name ?? 0] || '').trim();
    const checkExpr = String(row[checkColMap?.expr ?? 5] || '').trim();

    if (!checkName || !checkExpr) return;

    const line = `Constraint ${sanitize(checkName)}: ${normalizeConstraintExpr(checkExpr)}`;
    if (table._constraintSet.has(line)) return;

    table._constraintSet.add(line);
    table.constraints.push(line);
  }

  function parseRefRow(table, row, refColMap) {
    const refName = String(row[refColMap?.name ?? 0] || '').trim();
    const sourceRaw = String(row[refColMap?.source ?? 1] || '').trim();
    const targetRaw = refColMap?.target != null ? String(row[refColMap.target] || '').trim() : '';

    if (!sourceRaw || !targetRaw) return;

    const actions = extractRowRefActions(row, refColMap);
    const source = parseRefEndpoint(sourceRaw, table.name);
    const target = parseRefEndpoint(targetRaw, null);
    if (!source || !target) return;

    if (refName || source.columns.length > 1 || target.columns.length > 1) {
      const line = buildForeignKeyConstraintLine(refName, source, target, actions);
      if (!table._constraintSet.has(line)) {
        table._constraintSet.add(line);
        table.constraints.push(line);
      }
      return;
    }

    const refLine = buildTopLevelRefLine(source, target, actions);
    const refKey = `${table.name}|${refLine}`;
    if (table._refSet.has(refKey)) return;

    table._refSet.add(refKey);
    refs.push(refLine);
  }

  function parseFieldRow(table, row) {
    const logicalName = String(row[0] || '').trim();
    const optional = String(row[2] || '').trim().toUpperCase();
    const typeRaw = String(row[3] || '').trim();
    const relationRaw = String(row[4] || '').trim();
    const constraintsRaw = String(row[5] || '').trim();
    const description = String(row[6] || '').trim();

    if (!logicalName) return;

    const fieldName = sanitizeColumnName(logicalName);
    const fieldType = normalizeFieldType(typeRaw, relationRaw);
    const settings = [];

    if (fieldName.toLowerCase() === 'id') settings.push('pk');
    if (optional === 'N') settings.push('not null');
    settings.push(...parseFieldConstraintsToSettings(constraintsRaw));

    const fieldKey = `${fieldName}|${fieldType}|${settings.join(',')}|${description}`;
    if (!table._fieldSet.has(fieldKey)) {
      table._fieldSet.add(fieldKey);
      table.fields.push({
        name: fieldName,
        type: fieldType,
        settings,
        description
      });
    }

    maybeInferSequence(table.name, fieldName, settings);

    if (relationRaw && relationRaw.toLowerCase().startsWith('foreignkey')) {
      const relation = parseForeignKeyRelation(relationRaw, table.name, fieldName);
      if (!relation) return;

      if (relation.constraintLine) {
        if (!table._constraintSet.has(relation.constraintLine)) {
          table._constraintSet.add(relation.constraintLine);
          table.constraints.push(relation.constraintLine);
        }
        return;
      }

      const refKey = `${table.name}|${relation.refLine}`;
      if (table._refSet.has(refKey)) return;

      table._refSet.add(refKey);
      refs.push(relation.refLine);
    }
  }

  function loadExecutableSheets(ss) {
    const values = loadExecutableBlocks(ss, [
      'functions',
      'functions.csv',
      'Functions',
      'Functions.csv'
    ]);

    values.forEach(block => {
      if (block.kind === 'function') functions.push(block);
      if (block.kind === 'procedure') procedures.push(block);
    });

    triggers = loadExecutableBlocks(ss, [
      'triggers',
      'triggers.csv',
      'Triggers',
      'Triggers.csv'
    ]).filter(block => block.kind === 'trigger');
  }

  function loadExecutableBlocks(ss, candidateNames) {
    const sheet = findSheetByAnyName(ss, candidateNames);
    if (!sheet) return [];

    const values = sheet.getDataRange().getDisplayValues();
    if (!values || !values.length) return [];

    const rows = values
      .map(row => {
        const cells = row.map(cell => String(cell || ''));
        while (cells.length && cells[cells.length - 1].trim() === '') {
          cells.pop();
        }
        return cells;
      })
      .filter(row => row.some(cell => cell.trim() !== ''));

    if (!rows.length) return [];

    const results = [];
    let startIndex = 0;

    if (looksLikeExecutableHeader(rows[0])) {
      startIndex = 1;
    }

    for (let i = startIndex; i < rows.length; i++) {
      const row = rows[i];
      const sql = rowToExecutableSql(row);
      if (!sql) continue;

      const block = parseExecutableBlock(sql, row[0] || '');
      if (block) results.push(block);
    }

    return results;
  }

  function buildSnapshot({ includeEnums, includeTableGroups }) {
    let output = '';

    output += '      // Exported from Google Sheets.\n';
    output += '      // This PGML keeps schema objects, executable objects, and inferred sequence ownership.\n\n';

    if (includeEnums) {
      enumsMap.forEach((values, enumName) => {
        output += `      Enum ${enumName} {\n`;
        values.forEach(value => {
          output += `        ${value}\n`;
        });
        output += '      }\n\n';
      });
    }

    Array.from(sequences.values())
      .sort((a, b) => a.name.localeCompare(b.name))
      .forEach(seq => {
        output += `      Sequence ${seq.name} {\n`;
        if (seq.ownedBy) {
          output += `        owned_by: ${seq.ownedBy}\n`;
        }
        output += '      }\n\n';
      });

    Array.from(tables.values()).forEach(table => {
      output += `      Table ${table.name} in ${table.groupName} {\n`;

      table.fields.forEach(field => {
        output += `        ${field.name} ${field.type}`;
        if (field.settings.length) {
          output += ` [${field.settings.join(', ')}]`;
        }
        if (field.description) {
          const safeDescription = field.description.replace(/\*\//g, '* /');
          if (safeDescription.includes('\n')) {
            output += ` /*\n${indentBlock(safeDescription, 10)}\n        */`;
          } else {
            output += ` // ${safeDescription}`;
          }
        }
        output += '\n';
      });

      if (!table.fields.some(field => field.name === '_deleted')) {
        output += `        _deleted boolean [not null, default: false]\n`;
      }

      if (table.constraints.length || table.indexes.length) {
        output += '\n';
      }

      table.constraints.forEach(line => {
        output += `        ${line}\n`;
      });

      table.indexes.forEach(index => {
        const expr = normalizeIndexExprWithFunctions(index.expr, index.functions);
        const attrs = [];
        if (index.type) attrs.push(`type: ${index.type.trim().toLowerCase()}`);
        if (index.where) attrs.push(`where: ${normalizeWhereExpr(index.where)}`);

        output += `        Index ${index.name} ${formatIndexExpr(expr)}`;
        if (attrs.length) output += ` [${attrs.join(', ')}]`;
        output += '\n';
      });

      output += '      }\n\n';
    });

    dedupePreserveOrder(refs).forEach(refLine => {
      output += `      ${refLine}\n`;
    });

    if (refs.length) {
      output += '\n';
    }

    functions.forEach(block => {
      output += renderExecutableBlock(block);
      output += '\n';
    });

    procedures.forEach(block => {
      output += renderExecutableBlock(block);
      output += '\n';
    });

    triggers.forEach(block => {
      output += renderExecutableBlock(block);
      output += '\n';
    });

    if (includeTableGroups) {
      tableGroups.forEach((members, groupName) => {
        const tablesInGroup = Array.from(members).filter(Boolean);
        if (!tablesInGroup.length) return;

        output += `      TableGroup ${groupName} {\n`;
        tablesInGroup.forEach(tableName => {
          output += `        ${tableName}\n`;
        });
        output += '      }\n\n';
      });
    }

    return output.replace(/\s+$/, '');
  }

  function renderExecutableBlock(block) {
    let output = '';

    if (block.kind === 'function') {
      output += `      Function ${block.name}(${block.args}) returns ${block.returns}${block.replace ? ' [replace]' : ''} {\n`;
    } else if (block.kind === 'procedure') {
      output += `      Procedure ${block.name}(${block.args})${block.replace ? ' [replace]' : ''} {\n`;
    } else {
      output += `      Trigger ${block.name} on ${block.onTable} {\n`;
    }

    if (block.language) {
      output += `        language: ${block.language}\n\n`;
    }

    output += '        source: $sql$\n';
    output += indentBlock(block.sql, 10) + '\n';
    output += '        $sql$\n';
    output += '      }\n';

    return output;
  }

  function buildVersionSetDocument({ documentName, exportedAt, versionId, viewId, snapshot }) {
    return [
      `VersionSet "${escapeDoubleQuotes(documentName)}" {`,
      '',
      '  Workspace {',
      `    based_on: ${versionId}`,
      `    updated_at: "${exportedAt}"`,
      `    active_view: ${viewId}`,
      '',
      '    Snapshot {',
      snapshot,
      '    }',
      '',
      '    View "Default" {',
      `      id: ${viewId}`,
      '    }',
      '  }',
      '',
      `  Version ${versionId} {`,
      '    name: "Initial import"',
      '    role: design',
      `    created_at: "${exportedAt}"`,
      `    active_view: ${viewId}`,
      '',
      '    Snapshot {',
      snapshot,
      '    }',
      '',
      '    View "Default" {',
      `      id: ${viewId}`,
      '    }',
      '  }',
      '',
      '}',
      ''
    ].join('\n');
  }

  function parseForeignKeyRelation(relationRaw, currentTableName, fieldName) {
    let spec = String(relationRaw || '').trim().replace(/^foreignkey\s*,?/i, '').trim();
    if (!spec) return null;

    const actions = extractRefActions(spec);
    spec = actions.cleaned;

    if (spec.includes('>')) {
      const parts = spec.split('>');
      if (parts.length !== 2) return null;

      const source = parseRefEndpoint(parts[0], currentTableName);
      const target = parseRefEndpoint(parts[1], null);
      if (!source || !target) return null;

      if (source.columns.length > 1 || target.columns.length > 1) {
        return {
          constraintLine: buildForeignKeyConstraintLine('', source, target, actions.values)
        };
      }

      return {
        refLine: buildTopLevelRefLine(source, target, actions.values)
      };
    }

    const firstToken = spec.split(',')[0].trim();
    const target = parseRefEndpoint(firstToken, null);
    if (!target) return null;

    const source = {
      table: currentTableName,
      columns: [fieldName]
    };

    if (target.columns.length > 1) {
      return {
        constraintLine: buildForeignKeyConstraintLine('', source, target, actions.values)
      };
    }

    return {
      refLine: buildTopLevelRefLine(source, target, actions.values)
    };
  }

  function parseRefEndpoint(raw, defaultTableName) {
    const value = String(raw || '').trim();
    if (!value) return null;

    let tablePart = defaultTableName;
    let columnPart = value;

    const firstDot = value.indexOf('.');
    if (firstDot !== -1) {
      tablePart = value.slice(0, firstDot).trim();
      columnPart = value.slice(firstDot + 1).trim();
    }

    if (!tablePart) return null;

    const columns = normalizeColumnList(columnPart);
    if (!columns.length) return null;

    return {
      table: normalizeTableName(tablePart),
      columns
    };
  }

  function buildForeignKeyConstraintLine(refName, source, target, actions) {
    const name = sanitize(refName || `${source.table}_${source.columns.join('_')}_fkey`);
    let line = `Constraint ${name}: foreign key (${source.columns.join(', ')}) references ${target.table} (${target.columns.join(', ')})`;
    if (actions.delete) line += ` ON DELETE ${actions.delete.toUpperCase()}`;
    if (actions.update) line += ` ON UPDATE ${actions.update.toUpperCase()}`;
    return line;
  }

  function buildTopLevelRefLine(source, target, actions) {
    const attrs = [];
    if (actions.delete) attrs.push(`delete: ${actions.delete}`);
    if (actions.update) attrs.push(`update: ${actions.update}`);

    let line = `Ref: ${source.table}.${formatRefColumns(source.columns)} > ${target.table}.${formatRefColumns(target.columns)}`;
    if (attrs.length) line += ` [${attrs.join(', ')}]`;
    return line;
  }

  function maybeInferSequence(tableName, fieldName, settings) {
    const defaultSetting = settings.find(setting => setting.startsWith('default:'));
    if (!defaultSetting) return;

    const match = defaultSetting.match(/nextval\(\s*'([^']+)'/i);
    if (!match) return;

    const sequenceName = normalizeSequenceName(match[1]);
    if (!sequenceName) return;

    if (!sequences.has(sequenceName)) {
      sequences.set(sequenceName, {
        name: sequenceName,
        ownedBy: `${tableName}.${fieldName}`
      });
    }
  }

  function parseExecutableBlock(sql, fallbackName) {
    const trimmed = String(sql || '').trim();
    if (!trimmed) return null;

    const functionMatch = trimmed.match(/create\s+(or\s+replace\s+)?function\s+([^\s(]+)\s*\(([\s\S]*?)\)\s+returns\s+(.+?)(?:\s+language\b|\s+as\b)/i);
    if (functionMatch) {
      return {
        kind: 'function',
        replace: Boolean(functionMatch[1]),
        name: normalizeExecutableName(functionMatch[2]),
        args: normalizeSignatureArgs(functionMatch[3]),
        returns: normalizeReturnType(functionMatch[4]),
        language: extractLanguage(trimmed),
        sql: trimmed
      };
    }

    const procedureMatch = trimmed.match(/create\s+(or\s+replace\s+)?procedure\s+([^\s(]+)\s*\(([\s\S]*?)\)(?:\s+language\b|\s+as\b)/i);
    if (procedureMatch) {
      return {
        kind: 'procedure',
        replace: Boolean(procedureMatch[1]),
        name: normalizeExecutableName(procedureMatch[2]),
        args: normalizeSignatureArgs(procedureMatch[3]),
        language: extractLanguage(trimmed),
        sql: trimmed
      };
    }

    const triggerMatch = trimmed.match(/create\s+trigger\s+([^\s]+)[\s\S]+?\son\s+([^\s]+)[\s\S]*$/i);
    if (triggerMatch) {
      return {
        kind: 'trigger',
        name: sanitize(stripQuotes(triggerMatch[1])) || sanitize(fallbackName),
        onTable: normalizeTableName(triggerMatch[2]),
        sql: trimmed
      };
    }

    return null;
  }

  function normalizeFieldType(typeRaw, relationRaw) {
    const rawType = String(typeRaw || '').trim();
    if (!rawType) return 'varchar';

    if (relationRaw) {
      const relLower = relationRaw.toLowerCase();
      if (relLower.startsWith('enum') || relLower.includes('base')) {
        const parts = relationRaw.split(',');
        if (parts[1]) return normalizeTypeName(parts[1]);
      }
    }

    const lowered = rawType.toLowerCase();
    if (isBuiltInPgType(lowered)) return lowered;

    const normalizedCandidate = normalizeTypeName(rawType);
    if (enumsMap.has(normalizedCandidate)) return normalizedCandidate;

    if (rawType.includes('.')) {
      const parts = rawType.split('.');
      if (parts.length === 2) {
        return `${sanitizeSchemaName(parts[0])}.${toSnakeLower(stripQuotes(parts[1]))}`;
      }
    }

    return lowered;
  }

  function normalizeTypeName(name) {
    return `public.${toSnakeLower(stripQuotes(name))}`;
  }

  function normalizeSequenceName(name) {
    const cleaned = stripQuotes(String(name || '').replace(/^public\./i, 'public.'));
    const parts = cleaned.split('.');
    if (parts.length === 2) {
      return `${sanitizeSchemaName(parts[0])}.${toSnakeLower(parts[1])}`;
    }
    return `public.${toSnakeLower(cleaned)}`;
  }

  function normalizeTableName(name) {
    const cleaned = stripQuotes(String(name || '').trim());
    const parts = cleaned.split('.');
    if (parts.length === 2) {
      return `${sanitizeSchemaName(parts[0])}.${toSnakeLower(parts[1])}`;
    }
    return `public.${toSnakeLower(cleaned)}`;
  }

  function normalizeExecutableName(name) {
    return normalizeTableName(name);
  }

  function normalizeReturnType(value) {
    return String(value || '').trim().replace(/\s+/g, ' ').toLowerCase();
  }

  function normalizeSignatureArgs(args) {
    return String(args || '').trim().replace(/\s+/g, ' ');
  }

  function normalizeColumnList(raw) {
    const value = String(raw || '').trim();
    if (!value) return [];

    if (value.startsWith('(') && value.endsWith(')')) {
      return splitByCommaRespectingParens(value.slice(1, -1)).map(sanitizeColumnName);
    }

    if (value.includes(',')) {
      return splitByCommaRespectingParens(value).map(sanitizeColumnName);
    }

    return [sanitizeColumnName(value)];
  }

  function normalizeConstraintExpr(exprRaw) {
    return String(exprRaw || '').trim().replace(/\s+/g, ' ');
  }

  function parseFieldConstraintsToSettings(constraintsRaw) {
    const value = String(constraintsRaw || '').trim();
    if (!value) return [];

    const settings = [];
    const lower = value.toLowerCase();

    if (/\bunique\b/.test(lower)) settings.push('unique');
    if (/\bnot\s*null\b/.test(lower)) settings.push('not null');
    if (/\bpk\b|\bprimary\s*key\b/.test(lower)) settings.push('pk');

    const defaultMatch = value.match(/default\s*[:=]?\s*(.+?)(?:,\s*note\s*[:=]|$)/i);
    if (defaultMatch && defaultMatch[1]) {
      settings.push(`default: ${defaultMatch[1].trim()}`);
    }

    const noteMatch = value.match(/note\s*[:=]?\s*(.+)$/i);
    if (noteMatch && noteMatch[1]) {
      settings.push(`note: '${escapeSingleQuotes(noteMatch[1].trim())}'`);
    }

    return settings;
  }

  function extractRefActions(spec) {
    const actions = {};
    let cleaned = String(spec || '').trim();

    cleaned = cleaned.replace(/,\s*delete\s*:\s*([^,\]]+)/ig, (_, action) => {
      actions.delete = normalizeAction(action);
      return '';
    });

    cleaned = cleaned.replace(/,\s*update\s*:\s*([^,\]]+)/ig, (_, action) => {
      actions.update = normalizeAction(action);
      return '';
    });

    cleaned = cleaned.replace(/,\s*on\s+delete\s+([^,\]]+)/ig, (_, action) => {
      actions.delete = normalizeAction(action);
      return '';
    });

    cleaned = cleaned.replace(/,\s*on\s+update\s+([^,\]]+)/ig, (_, action) => {
      actions.update = normalizeAction(action);
      return '';
    });

    return {
      cleaned: cleaned.trim().replace(/,\s*,/g, ',').replace(/,\s*$/, ''),
      values: actions
    };
  }

  function extractRowRefActions(row, refColMap) {
    const actions = {};
    if (refColMap?.delete != null) {
      const value = String(row[refColMap.delete] || '').trim();
      if (value) actions.delete = normalizeAction(value);
    }
    if (refColMap?.update != null) {
      const value = String(row[refColMap.update] || '').trim();
      if (value) actions.update = normalizeAction(value);
    }
    return actions;
  }

  function normalizeAction(action) {
    return String(action || '').trim().toLowerCase().replace(/\s+/g, ' ');
  }

  function normalizeWhereExpr(whereRaw) {
    const value = String(whereRaw || '').trim();
    if (!value) return '';
    if (value.startsWith('`') && value.endsWith('`')) return value;
    return `\`${value}\``;
  }

  function formatIndexExpr(expr) {
    const value = String(expr || '').trim();
    if (!value) return '(id)';
    if (value.startsWith('(') || value.startsWith('`')) return value;
    return `(${value})`;
  }

  function sanitizeVersionSetName(name) {
    return String(name || '').trim().replace(/\.ods$/i, '');
  }

  function sanitizeSchemaName(name) {
    return sanitize(name).toLowerCase() || 'public';
  }

  function sanitizeColumnName(name) {
    return sanitize(String(name || '').replace(/\./g, '_')).replace(/^_+/, '') || 'column_name';
  }

  function sanitizeEnumValue(value) {
    return String(value || '').trim().replace(/\s+/g, '').toLowerCase();
  }

  function toSnakeLower(value) {
    return String(value || '')
      .trim()
      .replace(/["']/g, '')
      .replace(/([a-z0-9])([A-Z])/g, '$1_$2')
      .replace(/([A-Z]+)([A-Z][a-z])/g, '$1_$2')
      .replace(/[\s\-\/]+/g, '_')
      .replace(/[^a-zA-Z0-9_]/g, '_')
      .replace(/_+/g, '_')
      .replace(/^_+|_+$/g, '')
      .toLowerCase();
  }

  function stripQuotes(value) {
    return String(value || '').trim().replace(/^"(.*)"$/, '$1');
  }

  function formatRefColumns(columns) {
    if (columns.length === 1) return columns[0];
    return `(${columns.join(', ')})`;
  }

  function looksLikeExecutableHeader(row) {
    const joined = row.map(cell => String(cell || '').trim().toLowerCase()).join(' | ');
    return joined.includes('function body') ||
      joined.includes('trigger reference') ||
      joined.includes('functions') ||
      joined === 'name';
  }

  function rowToExecutableSql(row) {
    const body = rowToPrettyText(row.slice(1));
    if (body && /\bcreate\s+(or\s+replace\s+)?(function|procedure|trigger)\b/i.test(body)) {
      return body;
    }

    const fallback = rowToPrettyText(row);
    if (fallback && /\bcreate\s+(or\s+replace\s+)?(function|procedure|trigger)\b/i.test(fallback)) {
      return fallback;
    }

    return '';
  }

  function rowToPrettyText(cells) {
    const parts = (cells || []).map(cell => String(cell || ''));

    while (parts.length && parts[parts.length - 1].trim() === '') {
      parts.pop();
    }

    if (!parts.length) return '';

    const nonEmpty = parts.filter(x => x.trim() !== '');
    if (nonEmpty.length === 1) {
      return nonEmpty[0].trimRight();
    }

    const multilineParts = parts.filter(x => x.includes('\n') && x.trim() !== '');
    if (multilineParts.length) {
      return parts
        .filter(x => x.trim() !== '')
        .map((part, idx) => idx === 0 ? part.trimRight().trim() : part.trimRight())
        .join('\n');
    }

    return parts
      .filter(x => x.trim() !== '')
      .map(x => x.trim())
      .join(' ')
      .replace(/\s+/g, ' ')
      .trim();
  }

  function findSheetByAnyName(ss, candidateNames) {
    for (let i = 0; i < candidateNames.length; i++) {
      const sheet = ss.getSheetByName(candidateNames[i]);
      if (sheet) return sheet;
    }

    const normalizedWanted = candidateNames.map(normalizeLooseSheetName);
    const allSheets = ss.getSheets();

    for (let i = 0; i < allSheets.length; i++) {
      const sheet = allSheets[i];
      const normalizedActual = normalizeLooseSheetName(sheet.getName());
      if (normalizedWanted.includes(normalizedActual)) return sheet;
    }

    return null;
  }

  function normalizeLooseSheetName(name) {
    return String(name || '')
      .trim()
      .toLowerCase()
      .replace(/\s+/g, '')
      .replace(/\.csv$/i, '');
  }

  function isSpecialNonTableSheet(name) {
    const value = normalizeLooseSheetName(name);
    return value === 'enums' || value === 'triggers' || value === 'functions';
  }

  function sanitize(name) {
    return String(name || '')
      .trim()
      .replace(/\s+/g, '_')
      .replace(/[^a-zA-Z0-9_]/g, '');
  }

  function escapeSingleQuotes(value) {
    return String(value || '').replace(/'/g, "\\'");
  }

  function escapeDoubleQuotes(value) {
    return String(value || '').replace(/"/g, '\\"');
  }

  function escapeHtml(value) {
    return String(value || '')
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;');
  }

  function buildIndexColumnMap(headerRow) {
    const map = {};
    headerRow.forEach((col, idx) => {
      const header = String(col || '').trim().toLowerCase();
      if (!header) return;

      if (header === 'index name') map.name = idx;
      if (header.includes('field')) map.expr = idx;
      if (header === 'type') map.type = idx;
      if (header === 'where') map.where = idx;
      if (header.includes('constraint')) map.constraint = idx;
      if (header === 'functions' || header === 'function') map.functions = idx;
    });
    return map;
  }

  function buildRefColumnMap(headerRow) {
    const map = {};
    headerRow.forEach((col, idx) => {
      const header = String(col || '').trim().toLowerCase();
      if (!header) return;

      if (header === 'ref name') map.name = idx;
      if (header === 'source') map.source = idx;
      if (header === 'target') map.target = idx;
      if (header === 'delete' || header === 'on delete') map.delete = idx;
      if (header === 'update' || header === 'on update') map.update = idx;
    });
    return map;
  }

  function buildCheckColumnMap(headerRow) {
    const map = {};
    headerRow.forEach((col, idx) => {
      const header = String(col || '').trim().toLowerCase();
      if (!header) return;

      if (header === 'check name') map.name = idx;
      if (header.includes('constraint') || header === 'expression' || header === 'check' || header === 'where') {
        map.expr = idx;
      }
    });
    return map;
  }

  function normalizeIndexExprWithFunctions(exprRaw, functionsRaw) {
    const base = String(exprRaw || '').trim();
    if (!base) return '(id)';
    if (base.startsWith('`')) return base;

    let items = [];
    if (base.startsWith('(') && base.endsWith(')')) {
      items = splitByCommaRespectingParens(base.slice(1, -1).trim());
    } else if (base.includes(',')) {
      items = splitByCommaRespectingParens(base);
    } else {
      items = [base];
    }

    const rawFns = String(functionsRaw || '').trim();
    if (!rawFns) {
      return items.length > 1
        ? `(${items.map(item => item.trim()).join(', ')})`
        : items[0].trim();
    }

    const fnParts = splitByCommaRespectingParens(rawFns);
    const applyToAll = fnParts.length === 1 && items.length > 1;

    const outItems = items.map((item, idx) => {
      const column = item.trim();
      const pattern = (applyToAll ? fnParts[0] : (fnParts[idx] || '')).trim();
      if (!pattern) return column;

      if (!pattern.includes('{col}')) {
        const match = pattern.match(/^([a-zA-Z_][a-zA-Z0-9_]*)\((.+)\)$/);
        if (match) {
          return `${match[1]}(${applyWrapperChain(match[2].trim(), column)})`;
        }
        return `${pattern}(${column})`;
      }

      return pattern.replace(/\{col\}/g, column);
    });

    return outItems.length > 1 ? `(${outItems.join(', ')})` : outItems[0];
  }

  function splitByCommaRespectingParens(value) {
    const out = [];
    let current = '';
    let depth = 0;
    let inTicks = false;

    for (let i = 0; i < value.length; i++) {
      const ch = value[i];

      if (ch === '`') {
        inTicks = !inTicks;
        current += ch;
        continue;
      }

      if (!inTicks) {
        if (ch === '(') depth++;
        if (ch === ')') depth = Math.max(0, depth - 1);

        if (ch === ',' && depth === 0) {
          out.push(current.trim());
          current = '';
          continue;
        }
      }

      current += ch;
    }

    if (current.trim()) out.push(current.trim());
    return out;
  }

  function applyWrapperChain(chainRaw, column) {
    const chain = String(chainRaw || '').trim();
    if (!chain) return column;

    if (chain.includes('{col}')) return chain.replace(/\{col\}/g, column);

    const match = chain.match(/^([a-zA-Z_][a-zA-Z0-9_]*)\((.+)\)$/);
    if (match) {
      return `${match[1]}(${applyWrapperChain(match[2].trim(), column)})`;
    }

    return `${chain}(${column})`;
  }

  function extractLanguage(sql) {
    const match = String(sql || '').match(/\blanguage\s+([a-zA-Z_][a-zA-Z0-9_]*)/i);
    return match ? match[1].toLowerCase() : '';
  }

  function isBuiltInPgType(value) {
    if (/^varchar\s*\(\s*\d+\s*\)$/.test(value)) return true;
    if (/^character varying\s*\(\s*\d+\s*\)$/.test(value)) return true;
    if (/^char\s*\(\s*\d+\s*\)$/.test(value)) return true;
    if (/^character\s*\(\s*\d+\s*\)$/.test(value)) return true;
    if (/^(numeric|decimal)\s*\(\s*\d+\s*(,\s*\d+\s*)?\)$/.test(value)) return true;
    if (/^timestamp\s*(with(out)?\s+time\s+zone)?$/.test(value)) return true;
    if (/^time\s*(with(out)?\s+time\s+zone)?$/.test(value)) return true;
    if (/^bit\s*\(\s*\d+\s*\)$/.test(value)) return true;
    if (/^varbit\s*\(\s*\d+\s*\)$/.test(value)) return true;

    return new Set([
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
    ]).has(value);
  }

  function dedupePreserveOrder(items) {
    const seen = new Set();
    const out = [];

    items.forEach(item => {
      if (seen.has(item)) return;
      seen.add(item);
      out.push(item);
    });

    return out;
  }

  function indentBlock(text, spaces) {
    const indent = ' '.repeat(spaces);
    return String(text || '')
      .split('\n')
      .map(line => line ? indent + line : '')
      .join('\n');
  }

  return {
    export: exportPGML,
    exportCurrentSheet: exportCurrentSheetPGML,
    exportCurrentSheetTablesOnly: exportCurrentSheetTablesOnlyPGML
  };
})();

function exportPGML() {
  ChartDB_PGMLExport.export();
}

function exportCurrentSheetPGML() {
  ChartDB_PGMLExport.exportCurrentSheet();
}

function exportCurrentSheetTablesOnlyPGML() {
  ChartDB_PGMLExport.exportCurrentSheetTablesOnly();
}
