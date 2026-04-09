## Overview

The **ActiveDocsAdministration** PowerShell module provides cmdlets for configuring and managing ActiveDocs Server installations. Use these cmdlets to automate server provisioning, configure server roles, manage WorkCenter applications, and adjust system settings without using the AdminCenter UI.

## Setup

Import the module by running the setup script from an elevated PowerShell session:

```powershell
. "C:\Program Files\ActiveDocs\PowerShell\Modules\ActiveDocsAdministration\ActiveDocs.ps1"
```

This dot-sources the module and makes all cmdlets available in the current session. You can add this line to your PowerShell profile for automatic loading.

## Available Cmdlets

| Cmdlet | Synopsis |
|---|---|
| `Add-WCApplication` | Creates a new WorkCenter web application in IIS. |
| `Get-ADEnvironment` | Returns all configured ActiveDocs environments. |
| `Get-ADServerRole` | Returns the current server role configuration. |
| `Get-ADSettings` | Returns the current ActiveDocs system settings. |
| `Get-WCApplication` | Returns WorkCenter web application details. |
| `Remove-WCApplication` | Removes a WorkCenter web application from IIS. |
| `Set-ADServerRole` | Configures the server role settings. |
| `Set-ADSettings` | Configures system-level ActiveDocs settings. |
| `Set-WCApplication` | Updates an existing WorkCenter web application. |

---

## Add-WCApplication

### Synopsis

Creates a new WorkCenter web application in IIS under a specified website.

### Syntax

```powershell
Add-WCApplication -Site <String> -Name <String> -ApplicationPool <String> -EnvironmentName <String>
```

### Description

Creates a new IIS web application configured for ActiveDocs WorkCenter. The application is created under the specified IIS website, using the given application pool, and linked to the specified ActiveDocs environment.

### Parameters

| Parameter | Type | Required | Position | Default | Description |
|---|---|---|---|---|---|
| `-Site` | `String` | Yes | 0 | — | The IIS website name under which to create the application (e.g., `Default Web Site`). |
| `-Name` | `String` | Yes | 1 | — | The application name, which becomes the URL path segment (e.g., `ActiveDocs`). |
| `-ApplicationPool` | `String` | Yes | 2 | — | The IIS application pool to assign to the application. The pool must already exist. |
| `-EnvironmentName` | `String` | Yes | 3 | — | The ActiveDocs environment to associate with this application. |

### Examples

```powershell
# Create a WorkCenter application under the default website
Add-WCApplication -Site "Default Web Site" -Name "ActiveDocs" `
    -ApplicationPool "ActiveDocsAppPool" -EnvironmentName "Production"
```

```powershell
# Create a staging instance
Add-WCApplication -Site "Default Web Site" -Name "ActiveDocs-Staging" `
    -ApplicationPool "ActiveDocsStaging" -EnvironmentName "Staging"
```

### Related Links

- `Get-WCApplication`
- `Set-WCApplication`
- `Remove-WCApplication`

---

## Get-ADEnvironment

### Synopsis

Returns all configured ActiveDocs environments.

### Syntax

```powershell
Get-ADEnvironment
```

### Description

Retrieves a list of all ActiveDocs environments configured on the server. Each environment represents a distinct ActiveDocs installation with its own database, settings, and WorkCenter applications. Returns `ActiveDocsEnvironment` objects with properties including environment name, database connection, and associated applications.

### Parameters

This cmdlet takes no parameters.

### Examples

```powershell
# List all environments
Get-ADEnvironment
```

```powershell
# Display environment details in a table
Get-ADEnvironment | Format-Table Name, DatabaseServer, DatabaseName, Status -AutoSize
```

### Related Links

- `Get-ADSettings`

---

## Get-ADServerRole

### Synopsis

Returns the current server role configuration.

### Syntax

```powershell
Get-ADServerRole
```

### Description

Retrieves the server role configuration, including retention policy settings, multi-core processing mode, document assembly settings, conversion settings, and performance monitoring. Returns a `ServerRole` object.

### Parameters

This cmdlet takes no parameters.

### Examples

```powershell
# Display the current server role
Get-ADServerRole
```

