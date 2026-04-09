## Overview

ActiveDocs supports custom themes for branding the WorkCenter interface and localization for multi-language deployments. Themes control the visual appearance — colors, layout, images, and menus — while localization resources provide translated strings for every UI element.

## Custom Theme Structure

A custom theme resides in the `App_Themes` directory of your WorkCenter virtual directory. Each theme is a self-contained folder:

```
App_Themes/
  CustomTheme/
    main.css            # Primary stylesheet overrides
    header.htm          # Custom header HTML fragment
    home_main.htm       # Custom home page content
    menus.xml           # Menu structure and configuration
    images/             # Theme-specific images and logos
      logo.png
      favicon.ico
      background.png
```

## CSS Customization

Override default WorkCenter styles by creating a `main.css` file in your theme folder. ActiveDocs loads your custom stylesheet after the base styles, so your rules take precedence.

### CSS Custom Properties Approach

Use CSS custom properties to establish a consistent design language across the theme:

```css
/* main.css — Custom Theme */

:root {
  --ad-primary-color: #1a5276;
  --ad-primary-light: #2980b9;
  --ad-primary-dark: #0e2f44;
  --ad-accent-color: #e67e22;
  --ad-text-color: #2c3e50;
  --ad-text-light: #7f8c8d;
  --ad-background: #f5f7fa;
  --ad-surface: #ffffff;
  --ad-border-color: #dce1e6;
  --ad-border-radius: 4px;
  --ad-font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
}

/* Header */
.ade-header {
  background-color: var(--ad-primary-color);
  color: #ffffff;
  font-family: var(--ad-font-family);
  padding: 10px 20px;
  border-bottom: 3px solid var(--ad-accent-color);
}

.ade-header .logo img {
  max-height: 40px;
}

/* Navigation */
.ade-nav {
  background-color: var(--ad-primary-dark);
  font-family: var(--ad-font-family);
}

.ade-nav a {
  color: #ecf0f1;
  text-decoration: none;
  padding: 8px 16px;
  display: inline-block;
  transition: background-color 0.2s;
}

.ade-nav a:hover,
.ade-nav a.active {
  background-color: var(--ad-primary-light);
}

/* Section Titles */
.ade-section-title {
  font-size: 1.25rem;
  font-weight: 600;
  color: var(--ad-primary-color);
  border-bottom: 2px solid var(--ad-accent-color);
  padding-bottom: 6px;
  margin-bottom: 16px;
}

/* Wizard Progress Bar */
.ade-wizard-progress {
  background-color: var(--ad-border-color);
  border-radius: var(--ad-border-radius);
  overflow: hidden;
  height: 8px;
}

.ade-wizard-progress .bar {
  background-color: var(--ad-accent-color);
  height: 100%;
  transition: width 0.3s ease;
}

.ade-wizard-step.completed {
  color: var(--ad-primary-color);
  font-weight: 600;
}

.ade-wizard-step.active {
  color: var(--ad-accent-color);
  font-weight: 600;
}

/* Template Grid */
.ade-template-grid {
  display: grid;
  gap: 12px;
}

.ade-template-grid .template-card {
  background-color: var(--ad-surface);
  border: 1px solid var(--ad-border-color);
  border-radius: var(--ad-border-radius);
  padding: 12px 16px;
  transition: box-shadow 0.2s;
}

.ade-template-grid .template-card:hover {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

/* Error Messages */
.ade-error-message {
  background-color: #fdf2f2;
  border-left: 4px solid #e74c3c;
  color: #c0392b;
  padding: 10px 14px;
  border-radius: var(--ad-border-radius);
  font-size: 0.9rem;
}

/* Buttons */
.ade-btn {
  font-family: var(--ad-font-family);
  border-radius: var(--ad-border-radius);
  padding: 8px 20px;
  font-size: 0.9rem;
  cursor: pointer;
  border: none;
  transition: background-color 0.2s;
}

.ade-btn-primary {
  background-color: var(--ad-primary-color);
  color: #ffffff;
}

.ade-btn-primary:hover {
  background-color: var(--ad-primary-light);
}

.ade-btn-secondary {
  background-color: var(--ad-border-color);
  color: var(--ad-text-color);
}

/* Separators */
.ade-separator {
  border: none;
  border-top: 1px solid var(--ad-border-color);
  margin: 20px 0;
}

/* Responsive Adjustments */
@media (max-width: 768px) {
  .ade-header {
    padding: 8px 12px;
  }

  .ade-nav a {
    padding: 6px 10px;
    font-size: 0.85rem;
  }

  .ade-template-grid {
    grid-template-columns: 1fr;
  }
}
```

