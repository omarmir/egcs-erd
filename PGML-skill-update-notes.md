# PGML Skill Update Notes

This file captures concrete changes I would make to the `PGML` skill so it handles spreadsheet-to-PGML export work better next time.

## Why This Needs An Update

The current skill is strong on:

- reading existing PGML
- explaining versioned documents
- SQL generation and migration planning
- compare-state analysis

But it is weaker on a practical workflow that showed up here:

- infer the target PGML shape from local sample artifacts
- recognize importer-produced PGML as a valid canonical target for generation tasks
- help build a direct exporter from another source format into rich PGML, not just parse PGML after it already exists

In this repo, the missing context was available locally:

- [samples/export.dbml](/home/omar/Code/egcs-erd/samples/export.dbml)
- [samples/migrations-2026-04-16.sql](/home/omar/Code/egcs-erd/samples/migrations-2026-04-16.sql)
- [samples/EGCS-GCS.pgml](/home/omar/Code/egcs-erd/samples/EGCS-GCS.pgml)
- [dbml.gs](/home/omar/Code/egcs-erd/dbml.gs)
- [pgml.gs](/home/omar/Code/egcs-erd/pgml.gs)

The skill should explicitly push the agent to look for those kinds of local conversion artifacts before defaulting to generic PGML advice.

## Recommended Skill Changes

## 1. Expand When-To-Use

Add these trigger cases:

- Create or update tooling that exports non-PGML source formats into PGML.
- Reverse-engineer the importer-produced PGML shape from local samples.
- Build direct-export paths that skip an existing intermediate format such as DBML.
- Compare a source export artifact and an imported PGML artifact to infer canonical output structure.

Suggested wording:

```md
- Create or update scripts that export spreadsheets, DBML, pg_dump-derived SQL, or other schema sources directly into PGML.
- Infer canonical PGML output shape by comparing local source artifacts with importer-generated `.pgml` samples.
```

## 2. Add A New Working Mode

The current six-mode model does not cover exporter/tooling work cleanly. Add a seventh mode:

1. Schema understanding
2. Version-history understanding
3. Compare-state understanding
4. DDL generation
5. Query authoring
6. Diff or migration planning
7. PGML generation/tooling: infer or produce valid PGML from another source format or build tooling that emits PGML directly

Suggested guidance:

```md
7. PGML generation/tooling: infer canonical PGML structure from samples, importer outputs, parser expectations, or source artifacts, then generate PGML or implement tooling that emits it directly.
```

## 3. Add A Local-Sample Discovery Step

The skill currently assumes the canonical app repo layout may exist. In a smaller consumer repo like this one, that assumption is often wrong. The skill should explicitly instruct:

- if the canonical PGML app files are missing, inspect local samples and conversion scripts first
- prefer local `.pgml`, `.dbml`, `.sql`, importer outputs, and export scripts over generic assumptions
- treat importer-produced `.pgml` found in the repo as authoritative examples of expected output shape for generation tasks

Suggested insertion under `Core Workflow` before step 1 or immediately after it:

```md
0. For PGML generation or exporter tasks, discover local conversion artifacts first:
   - existing export scripts such as `*.gs`, `*.ts`, or CLI tools
   - sample `.pgml`, `.dbml`, and `.sql` files
   - importer-produced `.pgml` snapshots that reveal canonical serialized output
   If local samples exist, prefer matching those shapes over generic examples.
```

## 4. Add Explicit Importer-Shape Guidance

The skill mentions import behavior, but not strongly enough for generation tasks. It should state that importer-produced PGML is often the right serialization target when building export tooling.

Important lessons from this repo:

- importer-shaped PGML may inline table indexes and constraints
- foreign keys may appear as top-level `Ref:` lines rather than only inline column refs
- sequences may be lightweight blocks such as `owned_by: schema.table.column`
- executable objects are source-first and should preserve SQL verbatim in `source: $sql$ ... $sql$`
- a direct exporter may need to emit a full `VersionSet` with both `Workspace` and one initial `Version`, not only a bare `Snapshot`

Suggested new section:

```md
## Importer-Shaped PGML

When the task is to generate PGML rather than only read it, look for importer-produced `.pgml` files in the local repo and treat them as authoritative serialization examples.

In generation tasks, prefer matching the imported output shape for:

- `VersionSet`, `Workspace`, and initial `Version` structure
- schema-qualified object names
- placement of `Ref:` lines versus inline `ref:` modifiers
- inline `Index` and `Constraint` lines inside tables
- sequence metadata such as `owned_by`
- function, procedure, and trigger `source:` blocks
- table-group placement and membership formatting
```

## 5. Add A Source-Pair Inference Workflow

This repo had a very useful triad:

- source format output: `export.dbml`
- imported PGML result: `EGCS-GCS.pgml`
- migration SQL / pg_dump-like source: `migrations-2026-04-16.sql`

The skill should teach this workflow explicitly:

1. read the source export artifact
2. read the imported PGML artifact
3. map how objects changed shape across the transformation
4. encode that mapping into the direct exporter

Suggested wording:

