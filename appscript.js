/**
 * GENERATE CHARTDB JSON (Strict Schema Compliance)
 * Reference: ChartDB(Diagram 1).json
 */

// Configuration
const CONFIG = {
  tableWidth: 450,
  spacingX: 500,
  spacingY: 60,
  tablesPerRow: 5
};

// Global State
let globalIdCounter = 1;
const tables = [];
const relationships = [];
const customTypes = [];
const areas = [];
const tableMap = new Map(); // Name -> {id, schema, fields: Map<Name, ID>}

// Constants for Schema Compliance
const NOW_ISO = new Date().toISOString();
const NOW_EPOCH = Date.now(); // Internal objects use Epoch Integer

function tableKey(schema, table) {
  return `${schema}.${table}`;
}

function onOpen() {
  SpreadsheetApp.getUi()
    .createMenu('ChartDB')
    .addItem('Generate JSON', 'generateChartDBJson')
    .addToUi();
}

function generateChartDBJson() {
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  const sheets = ss.getSheets();

  // Reset State
  globalIdCounter = 1;
  tables.length = 0;
  relationships.length = 0;
  customTypes.length = 0;
  areas.length = 0;
  tableMap.clear();

  let areaX = 0;
  let processedSheets = [];

  // --- 1. FIRST PASS: Create Tables, Enums, and Areas ---
  sheets.forEach(sheet => {
    const sheetName = sheet.getName();
    const tabColor = sheet.getTabColor();
    const isEnumSheet = sheetName.toLowerCase().includes("enum");

    // Filter: Skip tabs with no color (unless it's the specific Enums tab)
    if (tabColor === null && !isEnumSheet) {
      return;
    }

    processedSheets.push(sheetName);

    if (isEnumSheet) {
      parseEnumSheet(sheet);
    } 
    else {
      // Create Area
      const areaId = getNextId();
      areas.push({
        id: areaId,
        name: sheetName,
        color: tabColor || "#e1e1e1", 
        x: areaX,
        y: 0,
        width: CONFIG.tableWidth * 2, 
        height: 2000,
        createdAt: NOW_EPOCH // Schema requirement
      });

      parseTableSheet(sheet, sheetName, areaId, tabColor);
      areaX += (CONFIG.tableWidth + 100) * 2; 
    }
  });

  // --- 2. SECOND PASS: Link Foreign Keys ---
  processRelationships();

  // --- 3. GENERATE OUTPUT ---
  const output = {
    id: "0",
    name: ss.getName() || "Imported Schema",
    databaseType: "postgresql",
    tables: tables,
    relationships: relationships,
    areas: areas,
    customTypes: customTypes,
    notes: [], // Required empty array if unused
    subjectAreas: [], // Required empty array if unused
    createdAt: NOW_ISO, // Root uses ISO String
    updatedAt: NOW_ISO  // Root uses ISO String
  };

  const jsonString = JSON.stringify(output, null, 2);

  const fileName = `${(ss.getName() || "chartdb-export").replace(/\s+/g, "_")}.json`;
  const encodedJson = encodeURIComponent(jsonString);
  
  const htmlOutput = HtmlService.createHtmlOutput(
    `<p><strong>Processed Sheets:</strong> ${processedSheets.join(", ")}</p>
     <textarea style="width:100%; height:300px;">${jsonString}</textarea>
     <div style="margin-top:12px;">
        <a
          href="data:application/json;charset=utf-8,${encodedJson}"
          download="${fileName}"
          style="
            display:inline-block;
            padding:8px 12px;
            background:#1a73e8;
            color:#fff;
            text-decoration:none;
            border-radius:4px;
            font-weight:500;
          "
        >
          ⬇ Download JSON
        </a>
      </div>`
  ).setWidth(600).setHeight(500);
  
  SpreadsheetApp.getUi().showModalDialog(htmlOutput, 'ChartDB JSON Output');
}

/**
 * Parses a standard table sheet
 */
