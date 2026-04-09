Local Template Options control global settings for the Document Wizard experience and document generation behavior at the Template level. These options determine the wizard's appearance, default behaviors, and post-generation actions.

## Setting the Local Template Options

To access Local Template Options, open the **Design Items** dialog from the ActiveDocs Ribbon and click **Local Template Options** on the Home ribbon.

The following options are available:

### Wizard Presentation

| Option | Description |
| --- | --- |
| **Wizard title** | The title displayed at the top of the Document Wizard window when this Template is used to generate a document. If left blank, a default title is used. |
| **Wizard instruction** | Instructional text displayed in the Document Wizard below the title. Use this to provide the user with an overview of the document being generated or general guidance for completing the wizard. |
| **Welcome message** | A message displayed on the first page of the Document Wizard before the user begins entering data. Use this for introductory information, prerequisites, or instructions that the user should read before proceeding. |
| **Finish instruction** | Instructional text displayed on the final step of the Document Wizard before the user clicks Finish. Use this to remind the user to review their entries or to describe what happens when they complete the wizard. |
| **Finish message** | A message displayed after the Document Wizard completes and the document is generated. Use this to confirm completion or to provide next steps, such as reviewing the generated document or saving it to a specific location. |

### Document Name

| Option | Description |
| --- | --- |
| **Document Name** | The default file name for the generated document. This can be a fixed name or a calculated name that references Active Field values. |
| **Calculate** | When enabled, the Document Name is evaluated as a calculation expression. Active Field references can be included using square bracket notation (e.g., `[Client Name] - [Document Type]`), allowing the file name to vary based on user input. |
| **Lock Document Name** | When enabled, the user cannot change the document name in the Document Wizard. The calculated or fixed name is used as-is. |

### Document Protection

| Option | Description |
| --- | --- |
| **Protect document at completion** | When enabled, the generated document is protected from editing when it is created. This uses Microsoft Word's document protection feature to prevent modifications. |

### Auto Populate

| Option | Description |
| --- | --- |
| **Auto Populate from filtered Data Views or Snippets** | When enabled, Active Fields configured with Auto Populate settings are automatically filled with values from their linked Data Views or Snippets when the Document Wizard starts. This reduces the amount of manual data entry required. |
| **Always add new Repeating Items multi-selected** | When enabled, multiple records selected from a Data View during Auto Populate are added as new records in the Repeating Item Group rather than overwriting existing records. This is useful when the user should be able to accumulate records from multiple selections. |

### Document Generation

| Option | Description |
| --- | --- |
| **Repaginate and update TOC** | When enabled, the generated document is repaginated and any Table of Contents is updated automatically after document generation completes. This ensures page numbers, cross-references, and the Table of Contents reflect the final content. |
| **Never prompt for Active Fields in Rules** | When enabled, Active Fields that are referenced only within Rules (and not inserted as markers in the Template body) are not displayed in the Document Wizard. This prevents the user from being prompted for values that are used only for conditional logic and do not appear directly in the document content. |
| **Enable Document Preview in Document Wizard** | When enabled, a preview pane is available in the Document Wizard that shows a live preview of the document as the user enters data. This allows the user to see the effect of their entries on the final document in real time. |

> **TIP:** Use a calculated Document Name with the Lock Document Name option to enforce a consistent file naming convention across all documents generated from the Template. This is particularly valuable in environments where documents are stored in a document management system with naming standards.

> **NOTE:** The **Protect document at completion** option applies Word's built-in protection. The level of protection (e.g., read-only, allow comments only) is determined by the protection settings configured in the Template.
