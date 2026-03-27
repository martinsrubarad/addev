---
title: "Folders and Organization"
permalink: /template-designers/folders-and-organization/
layout: single
toc: true
toc_sticky: true
---

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

Categories provide an additional way to classify and organize Design Components beyond folder structure. They allow you to tag Design Components with metadata that can be used for filtering and searching.
