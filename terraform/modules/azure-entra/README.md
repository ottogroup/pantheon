# Azure Entra Permission Terraform Module

This Terraform module assigns a directory role (e.g., Directory Readers) to an Azure Service Principal in Microsoft Entra ID (Azure AD). It is typically used to grant permissions such as listing users and groups.

## Features
- Assign any Azure AD directory role (e.g., Directory Readers) to a service principal

## Requirements
- Terraform >= 1.0
- Provider: `azuread` >= 3.1.0
- Sufficient permissions to assign directory roles

## Input Variables

| Name                        | Description                                   | Type   | Default           |
|-----------------------------|-----------------------------------------------|--------|-------------------|
| pantheon_service_principal  | Client ID of the service principal            | string | -                 |
| role                        | Azure AD directory role to assign             | string | "Directory Readers" |

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
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_directory_role.directory_reader](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/directory_role) | resource |
| [azuread_directory_role_assignment.pantheon_engine_directory_reader](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/directory_role_assignment) | resource |
| [azuread_service_principal.pantheon-service-principal](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_pantheon_service_principal"></a> [pantheon\_service\_principal](#input\_pantheon\_service\_principal) | The email address of the Google service account | `string` | n/a | yes |
| <a name="input_role"></a> [role](#input\_role) | The role to be assigned to the service account | `string` | `"Directory Readers"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->