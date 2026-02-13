const ChartDB_DBMLExport = (() => {
  let tables = new Map(); // tableName -> { fields: [], refs: [] }
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

      data.forEach((row, idx) => {
        const cell = (row[0] || '').toString().trim();
        if (!cell) return;

        // Detect start of a new enum by assuming any row with text and no indent
        if (/^[A-Z]/.test(cell)) {
          // Save previous enum
          if (currentEnum) enumsMap.set(currentEnum, values);

          // Start new enum
          currentEnum = sanitizeEnumName(cell);
          values = [];
        } else {
          // It's a value row
          values.push(cell);
        }
      });

      // Save last enum
      if (currentEnum) enumsMap.set(currentEnum, values);
    }

    // --- 2. Process all sheets as tables ---
    const sheets = ss.getSheets();
    sheets.forEach(sheet => {
      if (sheet.getName() === "Enums") return; // skip enums sheet

      const sheetName = sanitize(sheet.getName());
      const data = sheet.getDataRange().getValues();
      let table = null;

      for (let i = 0; i < data.length; i++) {
        const row = data[i];
        const firstCell = String(row[0] || '').trim();
        if (!firstCell) {
          // Possible multiline description continuation
          if (table && tables.get(table).fields.length > 0) {
            const continuation = String(row[6] || '').trim();
            if (continuation) {
              const lastField = tables.get(table).fields[tables.get(table).fields.length - 1];
              lastField.description += '\n' + continuation;
            }
          }
          continue;
        }

        // Detect table header row
        if (
          row.filter(c => String(c).trim() !== '').length === 1 &&
          i + 1 < data.length &&
          String(data[i + 1][0]).toLowerCase().includes('logical')
        ) {
          table = firstCell;
          if (!tables.has(table)) tables.set(table, { fields: [], refs: [] });
          i++; // skip header row
          continue;
        }

        if (!table) continue;
        if (firstCell.toLowerCase() === 'logical name') continue;

        const logicalName = firstCell;
        const fieldName = String(row[1] || '').trim();
        const optional = String(row[2] || '').trim().toUpperCase();
        const typeRaw = String(row[3] || '').trim();
        const relationRaw = String(row[4] || '').trim();
        const constraints = String(row[5] || '').trim();
        const description = String(row[6] || '').trim();

        let fieldType = mapTypeExact(typeRaw);

        // --- Handle enums/base types ---
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

        tables.get(table).fields.push({ 
          name: logicalName, 
          type: fieldType, 
          settings,
          description
        });

        // --- Only generate Ref if it is a ForeignKey ---
        if (relationRaw && relationRaw.toLowerCase().startsWith('foreignkey')) {
          const target = relationRaw.split(',')[1].trim(); // "TableName.field"
          const parts = target.split('.');
          const targetTable = sanitize(parts[0]);
          const targetCol = parts[1] || "id";
          tables.get(table).refs.push(`Ref: ${sanitize(table)}.${sanitize(logicalName)} > ${targetTable}.${targetCol}`);
        }
      }
    });

    // --- 3. Build DBML ---
    let dbml = '';

    // Output enums first
    enumsMap.forEach((values, name) => {
      dbml += `Enum ${name} {\n  ${values.join("\n  ")}\n}\n\n`;
    });

    // Then tables + refs
    tables.forEach((table, tableName) => {
      dbml += `Table ${sanitize(tableName)} {\n`;
      table.fields.forEach(f => {
        dbml += `  ${sanitize(f.name)} ${f.type}`;
        if (f.settings.length) dbml += ` [${f.settings.join(', ')}]`;
        if (f.description) {
          const safeDescription = f.description.replace(/\*\//g, '* /');

          if (safeDescription.includes('\n')) {
            // Multiline comment
            dbml += ` /*\n${safeDescription}\n  */`;
          } else {
            // Single line comment
            dbml += ` // ${safeDescription}`;
          }
        }
        dbml += '\n';
      });
      dbml += '}\n';
      if (table.refs.length) dbml += table.refs.join('\n') + '\n';
      dbml += '\n';
    });

    // --- 4. Output dialog ---
    const encodedDBML = encodeURIComponent(dbml);
    const htmlOutput = HtmlService.createHtmlOutput(`
      <textarea style="width:100%; height:400px;">${dbml}</textarea>
      <br/>
      <a href="data:text/plain;charset=utf-8,${encodedDBML}" download="export.dbml"
        style="display:inline-block;padding:8px 12px;background:#1a73e8;color:#fff;text-decoration:none;border-radius:4px;">
        ⬇ Download DBML
      </a>
    `).setWidth(700).setHeight(500);

    SpreadsheetApp.getUi().showModalDialog(htmlOutput, 'DBML Export');
  }

  function sanitize(name) {
    return String(name).trim().replace(/\s+/g, '_').replace(/[^a-zA-Z0-9_]/g, '');
  }

  function sanitizeEnumName(name) {
    return name.replace(/\s+/g, '_').replace(/[^a-zA-Z0-9_]/g, '');
  }

  function mapTypeExact(type) {
    if (!type) return 'varchar';
    const t = type.toLowerCase();
    if (t.startsWith('bigint')) return 'bigint';
    if (t.startsWith('int')) return 'int';
    if (t.startsWith('varchar')) return 'varchar';
    if (t.startsWith('text')) return 'text';
    if (t.startsWith('date')) return 'date';
    if (t.startsWith('timestamp') || t.startsWith('datetime')) return 'timestamp';
    if (t.startsWith('boolean') || t.startsWith('bool')) return 'boolean';
    if (t.startsWith('decimal') || t.startsWith('numeric')) return t;
    return 'varchar';
  }

  return { onOpen, export: exportDBML };
})();