## Menu Customization

The `menus.xml` file defines the navigation menus displayed in WorkCenter. Each menu element supports the following attributes:

### Menu Element Attributes

| Attribute | Description |
|---|---|
| `ResourceID` | The resource key used to look up the menu item's display text from the language resource file. |
| `URL` | The target URL when the menu item is clicked. Can be a relative path or absolute URL. |
| `LogOnBehaviour` | Controls visibility based on authentication state (see values below). |
| `Target` | The browser window target (e.g., `_blank`, `_self`). |
| `SystemFunctionInclude` | Comma-separated list of system functions the user must have for this menu to appear. |
| `SystemFunctionExclude` | Comma-separated list of system functions that hide this menu item from the user. |

### LogOnBehaviour Values

| Value | Behavior |
|---|---|
| `1` | Always visible, regardless of authentication state. |
| `2` | Visible only when the user is logged in. |
| `3` | Visible only when the user is **not** logged in. |
| `4` | Visible only to administrators. |

### Adding Custom Menus

```xml
<?xml version="1.0" encoding="utf-8" ?>
<Menus>
  <Menu ResourceID="MenuHome" URL="~/Home" LogOnBehaviour="1" />
  <Menu ResourceID="MenuTemplates" URL="~/Templates" LogOnBehaviour="2" />
  <Menu ResourceID="MenuDocuments" URL="~/Documents" LogOnBehaviour="2" />
  <Menu ResourceID="MenuReports" URL="~/Reports"
        LogOnBehaviour="2"
        SystemFunctionInclude="ReportViewer" />
  <Menu ResourceID="MenuAdmin" URL="~/Admin"
        LogOnBehaviour="4"
        SystemFunctionInclude="SystemAdmin" />

  <!-- Custom external link -->
  <Menu ResourceID="MenuHelpPortal"
        URL="https://help.example.com"
        LogOnBehaviour="2"
        Target="_blank" />

  <!-- Custom menu visible only to non-admins -->
  <Menu ResourceID="MenuSupportRequest"
        URL="~/SupportRequest"
        LogOnBehaviour="2"
        SystemFunctionExclude="SystemAdmin" />
</Menus>
```

For each custom `ResourceID`, add a corresponding entry in your resource override file (see **Language Resources** below).

## Language Resources

ActiveDocs uses .NET resource files (`.resx`) for all user-facing text. This system supports full localization and selective string overrides.

### File Locations

Resource files are located in the `App_GlobalResources` directory of the WorkCenter virtual directory:

| File | Purpose |
|---|---|
| `adeResource.resx` | Default (English) resource strings. This is the fallback for any missing translations. |
| `adeResource.nl-NL.resx` | Dutch (Netherlands) language resources. |
| `adeResource.fr-FR.resx` | French (France) language resources. |
| `adeResource.de-DE.resx` | German (Germany) language resources. |

The naming convention is `adeResource.{culture-code}.resx`, where the culture code follows the standard .NET format (e.g., `en-US`, `pt-BR`, `zh-CN`).

### Resource Override Pattern

Rather than modifying the base resource files (which are overwritten during upgrades), use the override file:

**`adeResourceOverride.resx`** — Place this file in `App_GlobalResources`. It contains only the resource keys you want to change. ActiveDocs loads overrides after the base resources, so your values take precedence.

For language-specific overrides, use the culture-qualified name: `adeResourceOverride.nl-NL.resx`.

Example override file entries:

