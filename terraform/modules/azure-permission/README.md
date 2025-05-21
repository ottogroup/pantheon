# Azure Permission Terraform Module

This Terraform module assigns the necessary permissions to an Azure Service Principal (e.g., Pantheon) to operate at the subscription, management group, and Azure AD level. It supports role assignments on subscriptions, management groups, resource groups, and in Azure Active Directory (e.g., Directory Reader for listing users and groups).

## Features
- Assign any Azure role at the subscription, management group, or resource group level
- Assign the Directory Reader role in Azure AD

## Requirements
- Terraform >= 1.0
- Providers: `azurerm` >= 3.0.0, `azuread`
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
  pantheon_service_principal = "<client_id>"
  role                       = "Security Reader"
  subscriptions              = ["<subscription_id>"]
  resource_groups            = ["<resource_group_name>"]
  management_groups          = ["<management_group_id>"]
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
  role                       = "Security Reader"
  resource_groups            = ["ResourceGroup1"]
  pantheon_service_principal = "<SERVICE_PRINCIPAL_ID>"
}

module "azure_permission_sub2" {
  source                     = "../modules/azure-permission"
  providers                  = { azurerm = azurerm.sub2 }
  role                       = "Security Reader"
  resource_groups            = ["ResourceGroup2"]
  pantheon_service_principal = "<SERVICE_PRINCIPAL_ID>"
}
```

## What is provisioned?
- Role assignment at the subscription level
- Role assignment at the management group level
- Role assignment at the resource group level
- Assignment of the Directory Reader role in Azure AD (enables listing users and groups)

## Notes
- The Directory Reader role is required for the service principal to list users and groups in Azure AD.
- All role assignments are optional; if you leave a variable empty, no assignment is created for that scope.