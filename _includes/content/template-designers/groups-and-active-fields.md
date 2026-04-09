Groups organize Active Fields for presentation in the Document Wizard, and Active Fields are the primary design items that collect, calculate, validate, and display data during document generation. This section covers creating Groups and Active Fields, configuring their properties, inserting them into Templates, performing calculations, and saving Templates.

## Creating a New Active Field Group

An Active Field Group is a container that organizes related Active Fields together. Groups determine how fields are presented to the user in the Document Wizard — each Group typically corresponds to a step or page in the wizard.

To create a new Group:

1. Open the **Design Items Dialog** from the ActiveDocs Ribbon.
2. Right-click in the Navigation Pane and select **New Group**, or click **New Group** on the Design Items Dialog Home ribbon.
3. Configure the Group properties.

### Group Properties

| Property | Description |
| --- | --- |
| **Name** | The internal name of the Group. This is used to identify the Group in the Navigation Pane and in rules. Choose a clear, descriptive name. |
| **Description** | An optional description of the Group's purpose. Recommended for documentation and maintenance purposes. |
| **Prompt** | The text displayed as the heading for this Group's page in the Document Wizard. If left blank, the Group Name is used. |
| **Instruction** | Instructional text displayed below the prompt in the Document Wizard. Use this to provide the user with guidance on how to complete the fields in this Group. |
| **User Tip** | A tooltip displayed when the user hovers over the Group name in the Document Wizard's progress pane. Use this for additional context or help. |
| **Visibility** | Controls whether the Group appears in the Document Wizard. Options: **Visible** (the Group is displayed), **Hidden** (the Group is not displayed but its fields are still processed). Hidden Groups are useful for fields that are calculated or sourced from Data Views and do not require user input. |
| **Apply Rule** | Optionally assign a Rule to the Group. When a Rule is applied, the Group is only displayed in the Document Wizard when the Rule evaluates to true. This enables conditional display of entire Groups of fields. |

> **TIP:** Plan your Group structure before creating Active Fields. A well-organized Group structure results in a logical, easy-to-use Document Wizard for end users.

## Creating Active Fields

Active Fields are the individual data elements within a Template. Each Active Field represents a piece of variable data — whether entered by the user, calculated, sourced from a Data View, or derived from other fields.

Active Fields are always created within a Group. To create a new Active Field:

1. In the Design Items Dialog, select the Group that will contain the new Active Field.
2. Right-click and select **New Active Field**, or click **New Active Field** on the Design Items Dialog Home ribbon.
3. Configure the Active Field properties across the available tabs: General, Validation, and Value List.

## The General Tab

The General tab contains the core properties that define the Active Field's identity, data type, formatting, and default behavior.

### Name

The internal name of the Active Field. This name is used in the Navigation Pane, in calculations, in rules, and as the default marker text in the Template. Choose a clear, descriptive name that indicates the field's purpose.

### Comment

An optional comment for documentation purposes. Comments are visible only in the Design Items Dialog and do not appear in the Document Wizard or the generated document.

### Heading

The heading text displayed above or beside the Active Field in the Document Wizard. If left blank, the Active Field Name is used. Use the heading to provide a user-friendly label.

### Prompt

The prompt text displayed to the user in the Document Wizard for this Active Field. The prompt tells the user what information to enter. If left blank, the Heading value is used.

### User Tip

A tooltip displayed when the user hovers over the Active Field in the Document Wizard. Use this to provide additional guidance, format hints, or examples.

### Data Type

The Data Type determines what kind of data the Active Field accepts and how it is stored and processed.

| Data Type | Description |
| --- | --- |
| **Text** | Accepts free-form text input. This is the default data type. |
| **Number** | Accepts numeric values. Supports decimal places and negative numbers. |
| **Date** | Accepts date values. The date format is controlled by the Format property. |
| **Date and Time** | Accepts date and time values. |
| **Yes/No** | Presents a check box or yes/no option. The stored value is true or false. |
| **Currency** | Accepts monetary values. Formatting follows the selected currency format. |

### Format / Display

