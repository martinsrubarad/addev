## Standalone Wizard Invocation

The Document Wizard can be launched as a standalone page by navigating directly to `QuestionWizard.aspx` with the appropriate query string parameters. This enables embedding the wizard in external applications, portals, or custom workflows.

### Full URL Example

```
https://your-server/activedocs/QuestionWizard.aspx?TemplateID=4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67&ade_WaitForCompile=true&ade_FinishButtonRedirect=https://yourapp.com/callback
```

## Query String Parameters

The following parameters control wizard behavior when launching via URL.

| Parameter | Type | Description |
| --- | --- | --- |
| `TemplateID` | string | The GUID of the Template Set to load in the wizard. Required. |
| `ade_AnswerID` | string | The GUID of a saved answer file to pre-populate the wizard. When provided, the wizard loads with existing answers. |
| `ade_AllowAnswerFileSelect` | boolean | If `true`, displays a dropdown allowing the user to select from saved answer files. Default: `false`. |
| `ade_WaitForCompile` | boolean | If `true`, the wizard waits for document assembly to complete before redirecting. If `false`, redirects immediately after the job is submitted. Default: `false`. |
| `ade_FinishButtonRedirect` | string | URL to redirect to when the user clicks Finish. ActiveDocs appends result parameters to this URL. |

## Redirect Parameters on Completion

When the wizard completes and redirects to the `ade_FinishButtonRedirect` URL, the following parameters are appended to the query string:

```
https://yourapp.com/callback?ade_action=ok&ade_JobID=ABC123...&ade_DocID=DEF456...
```

| Parameter | Type | Description |
| --- | --- | --- |
| `ade_action` | string | The outcome of the wizard session: `ok` (completed successfully), `resume` (saved for later), or `cancelled` (user cancelled). |
| `ade_JobID` | string | The GUID of the document assembly job created by the wizard. Present when `ade_action` is `ok`. |
| `ade_DocID` | string | The GUID of the primary document produced. Present when `ade_action` is `ok` and `ade_WaitForCompile` was `true`. |

## Passing Answers via Query String

You can pre-populate wizard fields by including answer values directly in the query string. Prefix each field name with `adeAnswer_`:

```
https://your-server/activedocs/QuestionWizard.aspx
  ?TemplateID=4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67
  &adeAnswer_ClientName=Acme%20Corporation
  &adeAnswer_ContractDate=2026-04-09
  &adeAnswer_ContractValue=50000
  &adeAnswer_IncludeWarranty=true
```

The `adeAnswer_` prefix is stripped and the remaining name is matched to the corresponding field in the template. Values are URL-encoded using standard percent-encoding.

This is useful for integrations where your application already has the data and you want to minimize manual entry in the wizard.

## Document Wizard in Popup Windows

For a seamless user experience, launch the Document Wizard in a popup window using JavaScript. This keeps the user in your application context while providing the full wizard interface.

```javascript
function openDocumentWizard(templateId, answers) {
  // Build the URL with template ID
  let url = `https://your-server/activedocs/QuestionWizard.aspx?TemplateID=${templateId}`;

  // Append answer values
  if (answers) {
    for (const [field, value] of Object.entries(answers)) {
      url += `&adeAnswer_${encodeURIComponent(field)}=${encodeURIComponent(value)}`;
    }
  }

  // Add redirect back to the opener
  url += `&ade_WaitForCompile=true`;
  url += `&ade_FinishButtonRedirect=${encodeURIComponent(window.location.href)}`;

  // Open in a popup window
  const wizardWindow = window.open(
    url,
    "ActiveDocsWizard",
    "width=1024,height=768,resizable=yes,scrollbars=yes,status=no,toolbar=no,menubar=no"
  );

  // Focus the popup
  if (wizardWindow) {
    wizardWindow.focus();
  }

  return wizardWindow;
}

// Usage
openDocumentWizard("4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67", {
  ClientName: "Acme Corporation",
  ContractDate: "2026-04-09",
  ContractValue: "50000"
});
```

To handle the wizard result in your application, check the query string parameters when the redirect returns to your page:

```javascript
function handleWizardCallback() {
  const params = new URLSearchParams(window.location.search);
  const action = params.get("ade_action");

  switch (action) {
    case "ok":
      const jobId = params.get("ade_JobID");
      const docId = params.get("ade_DocID");
      console.log(`Document created. Job: ${jobId}, Doc: ${docId}`);
      // Proceed with your workflow
      break;
    case "resume":
      console.log("User saved wizard for later.");
      break;
    case "cancelled":
      console.log("User cancelled the wizard.");
      break;
  }
}
```

## Template Property and Query String Overrides

The following query string parameters override default template properties and site settings when launching the wizard.

### General Site Overrides

| Parameter | Type | Description |
| --- | --- | --- |
| `ade_DateFormat` | string | Override the date display format (e.g., `dd/MM/yyyy`, `MM/dd/yyyy`, `yyyy-MM-dd`). |
| `ade_DefaultTheme` | string | Override the visual theme for the wizard interface. |
| `ade_DisplayHeader` | boolean | Show or hide the ActiveDocs header bar. Set to `false` to remove branding when embedding. |
| `ade_DisplayMenus` | boolean | Show or hide the navigation menus. Set to `false` for a streamlined embedded experience. |
| `ade_Language` | string | Override the wizard language (e.g., `en`, `fr`, `de`, `es`). |
| `ade_SubsiteID` | string | Override the subsite context for the wizard session. |

### Document Wizard Overrides

| Parameter | Type | Description |
| --- | --- | --- |
| `ade_OutputPDF` | boolean | If `true`, produce PDF output. |
| `ade_OutputDOCX` | boolean | If `true`, produce DOCX output. |
| `ade_OutputRTF` | boolean | If `true`, produce RTF output. |
| `ade_ShowStartPage` | boolean | If `true`, display the start page before the first question step. Default: `true`. |
| `ade_WaitForCompile` | boolean | If `true`, wait for document assembly to complete before redirecting. |
| `ade_PromptOnCancel` | boolean | If `true`, display a confirmation dialog when the user clicks Cancel. Default: `true`. |
| `ade_AllowAnswerFileSelect` | boolean | If `true`, allow the user to select and load a saved answer file. |

### Example with Multiple Overrides

```
https://your-server/activedocs/QuestionWizard.aspx
  ?TemplateID=4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67
  &ade_DisplayHeader=false
  &ade_DisplayMenus=false
  &ade_OutputPDF=true
  &ade_ShowStartPage=false
  &ade_WaitForCompile=true
  &ade_PromptOnCancel=false
  &ade_Language=en
  &ade_FinishButtonRedirect=https://yourapp.com/callback