```md
When local source-format samples and imported PGML samples both exist, build an object mapping between them:

- enums and custom types
- table naming and schema qualification
- refs and FK actions
- indexes and constraints
- sequences and ownership
- functions, procedures, and triggers
- versioned document wrappers

Use that mapping to implement direct export rather than inventing a fresh PGML layout.
```

## 6. Add Spreadsheet-Exporter Guidance

This task exposed another gap: the skill should say more about source spreadsheets and exporter implementation details when the user asks for direct PGML generation from a sheet.

Important lessons from this repo:

- spreadsheet layouts drift over time, so column positions must be verified from the local exporter or sample data instead of assumed
- relation cells may include both the FK target and trailing settings such as `[delete: restrict, update: no action]`
- default values may live in a dedicated sheet column instead of being embedded in the constraints column
- table-level options can affect PGML generation, for example suppressing an auto-added `_deleted` column
- executable sheets such as `Functions` and `Triggers` may use loose or changing header names, so header discovery should be tolerant rather than hard-coded to one exact shape

Suggested wording:

```md
For spreadsheet-to-PGML tasks, inspect the local exporter and sample sheet conventions before implementing changes.

Specifically verify:

- which columns hold description, default value, relation, and constraints
- whether relation cells can carry FK settings such as `delete:` and `update:`
- whether table header rows carry options such as soft-delete suppression
- how executable-object sheets label function bodies, trigger SQL, references, or helper columns

Do not assume a stable spreadsheet column layout across repositories or over time.
```

## 7. Strengthen Repo-Specific Grounding

Current grounding order is app-repo-centric. Add a fallback rule for consumer repos:

```md
If the canonical PGML app files are not present in the current workspace, fall back to:

1. local `.pgml` samples
2. local import/export scripts
3. local `.dbml` and `.sql` samples that can be paired with `.pgml` outputs
4. bundled `references/*.md`
```

This would have prevented the early mismatch here.

## 8. Add Exporter-Specific Guardrails

New guardrails that would help:

- Do not assume rich PGML generation means “DBML syntax inside a VersionSet wrapper.”
- Do not collapse executable objects into comments if the target PGML samples model them as `Function`, `Procedure`, or `Trigger` blocks.
- Do not omit `Version` blocks for generated PGML if local samples or workflow conventions expect an initial checkpoint alongside `Workspace`.
- Do not rely only on the global skill’s default repo paths when the current workspace clearly contains local PGML samples.
- Do not assume spreadsheet parsers are stable if the local exporter script shows newer handling for defaults, FK settings, or table options.

Suggested wording:

```md
- Do not assume that wrapping DBML-like table syntax in `VersionSet` is sufficient for PGML generation tasks.
- Do not emit executable SQL as comments when local canonical PGML samples model those objects as native executable blocks.
- Do not ignore local importer-produced `.pgml` files when they exist; they are often the most reliable serialization target.
- Do not hard-code spreadsheet column semantics from memory when a local exporter script already defines the real sheet contract.
```

## 9. Add A Concrete Exporter Workflow Example

The skill would benefit from one short example for “build a direct PGML exporter from a spreadsheet or DBML exporter.”

Suggested example:

```md
Exporter workflow example:

1. Read the existing source exporter, such as a spreadsheet-to-DBML script.
2. Read a sample of that exporter’s output.
3. Read a corresponding importer-generated `.pgml` file.
4. Infer object-by-object mapping into PGML:
   - `Enum`
   - `Sequence`
   - `Table ... in Group`
   - `Constraint`
   - `Ref:`
   - `Function` / `Procedure` / `Trigger`
   - `TableGroup`
   - `VersionSet` / `Workspace` / `Version`
5. Implement the direct exporter to match the local PGML serialization shape.
6. Validate with a syntax pass and spot-check against the sample `.pgml`.
```

## 10. Add A Concrete Spreadsheet Workflow Example

The skill should also show the smaller, practical workflow for “the source of truth is a sheet plus an existing exporter script”.

Suggested example:

```md
Spreadsheet exporter workflow example:

1. Read the local spreadsheet exporter first.
2. Confirm the current column contract from code, not from memory.
3. Look for special parsing rules such as:
   - dedicated default-value columns
   - FK settings embedded in relation cells
   - table-level options such as `_deleted` suppression
   - flexible headers for function and trigger sheets
4. Port those parsing rules into the PGML exporter before changing the output shape.
5. Then align the emitted PGML to the local importer-produced `.pgml` samples.
```

## Minimal Patch Summary For The Skill Writer

If the skill writer only wants the shortest actionable change list, I would ask for these five additions:

1. Add a seventh mode for `PGML generation/tooling`.
2. Add a mandatory “discover local `.pgml` / `.dbml` / `.sql` samples first” step for generation tasks.
3. Add a section stating that importer-produced `.pgml` is authoritative for serializer/exporter shape.
4. Add spreadsheet-exporter guidance covering column layout drift, FK settings in relation cells, default-value columns, and table options.
5. Add guardrails against reducing rich PGML generation to “DBML wrapped in VersionSet”.
