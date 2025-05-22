# Azure Entra Permission Terraform Module

This Terraform module assigns a directory role (e.g., Directory Reader) to an Azure Service Principal in Microsoft Entra ID (Azure AD). It is typically used to grant permissions such as listing users and groups.

## Features
- Assign any Azure AD directory role (e.g., Directory Reader) to a service principal

## Requirements
- Terraform >= 1.0
- Provider: `azuread` >= 3.1.0
- Sufficient permissions to assign directory roles

## Input Variables

| Name                        | Description                                   | Type   | Default           |
|-----------------------------|-----------------------------------------------|--------|-------------------|
| pantheon_service_principal  | Client ID of the service principal            | string | -                 |
| role                        | Azure AD directory role to assign             | string | "Security Reader" |

## Example

```hcl
module "azure_entra_permission" {
  source                     = "./modules/azure-entra"
  pantheon_service_principal = "<CLIENT_ID>"
  role                       = "Directory Readers"
}
```

## What is provisioned?
- Assigns the specified Azure AD directory role to the given service principal.

## Notes
- The service principal will be able to perform actions allowed by the assigned directory role (e.g., list users and groups if "Directory Readers" is assigned).