```

## Templates Page Filtering

When directing users to the ActiveDocs templates page (rather than a specific template), you can filter the displayed templates using the following parameters:

| Parameter | Type | Description |
| --- | --- | --- |
| `ade_FilterTemplateCategory` | string | Filter templates by category name. Only templates in the specified category are shown. |
| `ade_FilterTemplateName` | string | Filter templates by name. Supports partial matching. |
| `ade_FilterTemplateID` | string | Filter to a specific template by GUID. |

### Example

```
https://your-server/activedocs/Templates.aspx
  ?ade_FilterTemplateCategory=Contracts
  &ade_DisplayHeader=false
  &ade_DisplayMenus=false
```

## Auto Login with JWT Tokens

For single sign-on (SSO) scenarios, you can bypass the ActiveDocs login page by generating a JWT token and passing it to the `AutoLogin.aspx` page. This enables seamless authentication from your application.

### JWT Payload Structure

```json
{
  "sub": "jsmith",
  "name": "John Smith",
  "email": "jsmith@company.com",
  "iss": "your-application",
  "aud": "activedocs",
  "iat": 1744185600,
  "exp": 1744189200
}
```

| Claim | Type | Description |
| --- | --- | --- |
| `sub` | string | The user's login name in ActiveDocs. Required. |
| `name` | string | The user's display name. |
| `email` | string | The user's email address. |
| `iss` | string | Issuer identifier for your application. |
| `aud` | string | Audience. Must be `"activedocs"`. |
| `iat` | integer | Issued-at time (Unix timestamp). |
| `exp` | integer | Expiration time (Unix timestamp). Recommended: 5 minutes from `iat`. |

### AutoLogin URL

Sign the JWT with the shared secret configured in AdminCenter, then pass it to `AutoLogin.aspx`:

```
https://your-server/activedocs/AutoLogin.aspx
  ?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
  &redirect=/activedocs/QuestionWizard.aspx?TemplateID=4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67
```

The `redirect` parameter specifies where to send the user after authentication. This can be any ActiveDocs page, including the Document Wizard with its own query string parameters.

### JavaScript Example

```javascript
async function autoLoginAndOpenWizard(user, templateId) {
  // Generate JWT (this should typically be done server-side)
  const payload = {
    sub: user.login,
    name: user.displayName,
    email: user.email,
    iss: "your-application",
    aud: "activedocs",
    iat: Math.floor(Date.now() / 1000),
    exp: Math.floor(Date.now() / 1000) + 300 // 5 minutes
  };

  // Sign the token server-side and return it
  const response = await fetch("/api/generate-activedocs-token", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(payload)
  });
  const { token } = await response.json();

  // Build the auto-login URL
  const wizardUrl = `/activedocs/QuestionWizard.aspx?TemplateID=${templateId}`;
  const loginUrl = `https://your-server/activedocs/AutoLogin.aspx`
    + `?token=${encodeURIComponent(token)}`
    + `&redirect=${encodeURIComponent(wizardUrl)}`;

  window.location.href = loginUrl;
}
```

## Programmatic WorkCenter Actions

After a document is produced, you can redirect users to specific WorkCenter action pages to perform operations on documents or document sets.

### Document Set Actions

```
https://your-server/activedocs/DocumentSetActions.aspx
  ?DocumentSetID=4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67
  &action=Finish
```

### Document Actions

```
https://your-server/activedocs/DocumentActions.aspx
  ?DocumentID=A1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6
  &action=DownloadDocument
```

### Available Actions

| Action | Applies To | Description |
| --- | --- | --- |
| `Finish` | Document Set, Document | Marks the document or set as finished and triggers any configured delivery. |
| `DownloadDocument` | Document | Downloads the assembled document file to the user's browser. |
| `DownloadAnswers` | Document | Downloads the answer file used to produce the document. |
| `Recreate` | Document | Re-runs the document assembly using the original answers, producing a fresh copy. |
| `Email` | Document Set, Document | Opens the email delivery dialog for the document or set. |
| `Print` | Document Set, Document | Sends the document or set to the configured print queue. |
| `Deliver` | Document Set, Document | Triggers delivery through the configured delivery channel. |
| `SendForApproval` | Document Set, Document | Submits the document or set into the approval workflow. |
| `Finalize` | Document Set, Document | Locks the document or set, preventing further modifications. |
| `Delete` | Document Set, Document | Deletes the document or set. Requires appropriate permissions. |
