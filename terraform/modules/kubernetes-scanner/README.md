<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.38.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.38.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_cluster_role_binding_v1.pantheon_scanner_crb](https://registry.terraform.io/providers/hashicorp/kubernetes/2.38.0/docs/resources/cluster_role_binding_v1) | resource |
| [kubernetes_cluster_role_v1.pantheon_scanner_cr](https://registry.terraform.io/providers/hashicorp/kubernetes/2.38.0/docs/resources/cluster_role_v1) | resource |
| [kubernetes_config_map_v1.pantheon_scanner_cm](https://registry.terraform.io/providers/hashicorp/kubernetes/2.38.0/docs/resources/config_map_v1) | resource |
| [kubernetes_cron_job_v1.scanner](https://registry.terraform.io/providers/hashicorp/kubernetes/2.38.0/docs/resources/cron_job_v1) | resource |
| [kubernetes_namespace_v1.pantheon_scanner](https://registry.terraform.io/providers/hashicorp/kubernetes/2.38.0/docs/resources/namespace_v1) | resource |
| [kubernetes_priority_class_v1.pantheon-high-priority](https://registry.terraform.io/providers/hashicorp/kubernetes/2.38.0/docs/resources/priority_class_v1) | resource |
| [kubernetes_service_account_v1.pantheon_scanner](https://registry.terraform.io/providers/hashicorp/kubernetes/2.38.0/docs/resources/service_account_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_pantheon_kubernetes_cluster_asset_class"></a> [pantheon\_kubernetes\_cluster\_asset\_class](#input\_pantheon\_kubernetes\_cluster\_asset\_class) | The asset class of the cluster | `any` | n/a | yes |
| <a name="input_pantheon_kubernetes_cluster_canonical_asset_type"></a> [pantheon\_kubernetes\_cluster\_canonical\_asset\_type](#input\_pantheon\_kubernetes\_cluster\_canonical\_asset\_type) | The canonical asset type of the cluster | `any` | n/a | yes |
| <a name="input_pantheon_kubernetes_cluster_canonical_resource_id"></a> [pantheon\_kubernetes\_cluster\_canonical\_resource\_id](#input\_pantheon\_kubernetes\_cluster\_canonical\_resource\_id) | The canonical resource id of the cluster | `any` | n/a | yes |
| <a name="input_pantheon_kubernetes_cluster_service_id"></a> [pantheon\_kubernetes\_cluster\_service\_id](#input\_pantheon\_kubernetes\_cluster\_service\_id) | The service id cluster | `any` | n/a | yes |
| <a name="input_pantheon_kubernetes_node_architecture"></a> [pantheon\_kubernetes\_node\_architecture](#input\_pantheon\_kubernetes\_node\_architecture) | The target node architecture for the scanner | `string` | `"amd64"` | no |
| <a name="input_pantheon_kubernetes_scanner_image"></a> [pantheon\_kubernetes\_scanner\_image](#input\_pantheon\_kubernetes\_scanner\_image) | The docker image to use for the pantheon kubernetes scanner | `any` | n/a | yes |
| <a name="input_pantheon_kubernetes_sink_message_broker"></a> [pantheon\_kubernetes\_sink\_message\_broker](#input\_pantheon\_kubernetes\_sink\_message\_broker) | The sink message broker | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->