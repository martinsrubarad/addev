Design Item Sets are collections of Design Items that are managed as a single unit and can be linked to multiple Templates and Snippets. They provide centralized control over shared Design Items, enabling consistency and efficiency across an organization's document Templates.

## What Are Design Item Sets?

A Design Item Set is a Design Component that contains a named collection of Design Items — Active Fields, Groups, Repeating Item Groups, Rules, Snippet Links, and Charts. Design Item Sets are created and maintained in the ActiveDocs WorkCenter Client and can be linked to any number of Templates and Snippets.

Design Item Sets include their own editor for managing the contained Design Items. They support version control through the WorkCenter Site, allowing changes to be tracked, reviewed, and rolled back as needed.

ActiveDocs includes the following pre-made Design Item Sets:

| Design Item Set | Description |
| --- | --- |
| **Delivery Fields** | Contains Active Fields for document delivery options such as delivery method, recipient address, and distribution settings. |
| **Finalization Workflow Fields** | Contains Active Fields for workflow-related settings such as approval status, review dates, and finalization options. |
| **User Profile Fields** | Contains Active Fields for capturing user profile information such as user name, department, role, and contact details. |

## Advantages of Design Item Sets

Design Item Sets provide the following advantages:

- **Consistency** — When the same Design Items are used across multiple Templates, a Design Item Set ensures that all Templates use identical definitions. Changes made to the Design Item Set propagate to all linked Templates automatically.
- **Speed** — Linking a Design Item Set to a Template adds multiple Design Items in a single operation, rather than creating each one individually or importing copies.
- **Auto-propagation** — When a Design Item in a Design Item Set is modified, the change is automatically reflected in every Template and Snippet that links to that set. This eliminates the need to update each Template individually.
- **Team standards** — Design Item Sets enable teams to define and enforce standard Design Items across an organization. Centralized ownership of the Design Item Set ensures that changes are reviewed and controlled.

## Creating a Design Item Set

To create a new Design Item Set:

1. In the ActiveDocs WorkCenter Client, navigate to the **Design Item Sets** node in the navigation tree.
2. Right-click and select **New**, or click the **New** button on the ribbon.
3. A new Design Item Set opens in the Design Item Set editor.

### General Tab

| Property | Description |
| --- | --- |
| **Name** | The name of the Design Item Set as it appears in the WorkCenter Site. Choose a clear, descriptive name that indicates the set's purpose and content. |
| **Description** | An optional description providing additional detail about the Design Item Set's purpose, contents, or usage guidelines. |
| **Prefix** | An optional prefix string that is prepended to the names of all Design Items in the set when they are linked to a Template or Snippet. The prefix helps distinguish Design Item Set items from local items and avoids naming conflicts. |

### Categories

Categories classify the Design Item Set for organizational and filtering purposes. Assign one or more categories to make the set easier to locate when browsing or filtering in the WorkCenter Site.

To assign categories, select the appropriate category check boxes in the Categories section.

## Adding Design Items to a Design Item Set

Design Items are added to a Design Item Set using the Design Item Set editor, which provides the same interface as the Design Items dialog in a Template.

To add Design Items:

1. Open the Design Item Set in the WorkCenter Client.
2. The Design Item Set editor opens, displaying the Navigation Pane and properties panels.
3. Right-click in the Navigation Pane and select the type of Design Item to add (e.g., **New Group**, **New Active Field**, **New Rule**, **New Snippet Link**, **New Repeating Item Group**).
4. Configure the Design Item's properties using the same options available in the Template Design Items dialog.
5. Repeat for all Design Items to include in the set.
6. Save the Design Item Set.

### Import Design Items

Existing Design Items can be imported into a Design Item Set from other Design Components (Templates, Snippets, or other Design Item Sets), Data Views, or XML files. The import process follows the same steps as importing Design Items into a Template.

To import:

1. In the Design Item Set editor, click **Import** on the Home ribbon.
2. Select the import source type and follow the import wizard steps.

> **TIP:** Importing is useful when consolidating Design Items from existing Templates into a centralized Design Item Set.

## Adding a Design Item Set to a Template or Snippet

A Design Item Set is linked to a Template or Snippet through the Design Items dialog.

To link a Design Item Set:

1. Open the Template or Snippet in Microsoft Word with the ActiveDocs Ribbon.
2. Open the **Design Items** dialog.
3. On the Home ribbon, click the **Design Item Set** button.
4. The **Select Design Item Set** dialog opens, listing available Design Item Sets from the WorkCenter Site.
5. Select one or more Design Item Sets. Use **Ctrl+click** to select multiple individual sets, or **Shift+click** to select a contiguous range.
6. Click **OK** to link the selected sets.