function parseTableSheet(sheet, schemaName, areaId, areaColor) {
  const data = sheet.getDataRange().getValues();
  const backgrounds = sheet.getDataRange().getBackgrounds();
  
  let currentTable = null;
  let layoutIndex = 0;

  for (let i = 0; i < data.length; i++) {
    const row = data[i];
    const bg = backgrounds[i][0];
    const firstCell = String(row[0]).trim();

    // DETECTION: New Table if row is colored (and not white)
    if (bg !== '#ffffff' && firstCell && !isHeaderRow(row)) {
      
      if (currentTable) saveTable(currentTable);

      const tableName = firstCell;
      const tableId = getNextId();
      
      // Layout calculation
      const posX = (layoutIndex % CONFIG.tablesPerRow) * CONFIG.spacingX;
      const posY = Math.floor(layoutIndex / CONFIG.tablesPerRow) * CONFIG.spacingY * 8; 
      layoutIndex++;

      currentTable = {
        id: tableId,
        name: tableName,
        schema: schemaName, 
        color: areaColor,
        x: posX,
        y: posY,
        width: CONFIG.tableWidth,
        fields: [],
        indexes: [],
        rawRelationships: [],
        isView: false,
        createdAt: NOW_EPOCH,
        updatedAt: NOW_EPOCH
      };

      // Store schemaName in map for relationship lookup later
      tableMap.set(
        tableKey(schemaName, tableName),
        { id: tableId, schema: schemaName, fields: new Map() }
      );
      continue;
    }

    if (!currentTable || !firstCell) continue;
    if (isHeaderRow(row)) continue;

    // --- FIELD PARSING ---
    // 0: Logical Name, 1: Optional, 2: Field Type, 3: Relation, 4: Constraints, 5: Description
    const fieldName = row[0];
    const optionalFlag = String(row[1]).toUpperCase(); 
    const fieldTypeRaw = String(row[2]);               
    const relationRaw = String(row[3]);                
    const description = row[5] || "";

    const isRequired = optionalFlag.includes('N'); 
    const isPk = fieldName.toLowerCase() === 'id'; 
    const fieldId = getNextId();
    
    const typeObj = mapTypeToChartDB(fieldTypeRaw);

    const fieldObj = {
      id: fieldId,
      name: fieldName,
      type: typeObj,
      primaryKey: isPk,
      unique: isPk,
      nullable: !isRequired && !isPk,
      increment: false, // Required by schema
      default: "",      // Required by schema
      comment: description,
      createdAt: NOW_EPOCH
    };

    currentTable.fields.push(fieldObj);
    tableMap.get(tableKey(schemaName, currentTable.name)).fields.set(fieldName, fieldId);

    // Store FK info for Pass 2
    if (relationRaw && relationRaw.toLowerCase().includes('foreignkey')) {
      const parts = relationRaw.split(',');
      if (parts.length > 1) {
        const rawTarget = parts[1].trim();

        // Split table + field
        const [targetTableName, targetFieldName = 'id'] = rawTarget.split('.');

        currentTable.rawRelationships.push({
          sourceFieldId: fieldId,
          targetTableName: targetTableName.trim(),
          targetFieldName: targetFieldName.trim()
        });
      }
    }
  }
  if (currentTable) saveTable(currentTable);
}

/**
 * Parses the Enums sheet
 */
function parseEnumSheet(sheet) {
  const data = sheet.getDataRange().getValues();
  const backgrounds = sheet.getDataRange().getBackgrounds();

  let currentEnum = null;

  for (let i = 0; i < data.length; i++) {
    const row = data[i];
    const bg = backgrounds[i][0];
    const cellVal = String(row[0]).trim();

    // Trigger: Colored row = Enum Name
    if (bg !== '#ffffff' && cellVal) {
      if (currentEnum) customTypes.push(currentEnum);

      currentEnum = {
        id: getNextId(),
        name: cellVal,
        kind: "enum",
        values: [],
        fields: [],
        createdAt: NOW_EPOCH
      };
    } 
    else if (currentEnum && cellVal) {
      currentEnum.values.push(cellVal);
    }
  }
  if (currentEnum) customTypes.push(currentEnum);
}

