<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.31.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.31.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_cluster_role_binding_v1.pantheon_scanner_crb](https://registry.terraform.io/providers/hashicorp/kubernetes/2.31.0/docs/resources/cluster_role_binding_v1) | resource |
| [kubernetes_cluster_role_v1.pantheon_scanner_cr](https://registry.terraform.io/providers/hashicorp/kubernetes/2.31.0/docs/resources/cluster_role_v1) | resource |
| [kubernetes_config_map_v1.pantheon_scanner_cm](https://registry.terraform.io/providers/hashicorp/kubernetes/2.31.0/docs/resources/config_map_v1) | resource |
| [kubernetes_cron_job_v1.scanner](https://registry.terraform.io/providers/hashicorp/kubernetes/2.31.0/docs/resources/cron_job_v1) | resource |
| [kubernetes_namespace_v1.pantheon_scanner](https://registry.terraform.io/providers/hashicorp/kubernetes/2.31.0/docs/resources/namespace_v1) | resource |
| [kubernetes_service_account_v1.pantheon_scanner](https://registry.terraform.io/providers/hashicorp/kubernetes/2.31.0/docs/resources/service_account_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_pantheon_kubernetes_scanner_config_file"></a> [pantheon\_kubernetes\_scanner\_config\_file](#input\_pantheon\_kubernetes\_scanner\_config\_file) | The path to the config file to use for the pantheon kubernetes scanner | `any` | n/a | yes |
| <a name="input_pantheon_kubernetes_scanner_image"></a> [pantheon\_kubernetes\_scanner\_image](#input\_pantheon\_kubernetes\_scanner\_image) | The docker image to use for the pantheon kubernetes scanner | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->