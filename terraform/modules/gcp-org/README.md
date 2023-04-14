## Pantheon gcp-org terraform module

Provides resources on organization level, e.g. custom roles

This module is mandatory.

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
| [google_organization_iam_custom_role.pantheon_engine_permissions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_custom_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | The ID of the GCP organization, e.g. 123456789. Needs to be set by user. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pantheon_engine_role_id"></a> [pantheon\_engine\_role\_id](#output\_pantheon\_engine\_role\_id) | The identifier of the created custom role with the format organizations/{{org\_id}}/roles/{{role\_id}}. |
<!-- BEGIN_TF_DOCS -->
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
| [google_organization_iam_custom_role.pantheon_engine_permissions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_custom_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | The ID of the GCP organization, e.g. 123456789. Needs to be set by user. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pantheon_engine_role_id"></a> [pantheon\_engine\_role\_id](#output\_pantheon\_engine\_role\_id) | The identifier of the created custom role with the format organizations/{{org\_id}}/roles/{{role\_id}}. |
<!-- END_TF_DOCS -->