## Pantheon gcp-billing terraform module

This module provides IAM bindings for the billing account scanning. 

This module is optional.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_billing_account_iam_member.billing_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/billing_account_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account_id"></a> [billing\_account\_id](#input\_billing\_account\_id) | The ID of the billing account that is attached to the resources been scanned. | `string` | `null` | no |
| <a name="input_pantheon_service_account"></a> [pantheon\_service\_account](#input\_pantheon\_service\_account) | The service account used to scan resources. Will be provided by the team. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_billing_account_iam_member.billing_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/billing_account_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account_id"></a> [billing\_account\_id](#input\_billing\_account\_id) | The ID of the billing account that is attached to the resources been scanned. | `string` | `null` | no |
| <a name="input_pantheon_service_account"></a> [pantheon\_service\_account](#input\_pantheon\_service\_account) | The service account used to scan resources. Will be provided by the team. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->