```powershell
# Check if document assembly is enabled
$role = Get-ADServerRole
if ($role.DocumentAssemblyEnabled) {
    Write-Host "Assembly is enabled with timeout: $($role.DocumentAssemblyTimeOut) seconds"
} else {
    Write-Host "Assembly is disabled on this server"
}
```

### Related Links

- `Set-ADServerRole`

---

## Get-ADSettings

### Synopsis

Returns the current ActiveDocs system settings.

### Syntax

```powershell
Get-ADSettings
```

### Description

Retrieves the current system-level ActiveDocs settings, including the AdminCenter URL, database connection settings, and application pool credentials. Returns a settings object with all configured values.

### Parameters

This cmdlet takes no parameters.

### Examples

```powershell
# Display current settings
Get-ADSettings
```

```powershell
# Check the AdminCenter URL
$settings = Get-ADSettings
Write-Host "AdminCenter URL: $($settings.AdminCenterURL)"
Write-Host "DB Server: $($settings.AdminCenterDBServer)"
```

### Related Links

- `Set-ADSettings`

---

## Get-WCApplication

### Synopsis

Returns details of WorkCenter web applications.

### Syntax

```powershell
Get-WCApplication [-Site <String>] [-Name <String>]
```

### Description

Retrieves information about WorkCenter web applications configured in IIS. When called without parameters, returns all WorkCenter applications across all sites. Use the optional parameters to filter by site or application name.

**Alias:** `getwcapp`

### Parameters

| Parameter | Type | Required | Position | Default | Description |
|---|---|---|---|---|---|
| `-Site` | `String` | No | 0 | — | Filter by IIS website name. |
| `-Name` | `String` | No | 1 | — | Filter by application name. |

### Examples

```powershell
# List all WorkCenter applications
Get-WCApplication
```

```powershell
# Get a specific application using the alias
getwcapp -Site "Default Web Site" -Name "ActiveDocs"
```

```powershell
# List all applications on a specific site
Get-WCApplication -Site "Default Web Site" | Format-Table Name, ApplicationPool, EnvironmentName
```

### Related Links

- `Add-WCApplication`
- `Set-WCApplication`
- `Remove-WCApplication`

---

## Remove-WCApplication

### Synopsis

Removes a WorkCenter web application from IIS.

### Syntax

```powershell
Remove-WCApplication -Site <String> -Name <String>
```

### Description

Removes the specified WorkCenter web application from IIS. This removes the IIS application entry but does not delete the physical files from disk. The associated application pool is not removed.

### Parameters

| Parameter | Type | Required | Position | Default | Description |
|---|---|---|---|---|---|
| `-Site` | `String` | Yes | 0 | — | The IIS website containing the application. |
| `-Name` | `String` | Yes | 1 | — | The name of the application to remove. |

### Examples

```powershell
# Remove a WorkCenter application
Remove-WCApplication -Site "Default Web Site" -Name "ActiveDocs-Staging"
```

### Related Links

- `Add-WCApplication`
- `Get-WCApplication`

---

## Set-ADServerRole

### Synopsis

Configures the server role settings for document assembly, conversion, and system maintenance.

### Syntax

```powershell
Set-ADServerRole
    -RetentionPolicyEnabled <Boolean>
    -RetentionPolicyStart <String>
    -RetentionPolicyEnd <String>
    -MulticoreMode <Boolean>
    -DocumentAssemblyEnabled <Boolean>
    -DocumentAssemblyTimeOut <Int32>
    -ConversionEnabled <Boolean>
    -ConversionTimeOut <Int32>
    -WordConversionServicesEnabled <Boolean>
    -DocumentPerfMonEnabled <Boolean>
```

### Description

Sets all server role configuration values. All parameters are required. The retention policy controls automatic cleanup of old documents and logs. Multi-core mode enables parallel document processing. Assembly and conversion timeouts are specified in seconds.

### Parameters

