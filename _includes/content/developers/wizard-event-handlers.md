## Overview

Wizard Step Event Handlers allow you to intercept Document Wizard steps to perform custom validation, inject data, transform answers, or modify job processing. Event handlers execute server-side at specific points in the wizard workflow, enabling deep integration between ActiveDocs and your business logic.

Common use cases include:

- **Validating answers** against external systems (e.g., verifying a customer ID exists in your CRM)
- **Injecting data** from external sources into wizard answers (e.g., populating address fields from a database lookup)
- **Transforming answers** based on business rules before document assembly
- **Modifying the job definition** before it is submitted to the assembly engine
- **Controlling template set selection** based on user context or answer values

## IWizardStepHandler Interface

The `IWizardStepHandler` interface defines the contract for all event handler implementations. It provides access to the wizard context and exposes methods for each interception point.

### Context Properties

| Property | Type | Description |
| --- | --- | --- |
| `UserID` | string | The GUID of the current user running the wizard. |
| `TemplateID` | string | The GUID of the template set being used. |
| `SubsiteID` | string | The GUID of the current subsite context. |
| `Language` | string | The language setting for the current wizard session (e.g., `en`, `fr`). |

### Supports Properties and Methods

Each event handler declares which interception points it supports via `Supports*` properties. Only supported methods are invoked by the wizard engine.

| Property / Method | Description |
| --- | --- |
| `SupportsTransformQuestionsNext` / `TransformQuestionsNext` | Modify the question structure before displaying a step to the user. Use this to show, hide, or reorder questions dynamically. |
| `SupportsValidateAnswersNext` / `ValidateAnswersNext` | Validate answers when the user clicks Next. Return validation errors to prevent the user from advancing. |
| `SupportsTransformAnswersNext` / `TransformAnswersNext` | Transform answer values when the user clicks Next. Use this to compute derived values or normalize data. |
| `SupportsTransformAnswersBack` / `TransformAnswersBack` | Transform answer values when the user clicks Back. Use this to reset computed values when navigating backwards. |
| `SupportsTransformAnswersFinish` / `TransformAnswersFinish` | Transform answer values when the user clicks Finish. Final opportunity to modify answers before job submission. |
| `SupportsTransformJobXML` / `TransformJobXML` | Modify the JobXML/JobDef before it is submitted to the assembly engine. Use this to add delivery queues, modify template selections, or inject additional job settings. |
| `SupportsTransformTemplateSet` / `TransformTemplateSet` | Control template set selection based on user context, answers, or external logic. |

## Implementation Types

### .NET Assembly

Implement the `IWizardStepHandler` interface in a .NET class library and deploy the DLL to the ActiveDocs server.

**Steps:**

