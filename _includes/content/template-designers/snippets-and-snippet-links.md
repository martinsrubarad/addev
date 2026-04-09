Snippets are reusable blocks of content that can be inserted into Templates and other Snippets during document generation. They enable organizations to maintain common content — such as standard clauses, disclaimers, or boilerplate paragraphs — in a single location and reuse it across multiple Templates. Snippet Links are the Design Items within a Template or Snippet that provide the connection to a Snippet and control how it is selected and inserted.

## What Is a Snippet?

A Snippet is a standalone content component stored in the ActiveDocs WorkCenter Site. Snippets contain formatted text, tables, images, and other document content, along with optional Design Items (Active Fields, Groups, Rules, and nested Snippet Links).

There are two types of Snippets:

- **Static Snippet** — Contains fixed content only. When inserted into a document, the content appears exactly as defined. Static Snippets are appropriate for boilerplate text that does not vary between documents, such as standard disclaimers or legal notices.
- **Active Snippet** — Contains content with embedded Design Items. When inserted into a document, the Active Snippet's Design Items are merged into the Document Wizard, allowing the user to provide values that customize the Snippet's content for each document. Active Snippets support the full range of Design Items including Active Fields, Groups, Repeating Item Groups, Rules, Charts, and nested Snippet Links.

Snippet Links provide the connection between the Template (or parent Snippet) and the Snippet. A Snippet Link is a Design Item placed in the Template body at the location where the Snippet content should appear. During document generation, the Snippet Link resolves to the selected Snippet's content.

## Creating a Snippet in Microsoft Word

A Snippet can be created directly from content in a Microsoft Word document. This approach is useful when existing document content needs to be converted into a reusable Snippet.

To create a Snippet from content in Word:

1. Open the document containing the content to be made into a Snippet.
2. Select the content to include in the Snippet.
3. On the ActiveDocs Ribbon, click **Create Snippet**.
4. The **Create Snippet** dialog opens with the following configuration options.

### General Tab

| Property | Description |
| --- | --- |
| **Name** | The name of the Snippet as it will appear in the WorkCenter Site. Choose a clear, descriptive name that indicates the Snippet's purpose and content. |
| **Description** | An optional description providing additional detail about the Snippet's purpose, usage guidelines, or content summary. |
| **Preview URL** | An optional URL pointing to a preview of the Snippet's content. This URL is displayed when users preview the Snippet during selection. |

### Categories

Categories classify the Snippet for organizational and filtering purposes. Assign one or more categories to the Snippet to make it easier to locate when browsing or filtering in the WorkCenter Site or the Insert Snippet dialog.

To assign categories, select the appropriate category check boxes in the Categories section of the dialog.

### Tags

Tags provide additional metadata for the Snippet. Tags are free-form text labels that support searching and filtering. Multiple tags can be assigned to a single Snippet.

To add a tag, type the tag text and press Enter. To remove a tag, click the remove button next to the tag.

5. Click **OK** to save the Snippet to the WorkCenter Site.

## Creating a Snippet in ActiveDocs WorkCenter Client

Snippets can also be created directly in the ActiveDocs WorkCenter Client without starting from an existing Word document.

To create a Snippet in WorkCenter Client:

1. In the WorkCenter Client, navigate to the **Snippets** node in the navigation tree.
2. Right-click and select **New Snippet**, or click the **New** button on the ribbon.
3. A new Snippet document opens in Microsoft Word with the ActiveDocs Ribbon available.
4. Enter and format the Snippet content in the Word document.
5. Configure the Snippet properties in the **General** tab, including Name, Description, and Preview URL, using the same properties described above.
6. Assign **Categories** and **Tags** as needed.
7. If the Snippet requires Design Items (making it an Active Snippet), open the Design Items dialog from the ActiveDocs Ribbon and add the required Active Fields, Groups, Rules, or other Design Items.
8. Save the Snippet.

## Inserting a Snippet from the ActiveDocs Ribbon

To insert a Snippet directly into a Template or another Snippet:

1. Place the cursor at the desired insertion point in the Template or Snippet body.
2. On the ActiveDocs Ribbon, click **Insert Snippet**.
3. The **Insert Snippet** dialog opens, displaying available Snippets from the WorkCenter Site.
4. Browse or search for the desired Snippet. Use category filters to narrow the list.
5. Select the Snippet and click **Insert**.

When inserting an Active Snippet, enable the **Insert using Wizard** option to launch the Document Wizard for the Snippet's Design Items. This allows values to be entered at design time for preview purposes, or to set default values for the Snippet's Active Fields.