/**
 * LINKS FOREIGN KEYS BETWEEN TABLES
 * Drop-in replacement for your existing processRelationships()
 */
function processRelationships() {
  tables.forEach(table => {
    if (!table.rawRelationships) return;

    table.rawRelationships.forEach(rel => {
      // Use schema of the source table when looking up the target
      const targetKey = tableKey(table.schema, rel.targetTableName);
      const targetData = tableMap.get(targetKey);
      
      if (targetData) {
        const targetFieldId = targetData.fields.get(rel.targetFieldName || 'id');

        if (targetFieldId) {
          relationships.push({
            id: getNextId(),
            name: `${table.name}_${targetData.schema}_${targetData.id}_fk`,
            sourceSchema: table.schema,
            sourceTableId: table.id,
            sourceFieldId: rel.sourceFieldId,
            targetSchema: targetData.schema,
            targetTableId: targetData.id,
            targetFieldId,
            sourceCardinality: "many",
            targetCardinality: "one",
            createdAt: NOW_EPOCH
          });
        }
      } else {
        console.warn(`Foreign key target not found: ${table.schema}.${rel.targetTableName}`);
      }
    });

    // Cleanup rawRelationships
    delete table.rawRelationships;
  });
}

function saveTable(tableObj) {
  // Generate PK Index strictly matching schema
  const pkFields = tableObj.fields.filter(f => f.primaryKey).map(f => f.id);
  
  if (pkFields.length > 0) {
    tableObj.indexes.push({
      id: getNextId(),
      name: `${tableObj.name}_pkey`,
      unique: true,
      fieldIds: pkFields,
      createdAt: NOW_EPOCH,
      isPrimaryKey: true
    });
  }
  tables.push(tableObj);
}

// --- TYPE MAPPING (Robust) ---
function mapTypeToChartDB(rawType) {
  if (!rawType) rawType = "varchar"; 
  
  const lowerType = rawType.toLowerCase().trim();
  
  // 1. Numeric with args: numeric(5,2)
  if (lowerType.startsWith('numeric') || lowerType.startsWith('decimal')) {
    // Extract precision/scale if possible, else default
    // Regex to grab numbers from string like "numeric(5,2)"
    const match = rawType.match(/\((\d+),(\d+)\)/);
    const prec = match ? parseInt(match[1]) : 10;
    const scale = match ? parseInt(match[2]) : 2;

    return {
      id: "numeric",
      name: rawType, 
      fieldAttributes: {
        precision: { max: 999, min: 1, default: prec },
        scale: { max: 999, min: 0, default: scale }
      }
    };
  }

  // 2. Text/Varchar
  if (lowerType.includes('char') || lowerType === 'text') {
    return {
      id: lowerType.split('(')[0], 
      name: rawType,
      usageLevel: 1
    };
  }

  // 3. Integers
  if (['bigint', 'integer', 'int', 'smallint'].includes(lowerType)) {
    return {
      id: lowerType === 'int' ? 'integer' : lowerType,
      name: lowerType
    };
  }

  // 4. Timestamp
  if (lowerType.includes('timestamp')) {
    return {
      id: "timestamp",
      name: "timestamp with time zone"
    };
  }
  
  // 5. Money
  if (lowerType === 'money') {
    return { id: "money", name: "money" };
  }
  
  // 6. Boolean
  if (lowerType === 'boolean' || lowerType === 'bool') {
    return { id: "boolean", name: "boolean" };
  }

  // Fallback
  return {
    id: lowerType.split('(')[0] || "varchar",
    name: rawType
  };
}

function isHeaderRow(row) {
  const s = row.join(' ').toLowerCase();
  return s.includes('logical name') || s.includes('field type');
}

function getNextId() {
  // STRICT: IDs must be strings
  return String(globalIdCounter++);
}
