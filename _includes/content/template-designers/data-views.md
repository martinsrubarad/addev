A Data View connects Templates and Active Snippets to structured data sources such as databases, spreadsheets, and OLE DB-compliant systems. Data Views allow Active Fields to be populated from external data, either through user selection or automatic filtering, and support both online and offline use.

## What Is a Data View?

A Data View is a Design Component that defines a connection to an external data source and specifies which data items and fields are available for use in document generation. Data Views enable:

- Populating value lists (drop-downs, data grids, check boxes, or option buttons) from live data
- Linking Active Fields to data columns so that selecting a record fills in multiple fields at once
- Filtering data based on user input or other Active Field values
- Importing field definitions from a data source directly into a Template or Active Snippet

Data Views support Microsoft Access, Microsoft Excel, OLE DB data sources (including SQL Server), and web services.

## Creating a New Data View

Data Views are created using the Data View Wizard, which guides through the full configuration of the data connection, field selection, filtering, sorting, and offline settings.

To launch the Data View Wizard:

1. In ActiveDocs WorkCenter Client, navigate to the **Data Views** node.
2. Right-click and select **New > Data View**, or use the **New** button on the ribbon.

### Step 1: Welcome

The Welcome page introduces the Data View Wizard. Click **Next** to proceed.

### Step 2: Select Data Source

Select the type of data source for the Data View:

- **Microsoft Access** — Connect to an Access database (.mdb or .accdb).
- **Microsoft Excel** — Connect to an Excel spreadsheet (.xls or .xlsx).
- **OLE DB** — Connect to any OLE DB-compliant data source, including SQL Server.

Click **Next** to proceed.

### Step 3: Select Data Source Location

The location page varies depending on the data source type selected.

**For Microsoft Access:**

- **Database** — Click the ellipsis button to browse to and select the Access database file.
- **Credential options** — Select the authentication method:
  - **Use Pre-set Named Credentials** — Use credentials from the dedicated list in ActiveDocs Server.
  - **Use Default Credentials** — Use the default credentials specified for the ActiveDocs Document Service logon identity.
  - **Use Username and Password below** — Enter specific credentials to override the default.

**For Microsoft Excel:**

- **Spreadsheet** — Click the ellipsis button to browse to and select the Excel file.
- **Credential options** — Same as for Access (see above).

**For OLE DB:**

- **Connection String** — Enter or build the OLE DB connection string. Click **Build** to use the Data Link Properties dialog to construct the connection string interactively.
- **Credential options** — Same as for Access (see above).

> **NOTE:** The path to the data source must be accessible from the ActiveDocs Server. When using a file-based source, use a UNC path rather than a mapped drive letter.

Click **Next** to proceed.

### Step 4: Select Data Item

Select the specific table, view, query, or named range to use as the data source:

- For Access, the list shows tables and queries in the database.
- For Excel, the list shows named ranges and sheet names.
- For OLE DB, the list shows tables and views available through the connection.

Select the desired data item and click **Next**.

### Step 5: Select Display Fields

Choose which columns from the data item to include in the Data View. The available columns are listed with check boxes.

The following options are available for each selected field:

| Option | Description |
| --- | --- |
| **Make Key** | Designates the field as the key field. The key field uniquely identifies each record and is used when linking Active Fields to the Data View. Only one field can be the key. |
| **Rename** | Changes the display name of the field as it appears in the Data View. The underlying column name is not affected. |
| **Format** | Sets the display format for the field (e.g., date format, number format). Click to open the Format dialog for the selected field. |

Select the desired fields, configure options as needed, and click **Next**.

### Step 6: Define Filter

Optionally define a static filter to limit the records returned by the Data View. The filter builder allows you to construct conditions using:

| Element | Description |
| --- | --- |
| **Field** | The data column to filter on. |
| **Operator** | The comparison operator (e.g., Equals, Not Equals, Greater Than, Less Than, Contains, Starts With, Ends With). |
| **Value** | The value to compare against. |

- Click **Add** to add a filter condition row.
- Use the **Joiner** column to combine multiple conditions with **And** or **Or**.
- Use **Parentheses** to group conditions and control evaluation order.

> **TIP:** Static filters defined here apply every time the Data View is used. For dynamic filtering based on user input at document generation time, use the filter on the Active Field instead (see Defining a Filter on an Active Field below).