| Parameter | Type | Required | Position | Default | Description |
|---|---|---|---|---|---|
| `-RetentionPolicyEnabled` | `Boolean` | Yes | 0 | — | Enable or disable the automatic retention policy. |
| `-RetentionPolicyStart` | `String` | Yes | 1 | — | Time of day to start retention processing (24-hour format, e.g., `"02:00"`). |
| `-RetentionPolicyEnd` | `String` | Yes | 2 | — | Time of day to stop retention processing (e.g., `"05:00"`). |
| `-MulticoreMode` | `Boolean` | Yes | 3 | — | Enable multi-core document assembly for parallel processing. |
| `-DocumentAssemblyEnabled` | `Boolean` | Yes | 4 | — | Enable document assembly on this server. |
| `-DocumentAssemblyTimeOut` | `Int32` | Yes | 5 | — | Maximum time in seconds for a single document assembly operation. |
| `-ConversionEnabled` | `Boolean` | Yes | 6 | — | Enable document format conversion (e.g., DOCX to PDF). |
| `-ConversionTimeOut` | `Int32` | Yes | 7 | — | Maximum time in seconds for a single conversion operation. |
| `-WordConversionServicesEnabled` | `Boolean` | Yes | 8 | — | Enable Word Conversion Services for server-side Word-based conversions. |
| `-DocumentPerfMonEnabled` | `Boolean` | Yes | 9 | — | Enable performance monitoring counters for document operations. |

### Examples

```powershell
# Configure a production server with all features enabled
Set-ADServerRole `
    -RetentionPolicyEnabled $true `
    -RetentionPolicyStart "02:00" `
    -RetentionPolicyEnd "05:00" `
    -MulticoreMode $true `
    -DocumentAssemblyEnabled $true `
    -DocumentAssemblyTimeOut 120 `
    -ConversionEnabled $true `
    -ConversionTimeOut 300 `
    -WordConversionServicesEnabled $true `
    -DocumentPerfMonEnabled $true
```

```powershell
# Configure a conversion-only server (no assembly)
Set-ADServerRole `
    -RetentionPolicyEnabled $false `
    -RetentionPolicyStart "00:00" `
    -RetentionPolicyEnd "00:00" `
    -MulticoreMode $false `
    -DocumentAssemblyEnabled $false `
    -DocumentAssemblyTimeOut 60 `
    -ConversionEnabled $true `
    -ConversionTimeOut 600 `
    -WordConversionServicesEnabled $true `
    -DocumentPerfMonEnabled $false
```

```powershell
# Configure a minimal server for development
Set-ADServerRole `
    -RetentionPolicyEnabled $false `
    -RetentionPolicyStart "00:00" `
    -RetentionPolicyEnd "00:00" `
    -MulticoreMode $false `
    -DocumentAssemblyEnabled $true `
    -DocumentAssemblyTimeOut 60 `
    -ConversionEnabled $true `
    -ConversionTimeOut 120 `
    -WordConversionServicesEnabled $false `
    -DocumentPerfMonEnabled $false
```

### Related Links

- `Get-ADServerRole`

---

## Set-ADSettings

### Synopsis

Configures system-level ActiveDocs settings, including AdminCenter connectivity, database connection, and application pool credentials.

### Syntax

```powershell
Set-ADSettings
    -AdminCenterURL <String>
    -AdminCenterUseWindowsCredentials <Boolean>
    [-AdminCenterUserName <String>]
    [-AdminCenterPassword <String>]
    -AdminCenterDBServer <String>
    [-AdminCenterDBServerOptions <String>]
    [-AdminCenterDBUseWindowsCredentials <Boolean>]
    [-AdminCenterDBUserName <String>]
    [-AdminCenterDBPassword <String>]
    [-AdminCenterDBTrustCertificate <Boolean>]
    -ApplicationPoolCredentialType <Int32>
    [-ApplicationPoolUserName <String>]
    [-ApplicationPoolPassword <String>]
    [-AddUserAsAdminCenterAdmin <Boolean>]
```

### Description

Sets the core ActiveDocs system configuration. This includes the AdminCenter URL, how ActiveDocs authenticates with AdminCenter, the database server connection, and the identity under which the IIS application pool runs.

### Parameters

