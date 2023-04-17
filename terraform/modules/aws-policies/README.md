<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_attachment.attach_ViewOnlyAccess_to_gcp_federation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.gcp_federation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.attach_SecurityAudit_to_gcp_federation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy.SecurityAudit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.ViewOnlyAccess](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_pantheon_role_name"></a> [pantheon\_role\_name](#input\_pantheon\_role\_name) | AWS IAM Role name | `string` | n/a | yes |
| <a name="input_pantheon_service_account_id"></a> [pantheon\_service\_account\_id](#input\_pantheon\_service\_account\_id) | GSP service account id used to scan resources. Will be provided by the team. | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pantheon-role-arn"></a> [pantheon-role-arn](#output\_pantheon-role-arn) | n/a |
<!-- END_TF_DOCS -->