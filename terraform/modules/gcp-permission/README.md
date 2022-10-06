## Pantheon gcp-org terraform module

Provides IAM bindings on folder or organization level.

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
| [google_folder_iam_member.bigquery_metadata_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/folder_iam_member) | resource |
| [google_folder_iam_member.browser](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/folder_iam_member) | resource |
| [google_folder_iam_member.cloudasset_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/folder_iam_member) | resource |
| [google_folder_iam_member.firebase_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/folder_iam_member) | resource |
| [google_folder_iam_member.iam_securityreviewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/folder_iam_member) | resource |
| [google_folder_iam_member.pantheon_custom](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/folder_iam_member) | resource |
| [google_folder_iam_member.viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/folder_iam_member) | resource |
| [google_organization_iam_member.bigquery_metadata_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_organization_iam_member.browser](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_organization_iam_member.cloudasset_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_organization_iam_member.firebase_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_organization_iam_member.iam_securityreviewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_organization_iam_member.pantheon_custom](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_organization_iam_member.viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_folder_ids"></a> [folder\_ids](#input\_folder\_ids) | Optional: The ID of a folder you want to attach the permissions to. Per default, the permissions will be granted on the org level. The format for each element is folders/{folder\_id}. Needs to be set by user. | `list(string)` | `[]` | no |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | The ID of the organization that owns the resources that you want to scan. Needs to be set by user. | `string` | `null` | no |
| <a name="input_pantheon_engine_role_id"></a> [pantheon\_engine\_role\_id](#input\_pantheon\_engine\_role\_id) | The ID of org level custom role of Pantheon Engine. Will be provided by output of gcp-org module. | `string` | n/a | yes |
| <a name="input_pantheon_service_account"></a> [pantheon\_service\_account](#input\_pantheon\_service\_account) | The service account used to scan resources. Will be provided by the team. | `string` | n/a | yes |

## Outputs

No outputs.