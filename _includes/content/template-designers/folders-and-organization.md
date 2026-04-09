Your organization may need to set out Design Components in a Folder structure, to separate them into smaller groupings or by business area. Folders may reflect Design requirements and Business requirements.

## Creating a Folder

To create a folder in the **Templates node**:

1. Right-click the **Templates node** and select **New > Folder** from the shortcut menu. You can create subfolders by performing the same action on an existing Folder.
2. The **Folder Properties** dialog opens.

### General Tab

- **Name** — Enter a name for the folder.
- **Description** — Optionally provide a description. This is recommended as good Design practice.
- **View Template Sets only within the WorkCenter** — Select if you want WorkCenter users to see only Template Sets versus individual Templates.

> **NOTE:** This setting is only available on Folders in the Templates node.

### Mapping Tab

The Mapping tab applies only to Template and Snippet folders at the top level. Subfolders inherit the settings.

Folders usually relate to the ActiveDocs Database; however, you can map Folders to an external location:

- **Type** — Select the source location:
  - ActiveDocs Database (Internal)
  - SharePoint (External)
  - File System (External)
  - WebDAV (External)
- **Location** — Required if the mapping type is set to an external location. Click the Ellipsis to browse and select, or enter, the external location.
- **Use as read only import folder** — Available only for external locations. Select to limit the folder to importing components. Imported components are visible but not viewable or editable (other than having viewable Properties). To edit them, move them to an accessible folder.
- **Credential options:**
  - **Use Pre-set Named Credentials** — Use credentials from a dedicated list in ActiveDocs Server.
  - **Use Default Credentials** — Uses the default credentials specified for the ActiveDocs Document Service logon identity.
  - **Use Username and Password below** — Enter specific credentials to override the default service credentials.

> **NOTE:** The URL to the file path must use a UNC path name when using an external location.

### Approval Tab

The Approval tab applies only to Template and Snippet folders at the top level. Subfolders inherit the settings.

> **NOTE:** ActiveDocs provides Document Approval and Design Approval, which are separate features. Each requires its own dedicated User Group(s) with related roles, rights, and permissions. The Approval tab here covers Design Approval folder settings.

- **Enable Approval** — Enable content approval on the folder.
- **All Approvers must approve** — Require all users in the Approvers group to approve Design Components before they are available for use. Otherwise, only one user from the Approvers group is required.
- **Email Approvers when checked in for approval** — Email all users in the Approvers group on creation or modification of a Design Component.
- **Enable Approver Email Reminders** — Send up to two reminder emails every 5 working days while the Design Component is pending approval.
- **Email the Designer when approved or declined** — Notify the Designer by email regarding the Approval or Disapproval of a Design Component.
- **Allow the Designer to choose an Approver** — Allow the Designer to choose an Approver from the Approvers group.

### Subsites Tab

The Subsites tab applies only to Template and Snippet folders at the top level. Subfolders inherit the settings.

You can assign folders to one or more Subsites to manage Design Component availability in the Document Wizard. Only users in User Groups with access to those Subsites can use those Design Components.

- **All Subsites (Global Folder)** — The folder is visible to all Subsites.
- **Use in the following Subsites** — Select each Subsite in which the folder needs to be visible.

Click **OK** to save.

## Moving Multiple Folders

1. **Ctrl + click** or **Shift + click** to select multiple folders from a node.
2. Right-click the selection and select **Move To** from the shortcut menu.
3. Select the node's root Folder, or another existing Folder, into which you want to move the selected folders.

## Working with Categories

Categories are keywords or phrases that help you keep track of different types of Design Components that are related but may be stored in different folders. You can use Categories to organize Design Components in each WorkCenter Site.

### Creating a Category

1. In the **ActiveDocs WorkCenter Client Navigation pane**, select the **Categories node**.
2. On the **Home Ribbon**, click **New > Category**. Alternatively, right-click the **Categories node** and select **New > Category** from the shortcut menu.
3. Under the **General tab**:
   - **Name** — Enter a name for the Category.
   - **Description** — Optionally provide a description for the Category.
   - **WorkCenter Template Category** — Optionally select to enable users to select and run templates from Categories in the WorkCenter.
   - **Outlook Template Category** — Optionally select to make the Category available in Microsoft Outlook for ActiveDocs email generation.
4. Under the **Document Wizard Order tab**:
   - **Order Snippets in alphabetical order** — Select to display Snippets in alphabetical order.
   - **Display the Snippets in the following order** — Select to display Snippets in a custom order.
   - Use **Move Up / Move Down** to change the display order.
5. Click **OK**.

> **NOTE:** To modify a Category, right-click it and select **Properties** from the shortcut menu. Delete it by selecting **Delete** from the shortcut menu.

### Applying a Category

1. Select one or more Design Components from the **List pane**, then right-click and select **Categorize** from the shortcut menu.
2. Select one or more desired categories.
3. Click **OK**.

> **NOTE:** To break the link between a Design Component and a Category, do not delete the Design Component in the Category list. Instead, edit the properties of the Design Component, click the **Categories tab**, and deselect the Category or click **Clear**.

> **NOTE:** Exporting and importing a Design Component between WorkCenter Sites retains its associated Categories.

## Deleted Items

The **Deleted Items node** holds deleted Design Components prior to final purging. To restore a Design Component to its original location, select the item and click **Restore** on the **Home Ribbon**. Alternatively, right-click and select **Restore** from the shortcut menu.

## Search Node

The **Search node** displays Design Components based on the search criteria used in the Search text box and the Design Component type selected on the **WorkCenter Client Search Tab Ribbon**.