1. Create a new .NET Class Library project targeting .NET Framework 4.x.
2. Reference the ActiveDocs SDK assemblies.
3. Implement the `IWizardStepHandler` interface.
4. Build the DLL and deploy it to the ActiveDocs `bin` directory (e.g., `C:\Program Files\ActiveDocs\Solutions Studio\bin\`).
5. In AdminCenter, navigate to **Configuration > Event Handlers** and register the assembly.
6. Restart IIS to load the new assembly.

```csharp
using ActiveDocs.SDK;

public class CustomStepHandler : IWizardStepHandler
{
    public string UserID { get; set; }
    public string TemplateID { get; set; }
    public string SubsiteID { get; set; }
    public string Language { get; set; }

    public bool SupportsTransformQuestionsNext => false;
    public bool SupportsValidateAnswersNext => true;
    public bool SupportsTransformAnswersNext => true;
    public bool SupportsTransformAnswersBack => false;
    public bool SupportsTransformAnswersFinish => true;
    public bool SupportsTransformJobXML => false;
    public bool SupportsTransformTemplateSet => false;

    public WizardStepResult ValidateAnswersNext(WizardStepContext context)
    {
        var result = new WizardStepResult();
        string email = context.GetAnswerValue("EmailAddress");

        if (!string.IsNullOrEmpty(email) && !email.Contains("@"))
        {
            result.AddError("EmailAddress", "Please enter a valid email address.");
        }

        return result;
    }

    public WizardStepResult TransformAnswersNext(WizardStepContext context)
    {
        var result = new WizardStepResult();
        string firstName = context.GetAnswerValue("FirstName");
        string lastName = context.GetAnswerValue("LastName");

        context.SetAnswerValue("FullName", $"{firstName} {lastName}");

        return result;
    }

    public WizardStepResult TransformAnswersFinish(WizardStepContext context)
    {
        var result = new WizardStepResult();
        // Final transformations before job submission
        context.SetAnswerValue("ProcessedDate", DateTime.Now.ToString("yyyy-MM-dd HH:mm"));
        return result;
    }

    // Remaining methods return empty results
    public WizardStepResult TransformQuestionsNext(WizardStepContext context) => new WizardStepResult();
    public WizardStepResult TransformAnswersBack(WizardStepContext context) => new WizardStepResult();
    public WizardStepResult TransformJobXML(WizardStepContext context) => new WizardStepResult();
    public WizardStepResult TransformTemplateSet(WizardStepContext context) => new WizardStepResult();
}
```

### Web Service

Deploy a REST web service that ActiveDocs calls at each interception point. This approach does not require deploying code to the ActiveDocs server and supports implementations in any language.

**Steps:**

1. Create a REST service that accepts POST requests with the wizard context payload.
2. Deploy the service to a server accessible from the ActiveDocs server.
3. In AdminCenter, navigate to **Configuration > Event Handlers** and configure the endpoint URL.
4. No IIS restart is required for web service handlers.

## REST API Test Endpoints

The V2 API provides test endpoints for developing and debugging event handlers. These endpoints simulate the wizard engine's calls to your handler.

### Transform Answers

```http
POST /activedocs/api/v2/solutions-studio/transform-answers HTTP/1.1
Host: your-server
apikey: your-api-key-here
Content-Type: application/json
```

#### Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `eventType` | string | The event type: `Next`, `Back`, or `Finish`. |
| `userName` | string | The login name of the user. |
| `subsiteName` | string | The name of the subsite context. |
| `templateName` | string | The name of the template set. |
| `langSetting` | string | The language setting (e.g., `en`). |
| `stepNumber` | integer | The current wizard step number (zero-based). |
| `stepGroupName` | string | The name of the current step group. |

#### Request Body

The request body contains the current answer data in `ActiveDocsAnswers` format.

```json
{
  "eventType": "Next",
  "userName": "jsmith",
  "subsiteName": "Default",
  "templateName": "SimpleContract",
  "langSetting": "en",
  "stepNumber": 2,
  "stepGroupName": "ClientDetails",
  "activeDocsAnswers": {
    "version": "3.0",
    "body": {
      "answers": [
        { "name": "ClientName", "value": "Acme Corporation", "type": "Text" },
        { "name": "EmailAddress", "value": "contact@acme.com", "type": "Text" }
      ]
    }
  }
}
```

### Validate Answers

```http
POST /activedocs/api/v2/solutions-studio/validate-answers HTTP/1.1
Host: your-server
apikey: your-api-key-here
Content-Type: application/json
```

The request body is identical in structure to `transform-answers`. The response includes validation results:

```json
{
  "isValid": false,
  "errors": [
    {
      "fieldName": "EmailAddress",
      "message": "Please enter a valid email address."
    }
  ]
}
```

### Transform Job

```http
POST /activedocs/api/v2/solutions-studio/transform-job HTTP/1.1
Host: your-server
apikey: your-api-key-here
Content-Type: application/json
```

The request body contains the full `JobDef` that will be submitted to the assembly engine. The handler can modify the job definition and return the updated version.

### Verify Template Set

```http
POST /activedocs/api/v2/solutions-studio/verify-templateset HTTP/1.1
Host: your-server
apikey: your-api-key-here
Content-Type: application/json
```

#### eWizardStepTemplateSetEvents

The `eventType` parameter for template set verification uses the following values:

| Event | Description |
| --- | --- |
| `AfterSelection` | Fired after the user selects a template set in the wizard. |
| `AfterSelectionFinish` | Fired after template set selection when the user clicks Finish. |
| `AfterSelectionRecreate` | Fired after template set selection during a document recreate operation. |
| `AfterSelectionRecreateFinish` | Fired after template set selection during recreate when the user clicks Finish. |
| `ProcessingTemplateRulesADP` | Fired during Automated Document Production when template rules are being processed. |

### Job Status Callback

```http
POST /activedocs/api/v2/solutions-studio/jobstatus-callback HTTP/1.1
Host: your-server
apikey: your-api-key-here
Content-Type: application/json
```

This endpoint receives status updates from external systems during job processing. Use it to notify ActiveDocs when an asynchronous operation has completed.

## TransformTemplateSet Handler

The `TransformTemplateSet` handler allows you to control which templates are included in or excluded from a template set based on runtime conditions. The `userMode` parameter indicates how the wizard was invoked.

### userMode Values

| Value | Description |
| --- | --- |
| 1 | Standard wizard invocation from WorkCenter. |
| 2 | Wizard invoked for document recreation. |
| 3 | Wizard invoked from Automated Document Production (ADP). |
| 4 | Wizard invoked via API. |
| 5 | Wizard invoked for batch processing. |

### C# Example

```csharp
public WizardStepResult TransformTemplateSet(WizardStepContext context)
{
    var result = new WizardStepResult();
    int userMode = context.UserMode;
    string region = context.GetAnswerValue("Region");

    // Remove templates based on region
    if (region == "EU")
    {
        // Remove US-specific templates
        context.RemoveTemplate("US_DISCLAIMER_TEMPLATE_GUID");
        context.RemoveTemplate("US_TAX_FORM_TEMPLATE_GUID");
    }
    else if (region == "US")
    {
        // Remove EU-specific templates
        context.RemoveTemplate("EU_GDPR_NOTICE_TEMPLATE_GUID");
    }

    // Add templates based on invocation mode
    if (userMode == 3) // ADP mode
    {
        context.AddTemplate("AUDIT_TRAIL_TEMPLATE_GUID");
    }

    return result;
}
```

## Step-Specific Event Handling

By default, event handlers are invoked on every wizard step. You can limit handler execution to specific steps using configuration XML in AdminCenter.

```xml
<WizardStepEventHandler>
  <Assembly>MyCompany.ActiveDocs.Handlers</Assembly>
  <Class>MyCompany.ActiveDocs.Handlers.ContractHandler</Class>
  <Steps>
    <Step number="0" groupName="ClientDetails">
      <Events>
        <ValidateAnswersNext>true</ValidateAnswersNext>
        <TransformAnswersNext>true</TransformAnswersNext>
      </Events>
    </Step>
    <Step number="2" groupName="PaymentTerms">
      <Events>
        <ValidateAnswersNext>true</ValidateAnswersNext>
      </Events>
    </Step>
    <Step number="-1" groupName="*">
      <!-- Step -1 with groupName "*" matches the Finish action -->
      <Events>
        <TransformAnswersFinish>true</TransformAnswersFinish>
        <TransformJobXML>true</TransformJobXML>
      </Events>
    </Step>
  </Steps>
</WizardStepEventHandler>
```

### Configuration Reference

| Element | Description |
| --- | --- |
| `Assembly` | The .NET assembly name containing the handler class. |
| `Class` | The fully qualified class name of the handler. |
| `Steps > Step` | Defines which events are active for a specific step. |
| `Step.number` | The zero-based step index. Use `-1` for the Finish action. |
| `Step.groupName` | The step group name. Use `*` as a wildcard. |
| `Events` | Boolean flags indicating which event methods are active for this step. |

## Question Structure Schema (QST)

The Question Structure (QST) defines the layout and configuration of wizard questions. Understanding the QST is essential for event handlers that modify question visibility, ordering, or behavior.

### Overview

The QST is an XML document that describes the wizard's question groups, individual questions, their data types, and display settings. It is generated from the template set's field definitions and can be retrieved via the API.

### Retrieving the QST

```http
GET /activedocs/api/v2/design-components/{id}/questionstructure HTTP/1.1
Host: your-server
apikey: your-api-key-here
```

The response contains the QST XML for the specified template set.

### QuestionGroup Types

| Type ID | Name | Description |
| --- | --- | --- |
| 1 | Standard | A regular question group displayed as a wizard step. |
| 4 | Start | The start page group, displayed before the first step. |
| 5 | End | The end page group, displayed after the last step. |
| 10 | AllActiveFields | A special group containing all active fields regardless of step assignment. |

### Question Attributes

| Attribute | Description |
| --- | --- |
| `ID` | The unique identifier for the question within the QST. |
| `Name` | The field name that corresponds to an answer name. |
| `QType` | The question type controlling the UI widget (e.g., text input, dropdown, date picker). |
| `DType` | The data type of the answer: `Text`, `Numeric`, `Currency`, `Percentage`, `Date`, `Time`, `YesNo`. |
| `SF` | The string format or display format for the field value. |

### Example QST Fragment

```xml
<QuestionStructure>
  <QuestionGroups>
    <QuestionGroup Type="4" Name="Start" Title="Welcome">
      <!-- Start page content -->
    </QuestionGroup>
    <QuestionGroup Type="1" Name="ClientDetails" Title="Client Information">
      <Questions>
        <Question ID="q1" Name="ClientName" QType="TextBox" DType="Text" SF="">
          <Label>Client Name</Label>
          <Required>true</Required>
        </Question>
        <Question ID="q2" Name="ClientEmail" QType="TextBox" DType="Text" SF="email">
          <Label>Email Address</Label>
          <Required>true</Required>
        </Question>
        <Question ID="q3" Name="ContractDate" QType="DatePicker" DType="Date" SF="yyyy-MM-dd">
          <Label>Contract Date</Label>
          <Required>true</Required>
          <DefaultValue>today</DefaultValue>
        </Question>
      </Questions>
    </QuestionGroup>
    <QuestionGroup Type="1" Name="ContractTerms" Title="Contract Terms">
      <Questions>
        <Question ID="q4" Name="ContractValue" QType="TextBox" DType="Currency" SF="#,##0.00">
          <Label>Contract Value</Label>
          <Required>true</Required>
        </Question>
        <Question ID="q5" Name="PaymentTerms" QType="DropDown" DType="Text" SF="">
          <Label>Payment Terms</Label>
          <Options>
            <Option value="Net 15">Net 15</Option>
            <Option value="Net 30">Net 30</Option>
            <Option value="Net 60">Net 60</Option>
          </Options>
        </Question>
      </Questions>
    </QuestionGroup>
    <QuestionGroup Type="5" Name="End" Title="Summary">
      <!-- End page content -->
    </QuestionGroup>
  </QuestionGroups>
</QuestionStructure>
```

### Using QST with Event Handlers

In the `TransformQuestionsNext` method, you can modify the QST to dynamically show, hide, or reorder questions based on current answer values or external data.

```csharp
public WizardStepResult TransformQuestionsNext(WizardStepContext context)
{
    var result = new WizardStepResult();
    var qst = context.QuestionStructure;

    string clientType = context.GetAnswerValue("ClientType");

    if (clientType == "Individual")
    {
        // Hide business-specific questions for individual clients
        var abnQuestion = qst.FindQuestion("ABN");
        if (abnQuestion != null)
        {
            abnQuestion.Visible = false;
        }

        var companyNameQuestion = qst.FindQuestion("CompanyName");
        if (companyNameQuestion != null)
        {
            companyNameQuestion.Visible = false;
        }

        // Make individual-specific questions required
        var dateOfBirthQuestion = qst.FindQuestion("DateOfBirth");
        if (dateOfBirthQuestion != null)
        {
            dateOfBirthQuestion.Required = true;
        }
    }
    else if (clientType == "Business")
    {
        // Make business-specific questions required
        var abnQuestion = qst.FindQuestion("ABN");
        if (abnQuestion != null)
        {
            abnQuestion.Required = true;
        }

        // Hide individual-specific questions
        var dateOfBirthQuestion = qst.FindQuestion("DateOfBirth");
        if (dateOfBirthQuestion != null)
        {
            dateOfBirthQuestion.Visible = false;
        }
    }

    return result;
}
```

## Solutions Studio Test Bed Endpoints

The Solutions Studio provides test bed endpoints for developing and testing event handlers and document production workflows. These endpoints are intended for development use only.

### Finish Test

Simulates the wizard Finish action and triggers document assembly.

```http
GET /activedocs/api/v2/solutions-studio/finish HTTP/1.1
Host: your-server
apikey: your-api-key-here
```

### Documents Test Endpoints

Retrieve, update, or create test documents through the Solutions Studio test bed.

**Get a test document:**

```http
GET /activedocs/api/v2/solutions-studio/Documents HTTP/1.1
Host: your-server
apikey: your-api-key-here
```

**Update a test document:**

```http
PUT /activedocs/api/v2/solutions-studio/Documents HTTP/1.1
Host: your-server
apikey: your-api-key-here
Content-Type: application/json
```

**Create a test document:**

```http
POST /activedocs/api/v2/solutions-studio/Documents HTTP/1.1
Host: your-server
apikey: your-api-key-here
Content-Type: application/json
```

These endpoints accept and return the same document models used by the production Documents API, allowing you to test your integration code against the Solutions Studio environment before deploying to production.
