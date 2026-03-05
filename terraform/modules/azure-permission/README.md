# Azure Permission Terraform Module

This Terraform module assigns the necessary permissions to an Azure Service Principal (e.g., Pantheon) to operate at the subscription, management group, and resource group level. It supports role assignments on subscriptions, management groups, and resource groups.

## Features
- Assign any Azure role at the subscription, management group, or resource group level

## Requirements
- Terraform >= 1.0
- Providers: `azurerm` >= 3.0.0
- Sufficient permissions to assign roles

## Input Variables

| Name                        | Description                                                        | Type         | Default              |
|-----------------------------|--------------------------------------------------------------------|--------------|----------------------|
| pantheon_service_principal  | Client ID of the service principal                                 | string       | -                    |
| role                        | Azure role to assign                                               | string       | "Security Reader"    |
| subscriptions               | List of subscription IDs                                           | list(string) | []                   |
| resource_groups             | List of resource group names                                       | list(string) | []                   |
| management_groups           | List of management group IDs                                       | list(string) | []                   |

## Example

```hcl
module "azure_permission" {
  source                     = "./modules/azure-permission"
  pantheon_service_principal = "<CLIENT_ID>"
  role                       = "<READER_ROLE>"
  subscriptions              = ["<SUBSCRIPTION_ID>"]
  resource_groups            = ["<RESOURCE_GROUP_NAME>"]
  management_groups          = ["<MANAGEMENT_GROUP_ID>"]
}
```

## Using a Specific Provider (Multiple Subscriptions)

To assign permissions in different Azure subscriptions, define multiple provider blocks with aliases and pass the desired provider to each module instance:

```hcl
provider "azurerm" {
  alias           = "sub1"
  features        = {}
  subscription_id = "<SUBSCRIPTION_ID_1>"
}

provider "azurerm" {
  alias           = "sub2"
  features        = {}
  subscription_id = "<SUBSCRIPTION_ID_2>"
}

module "azure_permission_sub1" {
  source                     = "../modules/azure-permission"
  providers                  = { azurerm = azurerm.sub1 }
  role                       = "<READER_ROLE>"
  resource_groups            = ["ResourceGroup1"]
  pantheon_service_principal = "<SERVICE_PRINCIPAL_ID>"
}

module "azure_permission_sub2" {
  source                     = "../modules/azure-permission"
  providers                  = { azurerm = azurerm.sub2 }
  role                       = "<READER_ROLE>"
  resource_groups            = ["ResourceGroup2"]
  pantheon_service_principal = "<SERVICE_PRINCIPAL_ID>"
}
```

## What is provisioned?
- Role assignment at the subscription level
- Role assignment at the management group level
- Role assignment at the resource group level

## Notes
- All role assignments are optional; if you leave a variable empty, no assignment is created for that scope.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.pantheon_engine_security_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.pantheon_engine_security_admin_management_groups](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.pantheon_engine_security_admin_resource_groups](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azuread_service_principal.pantheon-service-principal](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azurerm_management_group.management_groups](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_resource_group.resource_groups](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_role_definition.management_groups](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_role_definition.resource_groups](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_role_definition.subscription_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_subscription.subscriptions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_management_groups"></a> [management\_groups](#input\_management\_groups) | A list of specific resource IDs to which the IAM binding should be applied | `list(string)` | `[]` | no |
| <a name="input_pantheon_service_principal"></a> [pantheon\_service\_principal](#input\_pantheon\_service\_principal) | The email address of the Google service account | `string` | n/a | yes |
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | A list of resource group names to which the IAM binding should be applied | `list(string)` | `[]` | no |
| <a name="input_role"></a> [role](#input\_role) | The role to be assigned to the service account | `string` | `"Security Reader"` | no |
| <a name="input_subscriptions"></a> [subscriptions](#input\_subscriptions) | A list of subscription IDs to which the IAM binding should be applied | `list(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->