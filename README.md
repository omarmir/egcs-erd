# EGCS Data Model – ChartDB Generator

This repository contains the tooling and artifacts used to generate, maintain, and version the EGCS data model in **ChartDB** from a structured Google Sheet.

It provides:

- 📊 A structured spreadsheet definition of the data model (ODS copy included)
- ⚙️ A Google Apps Script exporter that converts the sheet into valid ChartDB JSON
- 🧭 A layout migrator that preserves applies positioning from one export to another (https://omarmir.github.io/egcs-erd/layout.html)
- 🖼 SVG/JPEG exports of the rendered model
- 📦 Generated ChartDB JSON output

## Overview

Maintaining layout manually inside ChartDB after each schema change is time-consuming.

This workflow solves that by:

1. Defining the schema in Google Sheets
2. Exporting structured ChartDB JSON via Apps Script
3. Preserving layout positions from a previous ChartDB export
4. Re-importing into ChartDB without losing positioning

## Workflow

### 1. Define Schema in Google Sheets

Each sheet represents a schema (subject area).

Within each sheet:

- Colored row = New table
- Header row defines columns
- Subsequent rows define fields

Expected Columns:

- Logical Name → Field name
- Optional → N = Required
- Field Type → Postgres type
- Relation → ForeignKey, TargetTable.field
- Constraints → Optional constraints
- Description → Field description

Example relation:

ForeignKey, Agency.id

### 2. Export JSON via Apps Script

The Google Apps Script:

- Parses sheets
- Detects tables via colored rows
- Maps Postgres types to ChartDB types
- Detects primary keys (id)
- Generates foreign key relationships
- Supports cross-sheet relationships
- Outputs strict-schema-compliant ChartDB JSON

Menu in Google Sheets:

ChartDB → Generate JSON

### 3. Preserve Layout (Optional)

ChartDB does not preserve layout when importing new JSON.

The layout migrator:

1. Takes a ChartDB-exported JSON (with layout)
2. Takes a freshly generated JSON
3. Applies saved positions (x, y, width, height)
4. Outputs a layout-preserved JSON

Matching logic:

- Schema + table name
- Case-insensitive
- Whitespace normalized

### 4. Import Into ChartDB

Upload the updated JSON into ChartDB.

Layout and relationships should be preserved.

## Foreign Key Rules

Format:

ForeignKey, TargetTable.field

If field is omitted:

ForeignKey, TargetTable

Defaults to:

TargetTable.id

Cross-sheet relationships are supported automatically.

## Type Mapping

Supported Postgres types include:

- bigint
- integer
- smallint
- numeric(precision,scale)
- decimal
- varchar
- text
- boolean
- timestamp
- money

Unknown types fall back safely.

## Generated JSON Structure

The exporter produces:

- tables
- relationships
- areas
- customTypes (enums)
- notes (empty array)
- subjectAreas (empty array)
- ISO timestamps at root
- Epoch timestamps internally

All IDs are strings (ChartDB requirement).

## Troubleshooting

Relationships not appearing:

- Table name must match exactly
- No trailing spaces in sheet
- Target field must exist
- Sheet tab must have a color
- FK format must be correct

Layout not preserved:

- Table names unchanged
- Schema names unchanged
- Layout migrator matched schema + name
- No renamed tables

Tables not detected:

- Table header row must be colored
- Header row must contain expected column names
