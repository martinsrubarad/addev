Repeating Item Groups allow a set of Active Fields to be repeated multiple times during document generation. They enable users to enter a variable number of related records — analogous to rows in a table — where each record contains the same set of fields. Repeating Item Groups support tabular content, multi-paragraph content, Charts, repeating Snippets, and nested hierarchies.

## What Is a Repeating Item Group?

A Repeating Item Group (RIG) is a Design Item that functions like a table definition. The Active Fields within the RIG represent the columns, and each time the user adds a record in the Document Wizard, it creates a new row. During document generation, the RIG content is repeated once for each record the user has entered.

Repeating Item Groups are used to populate:

- **Tabular content** — Rows in a Word table, where each Active Field maps to a column.
- **Multi-paragraph content** — Repeated paragraphs or sections of text, where each repetition contains values from one record.
- **Charts** — Graphical representations of the RIG data.
- **Repeating Snippets** — Snippet Links within the RIG that insert a Snippet for each record.

Repeating Item Groups also support **nesting**, where one RIG contains another RIG as a child. This enables multi-level data structures such as orders containing line items, or policies containing endorsements containing coverages.

## Creating a Repeating Item Group

To create a Repeating Item Group:

1. Open the **Design Items** dialog from the ActiveDocs Ribbon.
2. Right-click in the Navigation Pane and select **New Repeating Item Group**, or click **New Repeating Item Group** on the Home ribbon.
3. Configure the Repeating Item Group properties.

### General Properties

| Property | Description |
| --- | --- |
| **Name** | The internal name of the Repeating Item Group. This name appears in the Design Items Navigation Pane and is used in calculations and Rules. |
| **Description** | An optional description of the Repeating Item Group's purpose. |
| **Prompt** | The text displayed to the user as the heading for this RIG's section in the Document Wizard. If left blank, the Name is used. |
| **Instruction** | Instructional text displayed below the prompt in the Document Wizard. Use this to guide the user on how to add and manage records. |
| **User Tip** | A tooltip displayed when the user hovers over the Repeating Item Group in the Document Wizard. |

### Display Visibility

Controls how the Repeating Item Group appears in the Document Wizard.

| Option | Description |
| --- | --- |
| **Visible** | The Repeating Item Group is displayed in the Document Wizard. The user can add, edit, and remove records. |
| **Hidden** | The Repeating Item Group is not displayed in the Document Wizard. Records must be populated through Auto Populate, Data Views, or other programmatic means. |
| **Read Only** | The Repeating Item Group is displayed in the Document Wizard but the user cannot modify the records. This is useful when records are populated from an external source and should be visible for review but not editable. |

### Merge Options

| Option | Description |
| --- | --- |
| **Merge Table Rows and Headers** | When the RIG is mapped to a Word table, this option controls whether table rows and header rows are merged correctly during document generation. Enable this when the RIG populates a table and the table includes a header row that should appear once at the top. |

### User Interaction Options

| Option | Description |
| --- | --- |
| **Allow Users to reorder** | When enabled, the user can change the order of records in the Document Wizard by moving them up or down. This affects the order in which records appear in the generated document. |

### Auto Populate Options

| Option | Description |
| --- | --- |
| **Auto Populate from RIG** | Automatically populates the Repeating Item Group's records from another RIG within the same Template. This creates a dependency where the current RIG mirrors the records of the source RIG. |
| **Auto Populate from filtered Data Views** | Automatically populates the Repeating Item Group's records from a Data View, optionally filtered by conditions. Each record in the filtered Data View result becomes a record in the RIG. |

### Validation

| Setting | Description |
| --- | --- |
| **Required** | When enabled, the user must add at least one record before proceeding past this step in the Document Wizard. |
| **Enable if not in Template** | When enabled, the Repeating Item Group is active in the Document Wizard even if its markers have not been inserted into the Template body. This is useful for RIGs used only within Rules or other conditional logic. |
| **Allow duplicates** | When enabled, the user can add records with identical values across all Active Fields. When disabled, duplicate records are rejected. |
| **Minimum** | The minimum number of records the user must add. The Document Wizard enforces this minimum before the user can proceed. |
| **Maximum** | The maximum number of records the user can add. Once the maximum is reached, the Add button is disabled. |