| Parameter | Type | Required | Position | Default | Description |
|---|---|---|---|---|---|
| `-AdminCenterURL` | `String` | Yes | 0 | — | The full URL of the AdminCenter instance (e.g., `https://server/AdminCenter`). |
| `-AdminCenterUseWindowsCredentials` | `Boolean` | Yes | 1 | — | Use Windows authentication to connect to AdminCenter. If `$false`, supply `AdminCenterUserName` and `AdminCenterPassword`. |
| `-AdminCenterUserName` | `String` | No | 2 | — | The username for AdminCenter authentication (required when `AdminCenterUseWindowsCredentials` is `$false`). |
| `-AdminCenterPassword` | `String` | No | 3 | — | The password for AdminCenter authentication (required when `AdminCenterUseWindowsCredentials` is `$false`). |
| `-AdminCenterDBServer` | `String` | Yes | 4 | — | The SQL Server instance hosting the AdminCenter database (e.g., `SQLSERVER\INSTANCE`). |
| `-AdminCenterDBServerOptions` | `String` | No | 5 | — | Additional SQL Server connection string options. |
| `-AdminCenterDBUseWindowsCredentials` | `Boolean` | No | 6 | — | Use Windows authentication for the database connection. If `$false`, supply `AdminCenterDBUserName` and `AdminCenterDBPassword`. |
| `-AdminCenterDBUserName` | `String` | No | 7 | — | SQL Server login username (required when `AdminCenterDBUseWindowsCredentials` is `$false`). |
| `-AdminCenterDBPassword` | `String` | No | 8 | — | SQL Server login password (required when `AdminCenterDBUseWindowsCredentials` is `$false`). |
| `-AdminCenterDBTrustCertificate` | `Boolean` | No | 9 | — | Trust the SQL Server certificate without validation. Set to `$true` for self-signed certificates. |
| `-ApplicationPoolCredentialType` | `Int32` | Yes | 10 | — | The identity type for the IIS application pool. Values: `0` = NetworkService, `1` = LocalSystem, `2` = Custom account (supply username and password). |
| `-ApplicationPoolUserName` | `String` | No | 11 | — | The username for the application pool identity (required when `ApplicationPoolCredentialType` is `2`). |
| `-ApplicationPoolPassword` | `String` | No | 12 | — | The password for the application pool identity (required when `ApplicationPoolCredentialType` is `2`). |
| `-AddUserAsAdminCenterAdmin` | `Boolean` | No | 13 | — | Add the current user as an AdminCenter administrator during setup. |

### Examples

**Windows Authentication (recommended for domain-joined servers):**

```powershell
# Configure with Windows Authentication for both AdminCenter and database
Set-ADSettings `
    -AdminCenterURL "https://adserver.example.com/AdminCenter" `
    -AdminCenterUseWindowsCredentials $true `
    -AdminCenterDBServer "SQLSERVER01\ACTIVEDOCS" `
    -AdminCenterDBUseWindowsCredentials $true `
    -AdminCenterDBTrustCertificate $false `
    -ApplicationPoolCredentialType 2 `
    -ApplicationPoolUserName "DOMAIN\svc-activedocs" `
    -ApplicationPoolPassword "ServiceAccountPassword" `
    -AddUserAsAdminCenterAdmin $true
```

**SQL Server Authentication:**

```powershell
# Configure with SQL Server Authentication
Set-ADSettings `
    -AdminCenterURL "https://adserver.example.com/AdminCenter" `
    -AdminCenterUseWindowsCredentials $false `
    -AdminCenterUserName "activedocs_admin" `
    -AdminCenterPassword "AdminPassword123" `
    -AdminCenterDBServer "SQLSERVER01\ACTIVEDOCS" `
    -AdminCenterDBUseWindowsCredentials $false `
    -AdminCenterDBUserName "activedocs_db" `
    -AdminCenterDBPassword "DBPassword456" `
    -AdminCenterDBTrustCertificate $true `
    -ApplicationPoolCredentialType 0
```

**NetworkService identity with Windows database authentication:**

```powershell
# Use NetworkService for the application pool
Set-ADSettings `
    -AdminCenterURL "https://localhost/AdminCenter" `
    -AdminCenterUseWindowsCredentials $true `
    -AdminCenterDBServer ".\SQLEXPRESS" `
    -AdminCenterDBUseWindowsCredentials $true `
    -ApplicationPoolCredentialType 0
```

### Related Links

- `Get-ADSettings`

---

## Set-WCApplication

### Synopsis

Updates an existing WorkCenter web application configuration.

### Syntax