Click **Next** to proceed.

### Step 7: Define Sort Order

Specify the default sort order for records returned by the Data View:

1. Select a field from the **Available Fields** list.
2. Click **Add** to move it to the **Sort Fields** list.
3. Choose **Ascending** or **Descending** for each sort field.
4. Use the **Move Up** and **Move Down** buttons to adjust the sort priority.

Click **Next** to proceed.

### Step 8: Offline Settings

Configure how the Data View behaves when offline access is needed. Offline settings determine whether the Data View data is cached locally for use when the data source is unavailable.

| Option | Description |
| --- | --- |
| **Do not make available offline** | The Data View requires a live connection to the data source at all times. |
| **Make available offline using a snapshot** | A snapshot of the data is cached locally. The snapshot is taken when the Data View is made offline. |
| **Make available offline and synchronize** | The data is cached locally and synchronized with the data source at a defined interval. |
| **Synchronization interval** | When synchronization is enabled, specify how often (in minutes) the local cache is refreshed from the data source. |

> **NOTE:** Offline Data Views must also be enabled from the WorkCenter Client **File > Options** menu. See How to Make Data Views Offline in Designer below.

Click **Next**, review the summary, and click **Finish** to create the Data View.

## Data View Connection Manager

The Data View Connection Manager provides a centralized interface for reviewing and modifying the connection settings of existing Data Views without opening each one individually through the wizard.

To open the Data View Connection Manager:

1. In ActiveDocs WorkCenter Client, select the **Data Views** node.
2. Click **Connection Manager** on the ribbon, or right-click the Data Views node and select **Connection Manager**.

The Connection Manager displays all Data Views in the current WorkCenter Site along with their connection details.

From the Connection Manager, you can:

- View the data source type, location, and credentials for each Data View.
- Edit the connection string or file path for a Data View.
- Change credential settings.
- Test the connection to verify that the data source is accessible.

To modify a Data View connection:

1. Select the Data View in the list.
2. Click **Edit** to open the connection settings.
3. Modify the data source location, connection string, or credentials as needed.
4. Click **Test Connection** to verify the new settings.
5. Click **OK** to save changes.

> **TIP:** The Connection Manager is useful when a data source has been moved to a new server or file location and multiple Data Views need to be updated.

## How to Find Additional Information about a Data View

To view detailed information about a Data View:

1. In ActiveDocs WorkCenter Client, navigate to the **Data Views** node.
2. Right-click the Data View and select **Properties**.
3. The Properties dialog shows the Data View's general information, connection details, field definitions, filter settings, sort order, and offline configuration.

Alternatively, select the Data View and use the **Preview Pane** (available from the View tab) to see a summary of the Data View configuration.

## How to Make Data Views Offline in Designer

To enable offline Data Views for the Designer environment:

1. In ActiveDocs WorkCenter Client, go to **File > Options**.
2. In the Options dialog, locate the **Offline Data Views** section.
3. Select **Enable offline Data Views**.
4. Choose the Data Views to make available offline by selecting them from the list.
5. Click **Synchronize Now** to take an initial snapshot of the data, or allow automatic synchronization at the configured interval.
6. Click **OK** to save.

> **NOTE:** Offline Data Views store a local copy of the data. Ensure that any data sensitivity requirements are considered before enabling offline access.

## How to Import a Static List of Values from a Data View

A static list of values can be imported from a Data View into an Active Field's value list. This creates a fixed copy of the data at the time of import — the list does not update automatically when the data source changes.

To import a static list:

1. In the Template or Active Snippet, open the **Design Items** pane.
2. Select or create the Active Field that will hold the value list.
3. Open the Active Field's **Properties**.
4. Navigate to the **Value List** tab.
5. Click **Import List**.
6. Select the Data View to import from.
7. Select the **Value Column** — the column whose values will be stored as the Active Field's value.
8. Optionally select a **Display Column** — the column whose values will be displayed to the user (if different from the stored value).
9. Click **OK** to import.

The imported values appear in the Active Field's value list and can be edited, reordered, or removed individually after import.

> **NOTE:** Because this is a static import, changes to the underlying data source are not reflected automatically. To refresh the list, repeat the import process.

## How to Link Design Items to a Data View

Linking an Active Field to a Data View creates a live connection so that the value list is populated dynamically from the data source each time the Document Wizard runs.