The Design Items from the linked sets appear in the Design Items dialog Navigation Pane. They are visually distinguished from local Design Items to indicate they originate from a linked set.

> **NOTE:** Design Items that belong to a linked Design Item Set cannot be edited within the Template. To modify these items, open the Design Item Set directly in the WorkCenter Client, make the changes, and save the set. The changes propagate automatically to all linked Templates and Snippets.

## Creating a Design Item Set from a Template

A Design Item Set can be created from an existing Template's Design Items. This is useful when a Template contains Design Items that should be shared across other Templates.

To create a Design Item Set from a Template:

1. In the ActiveDocs WorkCenter Client, navigate to the **Design Item Sets** node.
2. Right-click and select **New > Design Item Set from Template**.
3. In the dialog that appears, browse to and select the source **Template** from the WorkCenter Site.
4. Click **Next**.
5. Configure the **General** tab properties for the new Design Item Set, including Name, Description, and Prefix.
6. Click **Finish** to create the set.

The new Design Item Set contains copies of all Design Items from the source Template. These are independent copies — subsequent changes to the source Template do not affect the Design Item Set, and vice versa.

> **TIP:** After creating a Design Item Set from a Template, consider imposing the set back onto the original Template (see Imposing a Design Item Set below) to replace the local copies with linked references. This establishes the Design Item Set as the single source of truth for those items.

## Imposing a Design Item Set

Imposing a Design Item Set replaces existing local Design Items in a Template or Snippet with linked references to the corresponding items in the Design Item Set. This is used when a Template already contains Design Items that should now be managed centrally through a Design Item Set.

There are two approaches to imposing: Auto Impose and Manual Impose.

### Auto Impose

Auto Impose automatically matches local Design Items in the Template to Design Items in the Design Item Set by name. Matched items are replaced with linked references to the set.

To use Auto Impose:

1. Link the Design Item Set to the Template (if not already linked).
2. In the Design Items dialog, right-click the linked Design Item Set and select **Auto Impose**.
3. The system compares Design Item names in the Template with names in the Design Item Set.
4. **Matched Design Items** — Local items with names matching items in the set are replaced with linked references. The local copies are removed.
5. A summary of matched items is displayed. Review the matches to confirm they are correct.
6. Click **OK** to apply.

### Manual Impose

Manual Impose provides control over which local Design Items are mapped to which Design Item Set items, even when names do not match exactly.

To use Manual Impose:

1. Link the Design Item Set to the Template (if not already linked).
2. In the Design Items dialog, right-click the linked Design Item Set and select **Manual Impose**.
3. The **Map Group** dialog opens, listing local Design Items on one side and Design Item Set items on the other.
4. Select a local Design Item and a corresponding Design Item Set item.
5. Click **Map** to create the mapping between the two items.
6. Repeat for all items to be mapped.
7. Click **OK** to apply the mappings.

Mapped local items are replaced with linked references to the Design Item Set items. Unmapped local items remain as local Design Items.

> **TIP:** Use Auto Impose when Design Item names in the Template already match the names in the Design Item Set. Use Manual Impose when names differ or when only a subset of items should be imposed.

### Unimpose

To reverse an impose operation and convert linked references back to local Design Items, use the **Unimpose** function. Unimposing creates local copies of the Design Item Set items in the Template, severing the link to the set. Subsequent changes to the Design Item Set no longer propagate to the unimposed items.

> **NOTE:** Unimposing a Design Item Set does not delete the set itself. It only removes the link between the Template and the set, converting the linked references to independent local copies.

## Deleting a Design Item Set from a Template or Snippet

When a Design Item Set is removed from a Template or Snippet, the linked Design Items must be handled. The **Remove** dialog provides options for managing the items.

To remove a Design Item Set:

1. Open the **Design Items** dialog in the Template or Snippet.
2. Right-click the linked Design Item Set in the Navigation Pane and select **Remove**.
3. The **Remove** dialog presents the following options:

| Option | Description |
| --- | --- |
| **Copy all items with prefix** | All Design Items from the set are converted to local copies in the Template. The original prefix (from the Design Item Set's Prefix property) is retained on the item names. |
| **Copy all items without prefix** | All Design Items from the set are converted to local copies in the Template. The prefix is stripped from the item names. |
| **Delete all items** | All Design Items from the set are removed from the Template entirely. Any markers in the Template body that reference these items become invalid. |

4. Select the appropriate option and click **OK**.

> **TIP:** Use **Copy all items** (with or without prefix) when the Template still needs the Design Items but no longer requires the centralized link. Use **Delete all items** only when the Design Items are no longer needed in the Template.

> **NOTE:** Deleting all items from a removed Design Item Set affects the Template's local Design Items only. The Design Item Set itself is not modified or deleted from the WorkCenter Site. Other Templates linked to the same Design Item Set are unaffected.
