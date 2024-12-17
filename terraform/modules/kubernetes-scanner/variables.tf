variable "pantheon_kubernetes_scanner_image" {
  description = "The docker image to use for the pantheon kubernetes scanner"
}

variable "pantheon_kubernetes_cluster_asset_class" {
  description = "The asset class of the cluster"
}

variable "pantheon_kubernetes_cluster_canonical_asset_type" {
  description = "The canonical asset type of the cluster"
}

variable "pantheon_kubernetes_cluster_canonical_resource_id" {
  description = "The canonical resource id of the cluster"
}

variable "pantheon_kubernetes_cluster_service_id" {
  description = "The service id cluster"
}

variable "pantheon_kubernetes_sink_message_broker" {
  description = "The sink message broker"
}

module "pantheon_kubernetes_scanner" {
  source                                  = "github.com/ottogroup/pantheon//terraform/modules/kubernetes-scanner?ref=v1.1.26"
  pantheon_kubernetes_scanner_image       = "europe-west1-docker.pkg.dev/oghub-pantheon-tooling/public/scanner:latest"
  pantheon_kubernetes_cluster_asset_class =${props.asset.assetClass}
pantheon_kubernetes_cluster_canonical_asset_type = ${props.asset.serviceID}
pantheon_kubernetes_cluster_canonical_resource_id = ${props.asset.canonicalAssetType}
pantheon_kubernetes_cluster_service_id = ${props.asset.canonicalResourceID}
pantheon_kubernetes_sink_message_broker = ${resp.kubernetes_message_broker}
}