The Format and Display properties control how the Active Field's value is rendered in the generated document and in the Document Wizard.

| Format Option | Description |
| --- | --- |
| **Text Format** | For Text data types: controls capitalization (e.g., Uppercase, Lowercase, Title Case) and other text transformations. |
| **Number Format** | For Number and Currency data types: controls decimal places, thousands separator, and negative number display. |
| **Date Format** | For Date and Date and Time data types: controls the date display pattern (e.g., dd/MM/yyyy, MMMM d, yyyy, d MMM yy). |
| **Display as Paragraph** | When enabled, the Active Field value is rendered as a multi-line paragraph in the document rather than inline text. |

### Mask

The Mask property defines an input mask that controls the format of data entry in the Document Wizard. Input masks guide the user by enforcing a specific pattern.

**Examples:**

- `(###) ###-####` for phone numbers
- `##/##/####` for dates
- `AAA-####` for alphanumeric codes

Mask characters:

| Character | Accepts |
| --- | --- |
| `#` | Numeric digit (0-9) |
| `A` | Alphanumeric character (letter or digit) |
| `L` | Letter (A-Z, a-z) |

### Default

The Default property sets the initial value of the Active Field when the Document Wizard opens. The user can change this value during document generation.

Defaults can be:

- A fixed value (e.g., "New Zealand", "0", today's date)
- A reference to another Active Field's value
- A calculation expression

> **TIP:** Use defaults to pre-populate commonly used values, reducing the amount of data entry required by the user.

### Answer Value Replaces Default

When enabled, this option causes the Active Field's answer value to replace the default value on subsequent runs of the Document Wizard. This is useful for fields where the last-entered value is likely to be the same in the next document.

### Save Value as Document Property

When enabled, the Active Field's value is saved as a Microsoft Word document property in the generated document. This allows the value to be accessed by Word's built-in document property fields, used in headers/footers, or read by external applications.

The document property name matches the Active Field name by default, or a custom property name can be specified.

> **NOTE:** Document properties are saved to the generated document, not the Template. They are accessible via **File > Properties** in the generated Word document or programmatically through the Word object model.

## The Validation Tab

The Validation tab controls whether and how user input is validated in the Document Wizard.

### Optionality

Optionality determines whether the user must provide a value for the Active Field.

| Option | Description |
| --- | --- |
| **Optional** | The user may leave the field blank. No validation is performed on whether a value is entered. |
| **Mandatory** | The user must provide a value before proceeding past the Group in the Document Wizard. A validation message is displayed if the field is left blank. |
| **Mandatory (Warning)** | The user is warned if the field is left blank, but they can choose to proceed without entering a value. |

### Entry Type

The Entry Type determines whether the user can type a value freely or must select from a predefined list.

| Option | Description |
| --- | --- |
| **Free Entry** | The user can type any value into the field. This is the default. |
| **Selection Only** | The user must select a value from the field's value list. Free-form typing is not allowed. Requires a value list to be configured on the Value List tab. |

### Validation

The Validation section allows you to define custom validation rules that the entered value must satisfy.

| Option | Description |
| --- | --- |
| **Minimum Length** | The minimum number of characters required. |
| **Maximum Length** | The maximum number of characters allowed. |
| **Minimum Value** | For numeric, currency, and date data types: the minimum acceptable value. |
| **Maximum Value** | For numeric, currency, and date data types: the maximum acceptable value. |
| **Regular Expression** | A regular expression pattern that the value must match. Use this for complex format validation (e.g., email addresses, postal codes). |
| **Validation Message** | The message displayed to the user when validation fails. Write a clear message explaining what is expected. |

### Display Options

Display Options control how the Active Field appears and behaves in the Document Wizard.

| Option | Description |
| --- | --- |
| **Visible in Wizard** | Controls whether the Active Field is displayed in the Document Wizard. Uncheck to hide the field (useful for calculated fields that require no user input). |
| **Read Only** | The field is displayed but cannot be edited by the user. Useful for displaying calculated values or values sourced from a Data View. |
| **Multi-line** | The input area in the Document Wizard is expanded to allow multiple lines of text. Appropriate for address fields, description fields, or other long-form text. |
| **Number of Lines** | When Multi-line is enabled, specifies the height (in lines) of the input area in the Document Wizard. |
| **Apply Rule** | Optionally assign a Rule to the Active Field. When a Rule is applied, the field is only displayed in the Document Wizard when the Rule evaluates to true. |

## The Value List Tab

The Value List tab allows you to define a set of predefined values for the Active Field. When a value list is configured, the user can select from the list rather than (or in addition to) typing a value.

### Value and Display Value Columns

The value list consists of two columns:

| Column | Description |
| --- | --- |
| **Value** | The actual value stored when the user selects this item. This is the value that appears in the generated document and is used in calculations and rules. |
| **Display Value** | The text shown to the user in the Document Wizard. If different from Value, the user sees a friendly label while the underlying value is stored. If left blank, the Value is used as the display text. |

**Example:** A Value of "NZ" with a Display Value of "New Zealand" shows "New Zealand" to the user in the Document Wizard but inserts "NZ" into the document.

### Select Format

The Select Format determines how the value list is presented to the user in the Document Wizard.

| Format | Description |
| --- | --- |
| **Drop Down List** | Displays the values in a drop-down list. The user selects one value. This is the default format and is suitable for lists of any length. |
| **Data Grid Dialog** | Displays the values in a tabular grid dialog showing multiple columns. Useful when the value list is linked to a Data View and the user needs to see additional columns to make a selection. |
| **Check Boxes** | Displays each value as a check box. The user can select one or more values. Suitable for short lists where multiple selections are expected. |
| **Option Buttons** | Displays each value as a radio button. The user selects exactly one value. Suitable for short lists (typically 2-5 items) where only one selection is allowed. |

> **TIP:** Use **Drop Down List** for most cases. Switch to **Data Grid Dialog** when linking to a Data View with multiple display columns, and use **Check Boxes** or **Option Buttons** only for short, fixed lists.

### Value List Management Tools

The following tools are available for managing the value list:

| Tool | Description |
| --- | --- |
| **New** | Adds a new value/display value pair to the list. |
| **Edit** | Edits the selected value/display value pair. |
| **Import List** | Imports a list of values from a Data View. This creates a static copy of the data at the time of import. See the Data Views section for details. |
| **Link List** | Links the value list to a Data View for dynamic, live data. The list is populated from the Data View each time the Document Wizard runs. See the Data Views section for details. |
| **Move Up** | Moves the selected value up in the list order. |
| **Move Down** | Moves the selected value down in the list order. |
| **Delete** | Removes the selected value from the list. |
| **Set Default** | Sets the selected value as the default selection when the Document Wizard opens. |
| **Apply Filter** | Applies a filter to limit the values shown based on conditions evaluated at runtime. Filters can reference other Active Fields, enabling cascading selections. |

> **NOTE:** When a value list is linked to a Data View, the individual values cannot be manually edited, reordered, or deleted. The link must be removed first to make manual changes.

## Inserting Active Fields into the Template

After creating Active Fields in the Design Items Dialog, they must be inserted into the Template body as markers. Markers indicate where the Active Field's value will appear in the generated document.

There are four methods for inserting Active Fields into a Template:

### Method 1: From the Designer Pane

1. Open the **Designer Pane** from the ActiveDocs Ribbon.
2. Switch to **Designer Mode**.
3. Locate the Active Field in the Designer Pane's tree.
4. Click the Active Field to insert its marker at the current cursor position in the Template.

### Method 2: From the ActiveDocs Ribbon

1. Place the cursor at the desired location in the Template.
2. Click **Insert Active Field Marker** on the ActiveDocs Ribbon.
3. Select the Active Field from the dialog that appears.
4. Click **OK** to insert the marker.

### Method 3: From the Design Items Dialog

1. Open the **Design Items Dialog**.
2. Select the Active Field in the Navigation Pane.
3. Place the cursor at the desired location in the Template.
4. Click **Insert into Template** on the Design Items Dialog Home ribbon, or right-click and select **Insert into Template**.

### Method 4: Insert Multiple Times

1. Open the **Design Items Dialog**.
2. Select the Active Field in the Navigation Pane.
3. Click **Insert Multiple Times** on the Design Items Dialog Home ribbon.
4. Click at each location in the Template where the marker should be inserted.
5. Press **Escape** or click **Insert Multiple Times** again to stop inserting.

> **TIP:** Use **Insert Multiple Times** when the same Active Field needs to appear at several locations in the Template (e.g., a customer name that appears in the header, body, and closing of a letter).

## Calculated Active Fields

Active Fields can contain calculated values derived from other Active Fields, constants, and functions. Calculated fields are processed automatically during document generation and do not require user input.

### Basic Calculation Steps

To create a calculated Active Field:

1. Create a new Active Field in the Design Items Dialog (or select an existing one).
2. On the **General** tab, set the **Default** property to the calculation expression.
3. Build the expression using:
   - **Active Field references** — Reference other Active Fields by name enclosed in square brackets (e.g., `[Quantity] * [Unit Price]`).
   - **Arithmetic operators** — `+` (addition), `-` (subtraction), `*` (multiplication), `/` (division).
   - **String concatenation** — Use `&` to join text values (e.g., `[First Name] & " " & [Last Name]`).
   - **Functions** — ActiveDocs provides built-in functions for date calculations, text manipulation, conditional logic, and more.
4. On the **Validation** tab, uncheck **Visible in Wizard** if the calculated field should not be displayed to the user, or set it to **Read Only** if it should be displayed but not editable.

> **NOTE:** Calculation expressions are evaluated in the order the Active Fields appear in the Design Items Dialog. If a calculated field depends on another calculated field, ensure the dependency appears first in the field order.

### Testing a Calculation

To verify that a calculation produces the expected result:

1. Click **Test Template** on the ActiveDocs Ribbon to launch the Document Wizard in Designer Test Mode.
2. Enter test values for the fields that the calculation depends on.
3. Proceed through the Document Wizard and verify that the calculated field displays the correct result.
4. Review the generated document to confirm the calculated value appears correctly in the Template markers.

> **TIP:** Test calculations with a variety of input values, including edge cases such as zero, negative numbers, blank values, and boundary values, to ensure the calculation handles all scenarios correctly.

## Document Properties

The **Save value as document property** option on the General tab of an Active Field allows the field's value to be saved as a document property in the generated Word document.

Document properties are metadata stored in the document file and can be used for:

- Displaying values in headers and footers using Word's DocProperty fields
- Document management and classification in SharePoint or other document management systems
- Programmatic access by external applications
- Search and filtering in document repositories

To configure a document property:

1. Open the Active Field's properties in the Design Items Dialog.
2. On the **General** tab, enable **Save value as document property**.
3. Optionally specify a custom property name. If left blank, the Active Field name is used.

The property is written to the generated document each time it is produced, reflecting the current value of the Active Field.

## Saving the Template

After making changes to a Template, save it back to the WorkCenter Site using the ActiveDocs Save dialog.

To save:

1. Click **Save** on the ActiveDocs Ribbon.
2. The **ActiveDocs Save** dialog opens with the following options:

| Option | Description |
| --- | --- |
| **Comment** | Enter a comment describing the changes made. This is recorded in the Template's version history. |
| **Keep checked out** | The Template remains checked out after saving, allowing you to continue editing. If unchecked, the Template is checked in and becomes available for others. |
| **Check in for Approval** | If approval is enabled on the folder, select this option to submit the Template for approval upon check-in. The Template will be in a pending approval state until an approver reviews it. |

3. Click **OK** to save.

> **NOTE:** If you close Microsoft Word without saving through the ActiveDocs Save dialog, your changes are not saved to the WorkCenter Site. Always use the ActiveDocs Save function rather than Word's standard Save.

> **TIP:** Use the **Comment** field to record meaningful change descriptions. This creates a useful audit trail in the Template's version history.
