A Template Set combines two or more Templates to produce either a single merged document or a set of separate documents. Template Sets can also include static file attachments and support answer files that drive the Document Wizard across all Templates in the set.

## What Are Template Sets?

A Template Set is a Design Component that groups multiple Templates together. When a user runs a Template Set, the Document Wizard presents questions from all included Templates in a single session. Depending on the configuration, the output can be:

- **Merged document** — All Templates produce content that is combined into one output document.
- **Multiple documents (Document Set)** — Each Template produces a separate output document, managed together as a set.

Template Sets can also include **Attachments**, which are static files (not generated from Templates) that are bundled with the output. Attachments can be sourced internally from Snippets or externally from file system paths.

**Answer files** can be used with Template Sets. When a user runs a Template Set, previously saved answers can pre-populate fields across all Templates in the set, streamlining document generation for recurring scenarios.

## Creating a Template Set

To create a Template Set:

1. In ActiveDocs WorkCenter Client, navigate to the **Templates** node (or a subfolder).
2. Right-click and select **New > Template Set**, or use the **New** button on the ribbon.
3. The **Template Set Properties** dialog opens.

### General Tab

| Option | Description |
| --- | --- |
| **Name** | The name of the Template Set as it appears in the Templates tree and in the WorkCenter. |
| **Description** | An optional description of the Template Set. Recommended for documentation and maintenance purposes. |
| **Preview URL** | An optional URL that provides a preview of the Template Set output. This URL is displayed in the WorkCenter when the user selects the Template Set. |
| **Use ActiveDocs Snippet merging** | When enabled, Snippet content is merged using the ActiveDocs merging engine rather than native Word merging. This can improve consistency when Snippets are shared across Templates. |
| **Use ActiveDocs Document Conversion Service** | When enabled, document format conversion (e.g., to PDF) is handled by the ActiveDocs Document Conversion Service rather than by Microsoft Word on the server. |

### Categories

Assign the Template Set to one or more Categories to control its visibility and organization in the WorkCenter.

## Adding Templates to a Template Set

To add Templates to a Template Set:

1. Right-click the Template Set and select **Edit**, or double-click it. The **Template Set Definition** dialog opens.
2. Click **Add** on the toolbar and select **Add Template**.
3. The Template selection dialog opens. Browse to and select the Templates to include.
4. Click **OK** to add the selected Templates to the set.

Templates appear in the Template Set Definition list in the order they were added. The order determines the sequence of content in a merged document and the default display order in the Document Wizard.

## Setting the Properties of a Template Set Item

To configure properties for a Template within the set, select the Template in the Template Set Definition list and click **Properties** on the toolbar (or double-click the item).

The following properties are available:

### General

| Option | Description |
| --- | --- |
| **Comment** | An optional comment describing the purpose of this Template within the set. |
| **Document Name** | The file name for the output document generated from this Template. Click **Calculate** to build a dynamic name using Active Field values or expressions. |

### Section Break Options

Section Break options control how the Template's content is separated from the preceding Template's content in a merged document.

| Option | Description |
| --- | --- |
| **None** | No section break is inserted before this Template's content. The content flows directly after the previous Template's content. |
| **Next page** | A section break is inserted, and the Template's content begins on the next page. |
| **Odd page** | A section break is inserted, and the Template's content begins on the next odd-numbered page. |
| **Restart Page Numbering** | When selected, page numbering restarts at 1 for this Template's section. Available only when a Section Break option other than None is selected. |

> **NOTE:** Section Break options are available only when the Template Set is configured to merge documents. They do not apply when each Template produces a separate document.

### Selection and Enablement

| Option | Description |
| --- | --- |
| **Template is selected and enabled** | When selected, this Template is included in the output by default and cannot be deselected by the user. |

### Repeat Options

| Option | Description |
| --- | --- |
| **Repeat this Template** | When enabled, the Template generates multiple instances of its output based on repeating answer data. |
| **Repeat Answers** | Specifies which Repeating Item Group provides the data that drives the repeat. |
| **Use repeating instance answers only** | When selected, each repeated instance of the Template uses only the answer data for that specific repeating instance, rather than inheriting non-repeating answers. |

> **NOTE:** The **Repeat this Template** option is available only when the Template Set is configured to produce multiple documents (not merged). Repeating a Template in a merged document set is not supported.

### Template List Display Options

| Option | Description |
| --- | --- |
| **Hide** | The Template is not visible to the user in the Template list. It is always included silently. |
| **Show** | The Template is visible in the Template list. |
| **Allow Reorder** | When shown, the user can change the order of this Template relative to others. |
| **Allow Select-Deselect** | When shown, the user can choose whether to include or exclude this Template from the output. |

### Template Run Mode Options

| Option | Description |
| --- | --- |
| **Wizard and Assembly** | The user completes the Document Wizard questions for this Template, and the document is assembled. This is the default. |
| **Wizard only** | The user completes the Document Wizard questions, but no document is assembled for this Template. Useful when the Template's Design Items feed answers to other Templates in the set. |
| **Assembly only** | The document is assembled without presenting any Document Wizard questions for this Template. The Template uses answers provided by other Templates or by an answer file. |

### Document Set Delivery Options

| Option | Description |
| --- | --- |
| **Do not Deliver** | The document generated from this Template is not included in any delivery action. |
| **Deliver as Email body** | The document content is used as the body of a delivery email. Only one Template in the set can be designated as the email body. |
| **Deliver with Delivery Format** | The document is delivered in the format specified by the delivery configuration. |

## Important Considerations for Template Sets

