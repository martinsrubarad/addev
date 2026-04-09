Before creating a Template, plan the design by considering the document requirements. This section covers the planning process, saving a Word document as a Template, importing it into ActiveDocs WorkCenter Client, and configuring Microsoft Word settings for Template design.

## Considering Template Design

Before beginning Template design, evaluate the following:

- **Document types** — What types of documents will be produced (letters, forms, contracts, reports)?
- **Formatting and styles** — What formatting and styles does the document require? Are there existing corporate styles to follow?
- **Reusable content** — Is there content that appears across multiple documents (logos, confidentiality statements, standard clauses)? Consider using Snippets.
- **Variable data** — What data varies between documents? Each variable element is a candidate for an Active Field.
- **Groups** — How should the variable data be organized for the user in the Document Wizard?
- **Repeating data** — Is there data that repeats a variable number of times (line items, list entries)? Consider Repeating Item Groups.
- **Conditional content** — Are there sections that should appear only under certain conditions? Consider Rules.
- **Data sources** — Will the Template connect to external data (databases, spreadsheets, web services)? Consider Data Views.
- **Calculations** — Are there calculated values (totals, dates, concatenations)?
- **Validation** — What validation is required on user-entered data (mandatory fields, format constraints, value lists)?
- **Workflow** — Does the document require approval, watermarking, or specific output formats?
- **Template Sets** — Should multiple Templates be combined to produce a single merged document or multiple documents?

> **TIP:** Taking time to plan before building saves significant rework. Sketch the document layout and list all variable elements before opening Word.

## Saving a Word Document as a Word Template

ActiveDocs Templates are based on Microsoft Word macro-enabled template files (.dotm). To save a Word document as a Template:

1. Open the document in Microsoft Word.
2. Select **File > Save As**.
3. Choose the desired save location.
4. In the **Save as type** drop-down, select **Word Macro-Enabled Template (*.dotm)**.
5. Enter a file name for the Template.
6. Click **Save**.

> **NOTE:** ActiveDocs requires the .dotm format (macro-enabled template). Do not use .dotx (template without macros) or .docx/.docm (document formats).

## Importing the Template into ActiveDocs WorkCenter Client

Once the Word Template (.dotm) file is ready, import it into ActiveDocs WorkCenter Client to make it available for document generation.

### Import Steps

1. In ActiveDocs WorkCenter Client, navigate to the **Templates** node and select the desired folder.
2. Right-click the folder and select **Import**, or use the **Import** button on the Home ribbon tab.
3. Browse to and select the .dotm file. Click **Open**.
4. The **Template Properties** dialog opens with several tabs.

### General Tab

- **Name** — Enter the display name for the Template. This is the name users see in the Document Wizard and WorkCenter.
- **Description** — Provide a description of the Template. This is recommended as good design practice.
- **Comment** — Add optional comments about the Template (version notes, change history).
- **Template file** — Displays the file path of the imported .dotm file.
- **Check out after import** — Select to automatically check out the Template after import, allowing immediate editing.

### Categories Tab

- Assign the Template to one or more Categories. Categories provide additional classification and filtering beyond the folder structure.
- Select the relevant Categories from the list. Categories are defined by the ActiveDocs Administrator.

### Tags Tab

- Assign Tags to the Template for search and filtering purposes.
- Tags are key-value pairs defined by the ActiveDocs Administrator.
- Select the relevant Tags from the list and set values as needed.

Click **OK** to complete the import.

> **NOTE:** The Template must be checked out before it can be edited. If you did not select **Check out after import**, right-click the Template and select **Check Out** before making changes.

## Microsoft Word Settings

Configure the following Microsoft Word settings to improve the Template design experience.

### Show/Hide Formatting Marks

Displaying formatting marks helps identify spacing, paragraph breaks, and other non-printing characters in the Template.

1. In Microsoft Word, go to the **Home** tab.
2. Click the **Show/Hide** button (¶) in the Paragraph group, or press **Ctrl + Shift + 8**.

When enabled, the following marks are visible:

- Paragraph marks (¶)
- Spaces (·)
- Tab characters (→)
- Section breaks
- Page breaks

> **TIP:** Keep Show/Hide enabled while designing Templates. It makes it easier to see where ActiveDocs markers and content controls are placed relative to paragraph and section formatting.

### Field Shading

Field shading highlights Word fields and ActiveDocs markers in the document, making them easier to identify.

1. In Microsoft Word, select **File > Options**.
2. Select **Advanced** from the left pane.
3. Scroll to the **Show document content** section.
4. Set **Field shading** to **Always**.
5. Click **OK**.

> **NOTE:** With field shading set to **Always**, all Word fields and ActiveDocs markers display with a grey background. This setting is strongly recommended during Template design to ensure all markers are visible.
