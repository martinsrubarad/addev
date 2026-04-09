The ActiveDocs WorkCenter is a web-based interface that provides end users with access to Templates, document management, delivery, reporting, and administration. Users access the WorkCenter through a web browser from the ActiveDocs WorkCenter Client or directly via URL.

## Sign In

To access the WorkCenter, navigate to the WorkCenter URL in a web browser. Enter valid credentials (username and password) and click **Sign In**. The WorkCenter home page opens, displaying the available tabs based on the user's permissions and role.

## The Sites Tab

The Sites tab provides access to the organizational structure of the ActiveDocs environment.

- **Subsites** — Navigate between subsites to access the Templates, documents, and settings associated with each organizational unit.
- **Workspaces** — View and switch between available workspaces within a subsite.
- **User Groups** — Displays the user groups associated with the current site, showing group membership and permissions.
- **Disabled sites** — Sites that have been disabled are indicated with a distinct icon. Disabled sites are visible for administrative purposes but are not accessible for document generation.

## The Templates Tab

The Templates tab provides access to all available Templates and Template Sets for document generation.

### Folders Tab

The Folders tab displays Templates organized in the folder structure defined in the WorkCenter Client. Navigate through folders to locate the desired Template or Template Set.

### Categories Tab

The Categories tab displays Templates organized by their assigned categories. Select a category to filter the list to Templates assigned to that category.

### Search Templates

Use the search function to locate Templates by name, description, or keyword. Enter a search term in the search field and press Enter or click Search to display matching results.

### Preview

Select a Template and click **Preview** to view a preview of the Template's output. The preview uses the Preview URL configured in the Template's properties.

## Using the Document Wizard

The Document Wizard is the primary interface for generating documents from Templates. When a user selects a Template or Template Set, the Document Wizard opens and presents questions based on the Template's Design Items.

The user completes each page of questions, navigating through Groups and Active Fields. The Wizard collects all required information and then assembles the document using the provided answers and the Template's content and Rules.

## Using an Answer File

Answer files contain previously saved responses to Document Wizard questions. They allow users to pre-populate fields when generating a new document, saving time for recurring or similar documents.

To use an answer file:

1. On the Document Wizard start page, select **Use previously saved answers**.
2. The **Select Answers** page opens, displaying available saved answer files.
3. Browse to and select the desired answer file, or click **Upload an answer file** to upload an answer file from the local file system.
4. Click **OK** to load the answers. The Document Wizard opens with the fields pre-populated from the answer file.
5. Review and modify the pre-populated answers as needed, then proceed through the Wizard to generate the document.

## Document Wizard Navigation

The Document Wizard provides navigation controls for moving through the Wizard pages.

| Button | Description |
| --- | --- |
| **Next** | Advances to the next page of questions. Validates the current page before proceeding. |
| **Previous** | Returns to the previous page of questions. |
| **Finish** | Completes the Document Wizard and begins document assembly. Available when all required fields have been completed. |
| **Cancel** | Cancels the Document Wizard session. A confirmation prompt is displayed. Any answers entered are discarded unless saved as a draft. |
| **Save** | Saves the current answers as a draft, allowing the session to be resumed later. |
| **Save Answers** | Saves the current answers to an answer file for reuse in future Document Wizard sessions. |
| **Help** | Opens the help documentation for the Document Wizard. |

## Wizard Progress Pane

The Wizard Progress Pane appears on the left side of the Document Wizard and provides a visual overview of progress through the Wizard pages.

Each page is displayed with an icon indicating its status:

| Icon | Description |
| --- | --- |
| **Completed** | The page has been visited and all required fields have been answered. |
| **Current** | The page currently being displayed. |
| **Incomplete** | The page has not yet been visited, or it has been visited but contains required fields that have not been answered. |

Click a page entry in the Progress Pane to navigate directly to that page.

## Wizard Progress Bar

The Wizard Progress Bar displays at the top of the Document Wizard and provides a visual indicator of overall completion progress. The bar fills as pages are completed, giving the user an at-a-glance view of how much of the Wizard remains.

## Document Wizard Instructions and User Tips

The Document Wizard displays contextual guidance to assist users in completing questions:

- **Group name** — Displayed as the heading for each page of questions, identifying the current section.
- **Instruction** — Descriptive text displayed below the Group name, providing guidance on how to complete the fields on the current page.
- **User Tip** — Tooltip text displayed when the user hovers over a specific field, providing additional context or guidance for that field.
- **Required fields** are indicated with an **asterisk (*)** next to the field label. If a user attempts to proceed without completing a required field, a **red prompt** is displayed indicating the field must be completed.

## Document Wizard Sub-groups Display

When a Group contains Sub-groups, the Document Wizard displays them as nested sections within the parent Group's page. Sub-groups organize related fields into logical subsections, making complex pages easier to navigate and understand.