> **NOTE:** Inserting a Snippet directly embeds its content into the Template at the cursor location. This creates a static copy of the content. To maintain a dynamic link that resolves at document generation time, use a Snippet Link instead.

## Understanding Formatting in a Snippet

When Snippets are inserted into a Template during document generation, formatting consistency requires attention to how Microsoft Word Styles are used.

### Normal Style Consistency

The Normal Style in the Snippet should match the Normal Style in the Template. If the Normal Style definitions differ between the Snippet and the Template, the Template's Normal Style takes precedence and may alter the appearance of the Snippet's content in the generated document.

### Style Name Conflicts

If the Snippet uses a Style with the same name as a Style in the Template but with different formatting, the Template's Style definition takes precedence. The Snippet's content is reformatted to match the Template's version of that Style.

### Unique Styles

To ensure that Snippet formatting is preserved exactly as designed, use uniquely named Styles in the Snippet. Styles with names that do not exist in the Template are imported into the generated document along with the Snippet content, preserving their formatting.

> **TIP:** Establish a Style naming convention for Snippets (e.g., prefix Snippet Style names with "Snp_") to avoid conflicts with Template Styles and ensure predictable formatting in generated documents.

## Using the ActiveDocs Snippet Pane

The ActiveDocs Snippet Pane provides a dedicated interface for browsing, searching, and inserting Snippets without leaving the Template editing environment.

To open the Snippet Pane, click **Snippet Pane** on the ActiveDocs Ribbon. The pane appears as a side panel in Microsoft Word.

### Search Function

The Snippet Pane includes a search field at the top. Type a search term to filter the displayed Snippets by name, description, category, or tag. Results update as you type.

### Show Snippet Dropdown

The **Show Snippet** dropdown filters the displayed Snippets by type or category. Use this dropdown to narrow the list to a specific category or to show all available Snippets.

### Actions

The Snippet Pane provides the following actions for the selected Snippet:

| Action | Description |
| --- | --- |
| **Insert using Wizard** | Inserts the selected Snippet at the cursor position and opens the Document Wizard for the Snippet's Design Items (applicable to Active Snippets). |
| **Insert Snippet** | Inserts the selected Snippet's content directly at the cursor position without launching the wizard. |
| **Preview Snippet** | Opens a preview of the Snippet's content, using the Preview URL if one has been configured. |

## Creating a Snippet Link

A Snippet Link is a Design Item that connects a Template or Snippet to one or more Snippets. During document generation, the Snippet Link resolves to the selected Snippet's content, inserting it at the marked location in the document.

To create a Snippet Link:

1. Open the **Design Items** dialog from the ActiveDocs Ribbon.
2. Right-click in the Navigation Pane and select **New Snippet Link**, or click **New Snippet Link** on the Home ribbon.
3. The **New Snippet Link** dialog opens.

### General Properties

| Property | Description |
| --- | --- |
| **Name** | The internal name of the Snippet Link. This name appears in the Design Items Navigation Pane and as the default marker text in the Template body. |
| **Description** | An optional description of the Snippet Link's purpose. |
| **Prompt** | The text displayed to the user in the Document Wizard for this Snippet Link. If left blank, the Name is used. |
| **Instruction** | Instructional text displayed below the prompt in the Document Wizard. Use this to guide the user on how to select or configure the Snippet. |
| **User Tip** | A tooltip displayed when the user hovers over the Snippet Link in the Document Wizard. |

### Validation Options

The Validation section controls how the user interacts with the Snippet Link in the Document Wizard.

#### User Selects from Filtered List

When this option is selected, the Document Wizard presents the user with a filtered list of available Snippets. The user selects one Snippet from the list.

| Sub-Option | Description |
| --- | --- |
| **Filter by Category** | Restricts the list to Snippets assigned to the specified category. |
| **Filter by Name** | Restricts the list to Snippets whose name matches the specified filter text. |
| **Read Only** | The Snippet selection is locked. The user can see the selected Snippet but cannot change it. |

#### Use File Reference

When this option is selected, the Snippet Link resolves to a Snippet identified by a file path or reference, rather than a user selection. This is used for programmatic or integration-driven scenarios where the Snippet is determined externally.

#### Use This Snippet or Free Text Entry

When this option is selected, a specific Snippet is assigned to the Snippet Link. The user does not select from a list. The assigned Snippet is always used unless free text entry is enabled.

| Sub-Option | Description |
| --- | --- |
| **Options for formatting** | Opens the **Options** dialog where formatting behavior can be configured for the Snippet content when it is merged into the document. |

#### Use Multiline Text Active Field