- **Section Break** options are available only when the Merge Documents option is enabled in the Template Set Definition.
- **Repeat this Template** is available only when documents are not merged. Repeating is not supported in merged output.
- **Document Properties** (title, author, subject, etc.) in a merged document are taken from the first Template in the set. Document properties from subsequent Templates are discarded.
- When users are permitted to **reorder** Templates in the Template list, reordering a Template that has a Section Break set to None may produce unexpected results, since the content flow depends on order.
- When users **remove** a Template from the set at runtime (via select-deselect), any answers associated exclusively with that Template are discarded.

## Adding an Attachment to a Template Set

To add an Attachment:

1. In the **Template Set Definition** dialog, click **Add** on the toolbar and select **Add Attachment**.
2. The Attachment is added to the list and can be configured through its properties.

## Setting the Properties of a Template Set Attachment

Select the Attachment in the Template Set Definition list and click **Properties** to configure:

| Option | Description |
| --- | --- |
| **Name** | The display name for the Attachment. |
| **Comment** | An optional comment describing the Attachment. |
| **Document Name** | The file name for the Attachment in the output. |
| **Repeat this Attachment** | When enabled, the Attachment is repeated based on repeating answer data, similar to Template repeating. |

### File Source

| Option | Description |
| --- | --- |
| **Internal** | The Attachment content is sourced from a Snippet stored in the ActiveDocs system. Select the Snippet from the **Snippet Link** dropdown. |
| **External** | The Attachment content is sourced from a file on the file system or network. Click **Browse** to select the file, or click **Calculate** to build a dynamic file path using Active Field values or expressions. The **File Name** field specifies the path to the external file. |

### Document Set Delivery Options

The same delivery options available for Templates (Do not Deliver, Deliver as Email body, Deliver with Delivery Format) also apply to Attachments.

## Important Considerations for Attachments

- **Rules** can be applied to Attachments to conditionally include or exclude them based on Active Field values.
- **Internal Attachments** support Static Snippets. The Snippet content is included as-is without any merging or field processing.
- **External Attachments** support any file type that is compatible with the output format. Common file types include PDF, DOCX, XLSX, and image files.
- In a **merged output**, Attachments are appended after all Template content.
- Attachments are supported by the **ActiveDocs Document Processing** (ADP) engine.
- The **Attachment list** in the Template Set Definition displays Attachments in the order they were added.
- **Delivery** settings for Attachments follow the same rules as for Templates within the set.
- Users **cannot delete, edit, add content to, or reorder** Attachments at runtime through the Document Wizard. Attachment configuration is fixed at design time.

## Applying a Rule to a Template or Attachment

Rules can be applied to individual Templates or Attachments within a Template Set to conditionally include or exclude them from the output.

To apply a Rule:

1. Select the Template or Attachment in the **Template Set Definition** list.
2. Click **Apply Rule** on the toolbar.
3. The **Build Rule** dialog opens. Define the Rule conditions, or select an existing Rule.
4. Click **OK** to apply the Rule.

When a Rule is applied, a **Rule icon** appears next to the item in the Template Set Definition list, indicating that conditional logic governs its inclusion.

### Rule Reuse in Template Sets

Rules defined within a Template Set can reference Design Items from any Template in the set. This allows cross-Template conditions — for example, a Rule on Template B can evaluate an Active Field defined in Template A.

## Editing the Definition of a Template Set

The Template Set Definition dialog provides a toolbar with the following operations:

| Operation | Description |
| --- | --- |
| **Add** | Add a Template or Attachment to the set. |
| **Properties** | View or edit the properties of the selected item. |
| **Remove** | Remove the selected Template or Attachment from the set. |
| **Apply Rule** | Apply a conditional Rule to the selected item. |
| **Remove Rule** | Remove the Rule from the selected item. |
| **Apply Repeat** | Configure repeating for the selected item. |
| **Remove Repeat** | Remove the repeat configuration from the selected item. |
| **Move Up** | Move the selected item up in the list order. |
| **Move Down** | Move the selected item down in the list order. |

> **TIP:** Multiple items can be selected simultaneously (using Ctrl+click or Shift+click) for bulk operations such as Remove, Move Up, and Move Down.

### Template Set Definition Options

The Template Set Definition dialog includes the following configuration options:

| Option | Description |
| --- | --- |
| **Enable External Template Set Verification** | When enabled, an external verification service validates the Template Set configuration before document generation proceeds. |
| **Use First Template as Answers collector** | When enabled, the first Template in the set serves as the primary source for answer collection. Its Design Items are presented first in the Document Wizard, and its answers are available to all subsequent Templates. |
| **Show Template List** | When enabled, the Document Wizard displays a list of Templates in the set, allowing the user to see (and optionally interact with) the Template selection. |
| **Enable Document Preview** | When enabled, users can preview the generated document during the Document Wizard session before finalizing. |
| **Merge Documents** | When enabled, all Template outputs are merged into a single document. When disabled, each Template produces a separate document in a Document Set. |
| **Enable Document Set Delivery** | When enabled, delivery options are available for the Template Set output. |
| **Document Set Name** | The name assigned to the Document Set. Click **Calculate** to build a dynamic name using Active Field values or expressions. |
| **Concatenate** | When enabled, document names in the set are concatenated with a separator to form the final Document Set name. |
| **Lock Document Name** | When enabled, users cannot modify the document name at runtime. |

### Properties Icon Reference

The Template Set Definition list displays icons next to each item to indicate its current configuration:

| Icon | Definition |
| --- | --- |
| Template icon | The item is a Template. |
| Attachment icon | The item is an Attachment. |
| Rule icon | A Rule is applied to the item. |
| Repeat icon | The item is configured for repeating. |
| Hidden icon | The item is hidden from the user in the Template list. |
| Disabled icon | The item is currently disabled. |
| Wizard only icon | The item is set to Wizard only run mode. |
| Assembly only icon | The item is set to Assembly only run mode. |
| Email body icon | The item is designated as the email body for delivery. |