### Apply Rule

Optionally assign a Rule to the Repeating Item Group. When a Rule is applied, the RIG is only displayed in the Document Wizard when the Rule evaluates to true. This enables conditional display of the entire Repeating Item Group.

### Adding Active Fields to a Repeating Item Group

Active Fields are added to a Repeating Item Group using the same methods as adding Active Fields to a standard Group:

- **Drag and drop** — Drag an Active Field from one location in the Navigation Pane and drop it onto the Repeating Item Group.
- **Right-click** — Right-click the Repeating Item Group in the Navigation Pane and select **New Active Field** to create a new Active Field directly within the RIG.

Each Active Field in the RIG acts as a column. When the user adds records in the Document Wizard, they provide a value for each Active Field per record.

## Creating Nested Repeating Item Groups

Nested Repeating Item Groups allow multi-level hierarchical data to be captured and rendered in the generated document. A child RIG is contained within a parent RIG, and for each record in the parent, the child RIG can have its own set of records.

### Mapping Active Fields Between RIGs

When nesting RIGs, Active Fields from the parent RIG must be mapped to corresponding fields in the child RIG. This mapping defines how parent records relate to child records during document generation.

To create a nested RIG and configure mappings:

1. Create the parent Repeating Item Group and add its Active Fields.
2. Create the child Repeating Item Group within the parent by right-clicking the parent RIG in the Navigation Pane and selecting **New Repeating Item Group**.
3. Add Active Fields to the child RIG.
4. Open the **Repeating Item Group Mapping** dialog by right-clicking the child RIG and selecting **Mapping**.
5. In the Mapping dialog, map each relevant Active Field in the parent RIG to the corresponding Active Field in the child RIG.
6. Save the mapping.

### Multi-Level Nesting Example

Consider an insurance policy Template that requires the following data hierarchy:

- **Policy** (parent RIG) — Contains policy-level fields such as Policy Number and Policyholder Name.
  - **Endorsement** (child RIG of Policy) — Contains endorsement-level fields such as Endorsement Number and Endorsement Type.
    - **Coverage** (child RIG of Endorsement) — Contains coverage-level fields such as Coverage Type and Coverage Amount.
      - **Limit** (child RIG of Coverage) — Contains limit-level fields such as Limit Type, Limit Amount, and Deductible.

Each level is a separate Repeating Item Group nested within its parent. The Repeating Item Group Mapping dialog defines the relationships between levels.

### Nesting Considerations

- **Data source filtering** — When nested RIGs are populated from Data Views, filters at each level typically reference the parent record's key field to ensure the correct child records are loaded for each parent.
- **No limit on nesting levels** — Repeating Item Groups can be nested to any depth. However, deeply nested structures increase complexity for both the designer and the end user. Use the minimum nesting depth necessary to represent the data accurately.
- **Document Wizard manual data entry** — When nested RIGs require manual data entry, the Document Wizard presents the parent level first. The user adds a parent record, then adds child records for that parent before moving to the next parent record or level.

## Table Representation in Templates

When a Repeating Item Group populates a table in the Template, the table structure follows specific conventions:

- **Two-row table** — The Template table should contain exactly two rows: a header row and a data row. The data row contains the Active Field markers from the RIG. During document generation, the data row is repeated for each record, and the header row appears once at the top.
- **Split** — If the RIG content needs to span multiple table layouts (for example, a summary table followed by a detail table), use the split functionality to divide the content across separate tables.
- **Header row** — The first row of the table is treated as the header row when **Merge Table Rows and Headers** is enabled. This row contains column headings and is not repeated with the data.

> **TIP:** When designing tables for RIGs, keep the Template table to exactly two rows (header and data). The document generation engine handles the repetition of the data row automatically. Adding extra rows in the Template table can produce unexpected results in the generated document.

> **NOTE:** When a Repeating Item Group is not mapped to a table, its content can be represented as repeated paragraphs or sections. Place the Active Field markers within the paragraph structure, and the entire paragraph or section is repeated for each record.
