Design Items can be imported into a Template or Active Snippet from three sources: other Design Components (Templates, Active Snippets, or Design Item Sets), Data Views, and XML files. Importing streamlines the setup of Design Items by reusing definitions that already exist elsewhere.

## Importing Design Items from Another Design Component

Design Items can be imported from an existing Template, Active Snippet, or Design Item Set. This copies the Design Item definitions into the current component, creating independent local copies.

To import Design Items from another Design Component:

1. Open the **Design Items** dialog in the Template or Active Snippet.
2. On the Home ribbon, click **Import**, then select **From Design Component**.
3. In the **Select Import Source** step, choose the type of source:
   - **Template** — Browse to and select a Template from the WorkCenter Site.
   - **Active Snippet** — Browse to and select an Active Snippet from the WorkCenter Site.
   - **Design Item Set** — Browse to and select a Design Item Set from the WorkCenter Site.
4. Click **Next** to proceed.
5. In the **Select Design Items** step, the available Design Items from the source are displayed in a tree view. Select the check box next to each Design Item to import. Use **Select All** or **Deselect All** to manage the selection quickly.
6. Click **Next** to proceed.
7. In the **Import** step, review the items to be imported. Optionally enable the **Add prefix** option and enter a prefix string. When enabled, all imported Design Item names are prepended with the specified prefix, which helps avoid naming conflicts with existing Design Items.
8. Click **Finish** to complete the import.

The imported Design Items appear in the Design Items dialog and are available for use in the Template or Active Snippet. They are independent copies — changes to the source do not affect the imported items, and vice versa.

> **TIP:** Use the prefix option when importing items that may share names with items already present in the Template. A prefix such as the source component name or an abbreviation prevents naming collisions and makes it easier to identify the origin of imported items.

> **NOTE:** Importing from a Design Item Set creates local copies of the items. This is distinct from linking a Design Item Set, which maintains a live connection to the set. Use import when local customization is needed; use linking when centralized maintenance is preferred.

## Importing Design Items from a Data View

Design Items can be imported from a Data View, which creates Active Fields based on the columns defined in the Data View. This is useful for quickly setting up a set of Active Fields that correspond to data source columns.

To import Design Items from a Data View:

1. Open the **Design Items** dialog in the Template or Active Snippet.
2. On the Home ribbon, click **Import**, then select **From Data View**.
3. In the **Select Data View** step, browse to and select the Data View from the WorkCenter Site. Click **Next**.
4. In the **Select Data View Fields** step, the columns available in the Data View are listed. Select the fields to import by checking the box next to each one.
5. For each selected field, configure the following options:

| Option | Description |
| --- | --- |
| **Optionality** | Specify whether the Active Field is required or optional in the Document Wizard. |
| **Entry Type** | Set the entry type for the Active Field (e.g., Text, Number, Date, Value List). The wizard suggests an appropriate type based on the data source column type. |
| **Rename** | Change the name of the Active Field. By default, the Data View column name is used. |

6. Click **Next** to proceed.
7. In the **Link or Group Active Fields** step, configure how the imported fields relate to the Data View and to each other:
   - **Link Active Fields** — Choose whether to link the imported Active Fields back to the Data View so their value lists are populated dynamically at runtime.
   - **Group Active Fields** — Choose whether to place the imported Active Fields into a new or existing Group. Specify the Group name if creating a new one.
8. Click **Finish** to complete the import.

The imported Active Fields are created in the Design Items dialog with the configured properties. If linked, they are connected to the Data View and their value lists are populated from the data source.

> **TIP:** Importing from a Data View and linking the fields in one step saves time compared to creating each Active Field manually and then configuring Data View links individually.

## Importing Design Items from an XML File

Design Items can be imported from an XML file that conforms to the ActiveDocs Design Items XML schema. This allows Design Item definitions to be prepared externally or transferred between environments.

To import Design Items from an XML file:

1. Open the **Design Items** dialog in the Template or Active Snippet.
2. On the Home ribbon, click **Import**, then select **From XML File**.
3. In the file browser dialog, navigate to and select the XML file containing the Design Item definitions.
4. Click **Open**.
5. The import process reads the XML file and creates the corresponding Design Items in the current Template or Active Snippet. A summary of imported items is displayed upon completion.
6. Review the imported items in the Design Items dialog to verify they were created correctly.

> **NOTE:** The XML file must conform to the ActiveDocs Design Items XML schema. Malformed or non-conforming files will produce import errors. Consult the ActiveDocs technical documentation for the schema specification.

> **TIP:** XML import is useful for migrating Design Item definitions between ActiveDocs environments (e.g., from a development site to a production site) or for bulk-creating Design Items from an external tool or script.