To link an Active Field to a Data View:

1. In the Template or Active Snippet, open the **Design Items** pane.
2. Select or create the Active Field to link.
3. Open the Active Field's **Properties**.
4. Navigate to the **Value List** tab.
5. Click **Link List**.
6. Select the Data View to link to.
7. Configure the following:
   - **Value Column** — The column whose values are stored as the Active Field's value when a record is selected.
   - **Display Column** — The column whose values are shown to the user in the Document Wizard. This can be the same as or different from the Value Column.
8. Click **OK** to apply the link.

Once linked, the Active Field's value list is populated from the Data View at runtime. If the Data View's data changes, the value list reflects those changes automatically.

## Selecting the Format for a Value List

When an Active Field has a value list (whether static or linked to a Data View), the format controls how the list is presented to the user in the Document Wizard.

The available formats are:

| Format | Description |
| --- | --- |
| **Drop Down** | Displays the value list as a drop-down list. The user selects one value. This is the default format. |
| **Data Grid** | Displays the value list in a tabular grid showing multiple columns. Useful when the user needs to see several fields to make a selection. |
| **Check Boxes** | Displays each value as a check box. The user can select multiple values. |
| **Option Buttons** | Displays each value as a radio button. The user selects exactly one value. |

To set the format:

1. Open the Active Field's **Properties**.
2. Navigate to the **Value List** tab.
3. Select the desired format from the **Display Format** option.
4. Click **OK**.

> **TIP:** Use **Data Grid** format when linking to a Data View with multiple display columns, so the user can see all relevant information when making a selection.

## Auto Populate from Filtered Data Views or Snippets

The **Auto Populate** option on a local Template Active Field allows it to be automatically filled with a value from a filtered Data View or Snippet, rather than requiring the user to select or enter a value manually.

When Auto Populate is enabled:

- The Active Field's value is determined automatically based on the result of a filtered Data View query or Snippet evaluation.
- If the filter returns exactly one record, the Active Field is populated with the value from the specified column.
- If the filter returns zero or multiple records, the behavior depends on the configuration (the field may be left blank or the user may be prompted).

To configure Auto Populate:

1. Open the Active Field's **Properties**.
2. Enable the **Auto Populate** option.
3. Select the Data View or Snippet to use as the source.
4. Configure the filter to narrow results to a single record where possible.
5. Specify which column provides the value.

> **NOTE:** Auto Populate is available only on local Template Active Fields, not on fields in Design Item Sets.

## Defining a Filter on an Active Field

A filter on an Active Field limits the records shown in a Data View-linked value list based on conditions evaluated at runtime. This enables cascading selections where one Active Field's value filters the options available in another.

To define a filter:

1. Open the Active Field's **Properties**.
2. Navigate to the **Value List** tab.
3. Click **Filter** to open the Build Filter dialog.

The Build Filter dialog provides the following elements:

| Element | Description |
| --- | --- |
| **Field** | The Data View column to filter on. |
| **Operator** | The comparison operator: Equals, Not Equals, Greater Than, Less Than, Greater Than or Equal, Less Than or Equal, Contains, Starts With, Ends With, Is Blank, Is Not Blank. |
| **Value** | The value to compare against. This can be a fixed value or a reference to another Active Field (enabling cascading filters). |

### Building Filter Conditions

1. Click **Add** to add a new condition row.
2. Select the **Field**, **Operator**, and **Value** for the condition.
3. To add additional conditions, click **Add** again.
4. Use the **Joiner** column to specify **And** or **Or** between conditions:
   - **And** — All conditions must be true for a record to be included.
   - **Or** — Any condition being true includes the record.
5. Use **Parentheses** to group conditions and control the order of evaluation. This is important when mixing And and Or joiners.

To reference another Active Field as the filter value, select the Active Field from the value drop-down. This creates a dynamic filter — when the referenced Active Field's value changes in the Document Wizard, the filtered list updates automatically.

> **TIP:** Cascading filters are commonly used for scenarios such as selecting a Country, then filtering a State/Province list based on the selected Country, then filtering a City list based on the selected State/Province.

> **NOTE:** Filters defined on the Active Field are evaluated at runtime and are separate from any static filters defined on the Data View itself. Both filters are applied — the Data View filter first, then the Active Field filter.
