## Usage


Setup environment

1. Create Google Service Account
    * add role `Service Account Token Creator` to itself and to the service account that will run the terraform in CICD pipeline
    * copy unique ID of the service account
2. In Google Workspace Admin Console, assign the Service Account wide-domain delegation
   * Go to https://admin.google.com/ -> Security -> Access and data control
   * click in tag **Domain-wide delegation** button **manage domain-wide delegation** then **Add new**
   * paste the unique ID of the service account and add scope `https://www.googleapis.com/auth/admin.directory.rolemanagement`
   * ![domain wide-delegation for gsa](domain-wide-delegation-for-gsa.png)
3. Create a Google Service account key
    * download the key file
    * save content of the key file to a secret manager
4. Create a Google Workspace Role with the following snippet

```hcl

// provider preparation

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6"
    }
    googleworkspace = {
      source  = "hashicorp/googleworkspace"
      version = "~> 0.7.0"
    }
  }
  required_version = ">= 1.7"
}

provider "google" {
  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
  ]
}

data "google_secret_manager_secret_version" "gsa-key" {
  // format is "projects/PROJECT_NUMBER/secrets/SECRET_NAME"
  secret = GOOGLE_SERVICE_ACCOUNT_KEY_SECRET_NAME
}

provider "googleworkspace" {
  credentials             = data.google_secret_manager_secret_version.gsa-key.secret_data
  // find customer id https://apps.google.com/supportwidget/articlehome?hl=en&article_url=https%3A%2F%2Fsupport.google.com%2Fa%2Fanswer%2F10070793%3Fhl%3Den&assistant_id=generic-unu&product_context=10070793&product_name=UnuFlow&trigger_context=a
  customer_id             = CUSTOMER_ID
  // it needs to be a user email that has role Super Admin
  impersonated_user_email = DELEGATED_EMAIL
  oauth_scopes = [
    "https://www.googleapis.com/auth/admin.directory.rolemanagement",
  ]
}

// module usage

locals {
  pantheon_service_accounts = {
    "directory@PROJECT_ID.iam.gserviceaccount.com" = 100000000000000000000
  }
}

module "pantheon-googleworkspace-role" {
  source                    = "github.com/ottogroup/pantheon//terraform/modules/googleworkspace-roles?ref=v1.1.30"
  name                      = "Pantheon Directory Reader"
  pantheon_service_accounts = local.pantheon_service_accounts
}
```
5. Result should be like on the image below - please note that Google Workspace Admin Console UI is changing frequently
   * ![google-workspace-pantheon-role.png](google-workspace-pantheon-role.png)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_googleworkspace"></a> [googleworkspace](#requirement\_googleworkspace) | >= 0.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_googleworkspace"></a> [googleworkspace](#provider\_googleworkspace) | >= 0.7.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [googleworkspace_role.pantheon](https://registry.terraform.io/providers/hashicorp/googleworkspace/latest/docs/resources/role) | resource |
| [googleworkspace_role_assignment.pantheon](https://registry.terraform.io/providers/hashicorp/googleworkspace/latest/docs/resources/role_assignment) | resource |
| [googleworkspace_privileges.privileges](https://registry.terraform.io/providers/hashicorp/googleworkspace/latest/docs/data-sources/privileges) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the role. | `string` | `"Pantheon Directory Reader"` | no |
| <a name="input_pantheon_service_accounts"></a> [pantheon\_service\_accounts](#input\_pantheon\_service\_accounts) | Role assignments for pantheon service accounts in google workspace need GSA unique ID. Format email: GSA unique ID | `map(number)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pantheon_role_id"></a> [pantheon\_role\_id](#output\_pantheon\_role\_id) | Pantheon role id. |
<!-- END_TF_DOCS -->