```xml
<?xml version="1.0" encoding="utf-8"?>
<root>
  <data name="MenuHelpPortal" xml:space="preserve">
    <value>Help Portal</value>
  </data>
  <data name="MenuSupportRequest" xml:space="preserve">
    <value>Submit Support Request</value>
  </data>
  <data name="LabelWelcome" xml:space="preserve">
    <value>Welcome to the Document Portal</value>
  </data>
  <data name="BtnCreateDocument" xml:space="preserve">
    <value>Create New Document</value>
  </data>
</root>
```

### Compiling Resources

After creating or modifying resource files, compile them using the provided batch file. Resource files must be compiled into satellite assemblies before they take effect.

```batch
@echo off
REM ResourceGen.bat — Compile ActiveDocs resource overrides
REM Run from the WorkCenter virtual directory root

SET RESGEN="C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.8 Tools\ResGen.exe"
SET AL="C:\Windows\Microsoft.NET\Framework64\v4.0.30319\al.exe"
SET RESOURCE_DIR=App_GlobalResources

echo Compiling resource overrides...

%RESGEN% %RESOURCE_DIR%\adeResourceOverride.resx %RESOURCE_DIR%\adeResourceOverride.resources
if errorlevel 1 goto :error

echo Resources compiled successfully.
goto :end

:error
echo ERROR: Resource compilation failed.
exit /b 1

:end
echo Done.
```

### Deploying Resources

1. Copy the compiled `.resources` files to the `App_GlobalResources` directory of the WorkCenter virtual directory.
2. Restart the application pool (or recycle it) to load the new resources.

### Creating New Language Support

To add a new language:

1. Copy `adeResource.resx` to `adeResource.{culture-code}.resx` (e.g., `adeResource.ja-JP.resx` for Japanese).
2. Translate all `<value>` elements in the new file.
3. Compile using `ResourceGen.bat`.
4. Deploy to the virtual directory and restart the application pool.
5. Configure the new language in AdminCenter under **General Settings > Supported Languages**.

## Theme Configuration in AdminCenter

### General Settings

Navigate to **AdminCenter > General Settings** to set the default theme for all subsites:

- **Default Theme** — Select the theme folder name from the dropdown (e.g., `CustomTheme`).
- **Default Language** — Set the default culture code for the installation.

### Subsite Settings

Individual subsites can override the default theme. Navigate to **AdminCenter > Subsites > [Subsite Name] > Settings**:

- **Theme** — Select a theme to override the system default for this subsite.
- **Language** — Set a subsite-specific language/culture.

Subsite-level settings take precedence over the general defaults.

## Custom Document Actions

Document Actions allow you to add custom buttons and behaviors to the WorkCenter document viewer. Actions are configured per template in Solutions Studio.

### Action Properties

| Property | Description |
|---|---|
| **When** | The trigger condition for the action. Values include `OnCreate`, `OnOpen`, `OnSave`, `OnDeliver`, `OnApprove`, `OnReject`. |
| **Permissions** | Comma-separated list of system functions required to see and execute this action. |
| **Replaces** | The name of a built-in action that this custom action replaces (e.g., `Save`, `Deliver`). |
| **OnClick Script** | JavaScript code executed when the user clicks the action button. |

### JavaScript Example

The following example adds a custom action that confirms delivery before proceeding:

```javascript
function MsgCustomAction(actionName, documentID) {
    // Display a confirmation dialog
    var confirmed = confirm(
        "You are about to deliver document " + documentID + ".\n\n" +
        "Action: " + actionName + "\n\n" +
        "Do you want to continue?"
    );

    if (confirmed) {
        // Call the ActiveDocs client API to execute the delivery
        adeClient.executeAction(actionName, documentID, {
            onSuccess: function (result) {
                alert("Document delivered successfully.\nReference: " + result.referenceID);
                // Refresh the document list
                adeClient.refreshDocumentList();
            },
            onError: function (error) {
                alert("Delivery failed: " + error.message);
            }
        });
    }

    // Return false to prevent the default action behavior
    return false;
}
```

Configure this in Solutions Studio by setting the **OnClick Script** property to:

```javascript
return MsgCustomAction('DeliverToClient', '{DocumentID}');
```

The `{DocumentID}` token is replaced with the actual document identifier at runtime.
