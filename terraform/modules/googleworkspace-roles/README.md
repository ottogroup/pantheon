## Usage

Setup provider


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 0.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_googleworkspace"></a> [googleworkspace](#provider\_googleworkspace) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [googleworkspace_role.pantheon](https://registry.terraform.io/providers/hashicorp/googleworkspace/latest/docs/resources/role) | resource |
| [googleworkspace_privileges.privileges](https://registry.terraform.io/providers/hashicorp/googleworkspace/latest/docs/data-sources/privileges) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the role. | `string` | `"Pantheon Directory Reader"` | no |
| <a name="input_pantheon_accounts"></a> [pantheon\_accounts](#input\_pantheon\_accounts) | Pantheon service account that need assigned this role. Format is {service\_account\_email= service\_account\_id} | `map(number)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pantheon_role_id"></a> [pantheon\_role\_id](#output\_pantheon\_role\_id) | Pantheon role id. |
<!-- END_TF_DOCS -->