When this option is selected, the Snippet Link behaves as a multiline text input field in the Document Wizard, rather than referencing a stored Snippet. The user types or pastes content directly.

#### Additional Validation Settings

| Setting | Description |
| --- | --- |
| **Required** | When enabled, the user must select a Snippet or provide content before proceeding past this step in the Document Wizard. |
| **Allow Free Text Entry** | When enabled alongside a Snippet selection option, the user can either select a Snippet from the list or type custom text directly. The formatting **Options** dialog controls how free text is formatted in the generated document. |
| **Enable if not in Template** | When enabled, the Snippet Link is active in the Document Wizard even if its marker has not been inserted into the Template body. This is useful for Snippet Links that are used only within Rules or other conditional logic. |

### Display Visibility

Controls whether the Snippet Link appears in the Document Wizard.

| Option | Description |
| --- | --- |
| **Visible** | The Snippet Link is displayed in the Document Wizard. The user can interact with it. |
| **Hidden** | The Snippet Link is not displayed in the Document Wizard. The Snippet resolves automatically based on the configured validation option (e.g., a fixed Snippet assignment or a programmatic reference). |

### Apply Rule to Group

Optionally assign a Rule to control when the Snippet Link appears in the Document Wizard. When a Rule is applied, the Snippet Link is only displayed when the Rule evaluates to true.

## Inserting a Snippet Link into a Template or Snippet

After creating a Snippet Link in the Design Items dialog, it must be inserted into the Template or Snippet body to define where the Snippet content appears in the generated document.

To insert a Snippet Link:

1. Place the cursor at the desired insertion point in the Template or Snippet body.
2. In the Design Items dialog, select the Snippet Link in the Navigation Pane.
3. Right-click and select **Insert**, or drag the Snippet Link from the Navigation Pane to the cursor position in the document.
4. A Snippet Link marker appears at the insertion point.

> **TIP:** When inserting a Snippet Link, ensure that there are no extra blank lines or paragraph marks immediately before or after the marker. Extra blank lines around the Snippet Link marker result in additional blank lines in the generated document around the Snippet content.

> **NOTE:** The **Required** setting on a Snippet Link determines whether the user must make a selection. When Required is not enabled, the Snippet Link resolves to nothing if the user does not select a Snippet, and the corresponding location in the document is left empty.

## Modifying a Snippet Link

An existing Snippet Link can be modified to change its properties, validation settings, display visibility, or Rule assignment. There are five ways to access a Snippet Link for editing:

1. **Design Items dialog** — Open the Design Items dialog, select the Snippet Link in the Navigation Pane, and edit its properties in the detail pane.
2. **Double-click the marker** — Double-click the Snippet Link marker in the Template body to open the Snippet Link properties dialog directly.
3. **Right-click the marker** — Right-click the Snippet Link marker in the Template body and select **Properties** from the context menu.
4. **Designer Pane** — In the Designer Pane, click the Snippet Link entry and select **Properties** or double-click it.
5. **ActiveDocs Ribbon** — Select the Snippet Link marker in the Template body and use the **Marker Properties** button on the ActiveDocs Ribbon.

## Understanding Active Snippets

Active Snippets contain Design Items that are merged into the Document Wizard when the Snippet is selected through a Snippet Link. This section covers key considerations for working with Active Snippets.

### Consistent Naming

When an Active Snippet contains Active Fields with the same name as Active Fields in the Template, the values are shared. This allows data entered for a Template Active Field to flow automatically into the Active Snippet without the user entering the same value twice.

Use a consistent naming convention across Templates and Active Snippets to take advantage of this behavior. When an Active Field in an Active Snippet should receive a value from the Template, give it the same name as the corresponding Template Active Field.

### Import Support

Design Items from an Active Snippet can be imported into a Template or another Snippet using the Import function in the Design Items dialog. This creates local copies of the imported items.

### Rules Support

Active Snippets fully support Rules. Rules defined within an Active Snippet operate on the Snippet's own Design Items and content. They can reference Active Fields within the Snippet or Active Fields that are shared by name with the Template.

### Free Text Entry Caveat

When a Snippet Link has **Allow Free Text Entry** enabled and the user enters free text instead of selecting a Snippet, the Active Snippet's Design Items are not available. The free text content is inserted as-is without any Design Item processing. If the Template depends on Active Fields from the Snippet, those fields have no values when free text is used.

> **TIP:** When designing Templates that use Active Snippets, consider whether free text entry is appropriate. If the Template relies on Active Field values from the Snippet (for example, in calculations or Rules), disabling free text entry ensures the Snippet's Design Items are always available.
