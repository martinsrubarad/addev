The ActiveDocs Microsoft Outlook Integration provides an add-in for Microsoft Outlook that enables users to create and respond to emails using ActiveDocs Templates, Template Sets, and Snippets directly from within Outlook.

## Creating a New Email Using an ActiveDocs Template

To create a new email using an ActiveDocs Template:

1. In Outlook, navigate to the **ActiveDocs Group** on the ribbon.
2. Click **New Email in ActiveDocs Group**.
3. The Template selection dialog opens. Browse to and select a **Template**, **Template Set**, or **Snippet** to use as the basis for the email.
4. The **Document Wizard** opens, presenting the Design Items from the selected component. Complete the questions and prompts as required.
5. Click **Finish** to complete the Document Wizard.
6. Outlook opens a new email composition window with the generated content populated in the email body.
7. Add recipients, adjust the subject line, and make any final edits before sending.

> **NOTE:** When using a Template Set, the content placement in the email depends on the Template Set's delivery configuration. Templates configured with **Deliver as Email body** provide the main email content, while Templates configured with **Deliver with Delivery Format** are included as attachments.

> **NOTE:** When the Template or Template Set includes a **Delivery Fields Design Item Set**, the delivery field values (such as recipient addresses and subject line) are automatically populated from the answers provided in the Document Wizard.

## Responding to an Email Using an ActiveDocs Template

ActiveDocs Templates can be used when replying to or forwarding existing emails. This allows standardized response content to be generated from Templates while maintaining the email conversation thread.

To respond to an email using an ActiveDocs Template:

1. Select the email to respond to in Outlook.
2. In the **ActiveDocs Group** on the ribbon, click **Reply**, **Reply All**, or **Forward**.
3. The Template selection dialog opens. Browse to and select the Template, Template Set, or Snippet to use for the response.
4. The **Document Wizard** opens. Complete the questions and prompts as required.
5. Click **Finish** to complete the Document Wizard.
6. Outlook opens the reply or forward composition window with the generated content inserted above the original email thread.
7. Review and edit the response as needed before sending.

## The ActiveDocs Snippet Pane

The ActiveDocs Snippet Pane provides quick access to Snippets for insertion into an email being composed. It is available when composing, replying to, or forwarding an email.

To open the Snippet Pane:

1. In the email composition window, navigate to the **Insert** tab.
2. Click **Insert Snippet** to open the ActiveDocs Snippet Pane.

### Search Function

The Snippet Pane includes a search field. Type a search term to filter the available Snippets by name, description, category, or tag. Results update as you type.

### Show Snippet Dropdown

The **Show Snippet** dropdown filters the displayed Snippets by type or category. Use this dropdown to narrow the list to a specific subset of available Snippets.

### Actions

The Snippet Pane provides the following actions for the selected Snippet:

| Action | Description |
| --- | --- |
| **Insert using Wizard** | Inserts the selected Snippet at the cursor position in the email body and opens the Document Wizard for the Snippet's Design Items (applicable to Active Snippets). |
| **Insert Snippet** | Inserts the selected Snippet's content directly at the cursor position in the email body without launching the wizard. |
| **Preview Snippet** | Opens a preview of the Snippet's content, using the Preview URL if one has been configured. |
