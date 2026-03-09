## Pantheon gcp-org terraform module

Provides IAM bindings on folder or organization level.

This module is optional.

Example usage
```hcl

# needed to prepare Pantheon VM Scanner role

module "gcp-org" {
  source = "github.com/ottogroup/pantheon//terraform/modules/gcp-org?ref=VERSION"
  org_id = "1234567890", # Organization1
}

module "gcp-machine-scanning" {
  source = "github.com/ottogroup/pantheon//terraform/modules/gcp-machine-scanning?ref=VERSION"

  # either org_id or folder_ids MUST be set
  org_id = "1234567890", # Organization1
  folder_ids = [
    "folders/112233445566" # Department2
  ]

  pantheon_machine_scanning_role_id = module.gcp-org.pantheon_machine_scanning_role_id
  pantheon_service_account          = "engine@<project_id>.iam.gserviceaccount.com"
}


```

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcp-roles"></a> [gcp-roles](#module\_gcp-roles) | ./../gcp-roles | n/a |

## Resources

| Name | Type |
|------|------|
| [google_folder_iam_member.folder_level_permissions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/folder_iam_member) | resource |
| [google_organization_iam_member.org_level_permissions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_folder_ids"></a> [folder\_ids](#input\_folder\_ids) | Optional: The ID of a folder you want to attach the permissions to. Per default, the permissions will be granted on the org level. The format for each element is folders/{folder\_id}. Needs to be set by user. | `list(string)` | `[]` | no |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | The ID of the organization that owns the resources that you want to scan. Needs to be set by user. | `string` | `null` | no |
| <a name="input_pantheon_engine_role_id"></a> [pantheon\_engine\_role\_id](#input\_pantheon\_engine\_role\_id) | The ID of org level custom role of Pantheon Engine. Will be provided by output of gcp-org module. | `string` | n/a | yes |
| <a name="input_pantheon_gcp_roles"></a> [pantheon\_gcp\_roles](#input\_pantheon\_gcp\_roles) | The roles that will be applied to all folders or the organization. The default are the recommended roles. | `list(string)` | `null` | no |
| <a name="input_pantheon_service_account"></a> [pantheon\_service\_account](#input\_pantheon\_service\_account) | The service account used to scan resources. Will be provided by the team. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 7.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 7.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_folder_iam_member.folder_level_permissions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/folder_iam_member) | resource |
| [google_organization_iam_member.org_level_permissions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [null_resource.assert_org_or_folder_ids_are_set](https://registry.terraform.io/providers/hashicorp/null/3.2.4/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_folder_ids"></a> [folder\_ids](#input\_folder\_ids) | The ID of a folder you want to attach the permissions to. Per default, the permissions will be granted on the org level. The format for each element is folders/{folder\_id}. Needs to be set by user. Either org\_id or folder\_ids must be set. | `list(string)` | `[]` | no |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | The ID of the organization that owns the resources that you want to scan. Needs to be set by user. Either org\_id or folder\_ids must be set. | `string` | `null` | no |
| <a name="input_pantheon_machine_scanning_role_id"></a> [pantheon\_machine\_scanning\_role\_id](#input\_pantheon\_machine\_scanning\_role\_id) | The ID of org level custom role of Pantheon VM Scanner. Will be provided by output of gcp-org module. | `string` | n/a | yes |
| <a name="input_pantheon_service_account"></a> [pantheon\_service\_account](#input\_pantheon\_service\_account) | The service account used to scan resources. Will be provided by the team. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->