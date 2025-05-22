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