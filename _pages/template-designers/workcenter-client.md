---
title: "Introduction to WorkCenter Client"
permalink: /template-designers/workcenter-client/
layout: single
toc: true
toc_sticky: true
---

The ActiveDocs WorkCenter Client allows Designers to create, access, and manage Design Components.

> **NOTE:** Running Templates using the **Test Template** button in Microsoft Word or Template Sets from ActiveDocs WorkCenter Client allows the Designer to see "Step Context Information" in a Designer Test Mode in the Document Wizard when testing. Hover over the Group name in the Wizard Progress Pane to see the Template Set and/or Template name as well as the Active Field Group name.

## How to Access ActiveDocs WorkCenter Client

To access ActiveDocs WorkCenter Client:

- Select **Start menu > All apps > ActiveDocs > ActiveDocs WorkCenter Client**, or
- In the **ActiveDocs Ribbon** in Word, click **WorkCenter Client**.

## The WorkCenter Client Ribbon

The WorkCenter Client Ribbon contains several ribbon tabs for working with the WorkCenter Client.

### File Tab

- **WorkCenter Sites** — Maintenance of WorkCenter Site Connections including adding, editing, removing and signing out, as well as creating desktop shortcuts and browsing to a WorkCenter Site.
- **Info** — Product information about the current installed version of ActiveDocs.
- **Options** — Make Data Views offline in Designer.
- **Exit** — Closes WorkCenter Client.

### Home Tab

- **Design Components** — Controls for the current selected WorkCenter Site design components.
- **Clipboard** — Cut/Copy/Paste commands.
- **Version Control** — Check In, Check Out, or Discard Check Out.
- **Approval** — Show Components pending approval, view approval history and clear approval notifications.

### Search Tab

The Search tab allows you to search for a specific Design Component within the current WorkCenter Site, or to perform full text searches within a Template and Snippet.

- **Design Component** — Select from a specific Design Component or the All Components option.
- **Search Options:**
  - **My Design Components** — Returns all Design Components created by the user.
  - **Contains this term** — Returns all Design Components containing the search term. If full text search is enabled, the contents of Templates and Snippets will also be searched.
  - **Starts with this term** — Returns all Design Components starting with the search term.
  - **Exactly match this term** — Returns all Design Components exactly matching the search term.
  - **Tag Properties** — Returns all Design Components matching checked terms.
- **Date Modified** — Filter by: All, Today, Yesterday, This Week, Last Week, This Month, Last Month, This Year, or Last Year.
- **Status** — Filter by: Any State, Approved, Not Approved, Checked Out, Draft, or Deferred for Publish.
- **Clear Search** — Clears and resets the current search criteria.

> **NOTE:** Design Components stored in a WorkCenter Site other than the one currently selected in the Navigation pane will not be found, even if the search term matches.

### View Tab

- **Views** — Toggle between List, Details, Large Icons, Small Icons, or Tile.
- **Preview Pane** — Dock at the bottom, on the right, or turn off.
- **Status Bar** — Turn off and on the Status Bar.

## Full Text Search

Full text searching allows you to search the contents of Templates or Snippets stored in the ActiveDocs database. Full text searches can be made from within WorkCenter Client, Microsoft Word or Outlook add-ins, and WorkCenter.

### Running a Full Text Search in WorkCenter Client

1. Click the **Search** tab and select **Contains this term** from the Search Options drop-down.
2. Select **Templates**, **Snippets**, or **Snippets and Templates** from the Design Component drop-down.
3. Enter the desired term as a simple word or phrase in the Search text box. Enclose phrases in double quotes.
4. Press **Enter**.

### Important Notes on Full Text Searching

- In the Microsoft Word or Outlook add-in, full text search is available from the Snippet Pane.
- In WorkCenter, full text search can be performed using the advanced search on the Templates page.
- The **Full Text Search enabled for Templates and Snippets** setting must be enabled in AdminCenter.
- When enabled, ActiveDocs services check for new or existing Templates and Snippets every five minutes, indexing up to 50 items at a time.
- Search terms are case insensitive.
- Punctuation is removed from queries.
- Phrases must be enclosed in double quotes and must appear exactly in order to match.
- New Templates, Snippets, or changes may take up to five minutes before the services index new content.

## Design Components in a WorkCenter Site

Once you have opened the desired WorkCenter Site, each site contains the same types of Design Components represented as type-specific Nodes:

- Templates
- Design Item Sets
- Snippets
- Data Views
- Workflows

> **TIP:** You can use shortcut keystrokes in ActiveDocs WorkCenter Client: ALT + the first letter of the Menu item.