## The Documents Tab

The Documents tab provides access to all documents generated through the WorkCenter. Documents are organized into the following views:

| View | Description |
| --- | --- |
| **My Documents** | Displays documents created by the current user. |
| **My Tasks** | Displays documents assigned to the current user for action (e.g., approval, review). |
| **Site Documents** | Displays all documents within the current site, subject to the user's permissions. |
| **All Documents** | Displays all documents across all accessible sites. |

### Document Status Icons

Documents display status icons indicating their current state:

| Icon | Description |
| --- | --- |
| **Draft** | The document is in draft status and has not been finalized. |
| **Pending Approval** | The document has been submitted for approval and is awaiting a decision. |
| **Approved** | The document has been approved. |
| **Declined** | The document has been declined and requires revision. |
| **Finalized** | The document has been finalized and is in its completed state. |
| **Paused** | The Document Wizard was paused before completion. The session can be resumed. |

## Advanced Search and Document Search Results Page

The Advanced Search page provides detailed search criteria for locating documents:

- **Document name** — Search by full or partial document name.
- **Template name** — Filter results to documents generated from a specific Template.
- **Creator** — Filter by the user who created the document.
- **Date range** — Filter by creation date, modification date, or finalization date.
- **Document status** — Filter by status (Draft, Pending Approval, Approved, Declined, Finalized).
- **Category** — Filter by the category of the Template used to generate the document.
- **Subsite** — Filter by the subsite where the document was created.
- **Keywords** — Search by keywords or metadata values associated with the document.

Search results are displayed on the Document Search Results page, where standard document actions are available.

## Document Actions and Paused Document Actions Pages

### Document Actions

The following actions are available for documents, depending on the document's current status and the user's permissions:

| Action | Description |
| --- | --- |
| **Download** | Downloads the document to the local file system. |
| **Update** | Opens the document for editing, allowing modifications to the generated content. |
| **Download Answers** | Downloads the answer file used to generate the document, for reuse or archival. |
| **Recreate** | Regenerates the document from the saved answers and the current version of the Template. |
| **Print** | Sends the document to a printer. |
| **Send** | Sends the document via email or another configured delivery mechanism. |
| **Reassign** | Reassigns ownership of the document to a different user. |
| **Send For Approval** | Submits the document for approval through the configured Workflow. |
| **Edit Approval** | Modifies the approval settings or status of a document that has been submitted for approval. |
| **Recall Approval** | Recalls a document that has been submitted for approval, withdrawing it from the approval process. |
| **Finalize** | Manually triggers finalization of the document, applying all finalization settings from the Workflow. |
| **Delete** | Deletes the document from the system. A confirmation prompt is displayed. |
| **Preview** | Opens a preview of the document in the browser. |
| **Properties** | Displays the document's properties, including metadata, status, and history. |
| **Deliveries** | Displays the delivery history for the document, showing all delivery actions that have been performed. |
| **Version History** | Displays the version history of the document, showing all saved versions and their details. |

### Document Set Actions

When working with a Document Set (generated from a Template Set configured for multiple documents), the actions listed above apply to the set as a whole. Individual documents within the set can also be acted on separately where applicable.

### Paused Document Actions

Documents with a Paused status (where the Document Wizard was not completed) support the following actions:

| Action | Description |
| --- | --- |
| **Resume Wizard** | Reopens the Document Wizard to continue from where the session was paused. |
| **Download Answers** | Downloads the answers entered so far. |
| **Recreate** | Discards the paused session and starts a new Document Wizard session for the same Template. |
| **Rename** | Renames the paused document. |
| **Reassign** | Reassigns the paused document to a different user. |
| **Delete** | Deletes the paused document. |
| **Properties** | Displays the properties of the paused document. |

## The Delivery Management Tab

The Delivery Management tab provides oversight and management of document deliveries. It displays delivery records, statuses, and allows administrators to monitor, retry, or cancel delivery actions across the site.

## The Reports Tab

The Reports tab provides access to reporting tools that summarize document generation activity, usage statistics, and other operational metrics. Reports can be filtered by date range, user, Template, and other criteria.

## The AdminCenter Tab

The AdminCenter tab provides access to administrative settings for the ActiveDocs environment. This tab is available to users with administrative permissions and includes configuration options for sites, users, security, Workflows, and system settings.

## The API Help Tab

The API Help tab provides access to the ActiveDocs API documentation, including endpoint references, parameter descriptions, and usage examples for integrating with the ActiveDocs platform programmatically.

## Sign Out

To sign out of the WorkCenter, click the **Sign Out** link in the top-right corner of the WorkCenter interface. The session is terminated and the user is returned to the sign-in page.