```powershell
Set-WCApplication -Site <String> -Name <String> -ApplicationPool <String> -EnvironmentName <String> [-UpdateAppFiles]
```

### Description

Updates the configuration of an existing WorkCenter web application in IIS. You can change the application pool, environment association, and optionally update the application files to the latest version.

### Parameters

| Parameter | Type | Required | Position | Default | Description |
|---|---|---|---|---|---|
| `-Site` | `String` | Yes | 0 | — | The IIS website containing the application. |
| `-Name` | `String` | Yes | 1 | — | The name of the application to update. |
| `-ApplicationPool` | `String` | Yes | 2 | — | The IIS application pool to assign. |
| `-EnvironmentName` | `String` | Yes | 3 | — | The ActiveDocs environment to associate with the application. |
| `-UpdateAppFiles` | `Switch` | No | Named | `$false` | When specified, copies the latest application files to the application directory. Use after upgrading ActiveDocs Server. |

### Examples

```powershell
# Update the application pool assignment
Set-WCApplication -Site "Default Web Site" -Name "ActiveDocs" `
    -ApplicationPool "ActiveDocsAppPoolV2" -EnvironmentName "Production"
```

```powershell
# Update application and refresh files after an upgrade
Set-WCApplication -Site "Default Web Site" -Name "ActiveDocs" `
    -ApplicationPool "ActiveDocsAppPool" -EnvironmentName "Production" `
    -UpdateAppFiles
```

### Related Links

- `Add-WCApplication`
- `Get-WCApplication`
- `Remove-WCApplication`

---

## Troubleshooting

### Connection Issues

**Symptom:** Cmdlets fail with connection errors when communicating with AdminCenter.

**Resolution:**

1. Verify the AdminCenter URL is accessible from the server:

```powershell
# Test connectivity to AdminCenter
Test-NetConnection -ComputerName "adserver.example.com" -Port 443

# Verify the URL responds
Invoke-WebRequest -Uri "https://adserver.example.com/AdminCenter" -UseBasicParsing
```

2. Confirm the credentials are correct:

```powershell
# Check current settings
$settings = Get-ADSettings
Write-Host "URL: $($settings.AdminCenterURL)"
Write-Host "Windows Auth: $($settings.AdminCenterUseWindowsCredentials)"
```

3. If using Windows Authentication, ensure the application pool identity has permission to access AdminCenter.

4. If using SQL Authentication, verify the database credentials and that the SQL Server instance accepts remote connections.

### Timeout Issues During Assembly

**Symptom:** Document assembly jobs fail with timeout errors, or large/complex documents do not complete.

**Resolution:**

1. Check the current assembly timeout:

```powershell
$role = Get-ADServerRole
Write-Host "Assembly Timeout: $($role.DocumentAssemblyTimeOut) seconds"
Write-Host "Conversion Timeout: $($role.ConversionTimeOut) seconds"
```

2. Increase the timeout values. For complex documents, values of 300-600 seconds may be necessary:

```powershell
Set-ADServerRole `
    -RetentionPolicyEnabled $true `
    -RetentionPolicyStart "02:00" `
    -RetentionPolicyEnd "05:00" `
    -MulticoreMode $true `
    -DocumentAssemblyEnabled $true `
    -DocumentAssemblyTimeOut 600 `
    -ConversionEnabled $true `
    -ConversionTimeOut 600 `
    -WordConversionServicesEnabled $true `
    -DocumentPerfMonEnabled $true
```

3. Enable performance monitoring to identify bottlenecks:

```powershell
# Enable performance counters
$role = Get-ADServerRole
# Reconfigure with DocumentPerfMonEnabled set to $true
```

4. Consider enabling multi-core mode if processing large volumes of documents:

```powershell
# Check if multi-core is enabled
$role = Get-ADServerRole
Write-Host "Multi-core mode: $($role.MulticoreMode)"
```

5. Review the job error log for specific error details:

```powershell
# Query recent job errors (requires database access)
Invoke-Sqlcmd -ServerInstance "SQLSERVER01\ACTIVEDOCS" -Database "ActiveDocs" `
    -Query "SELECT TOP 20 JobID, ErrorDate, ErrorMessage FROM rptJobErrors ORDER BY ErrorDate DESC"
```
