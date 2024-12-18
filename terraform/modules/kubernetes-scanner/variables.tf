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
variable "pantheon_kubernetes_node_architecture" {
  description = "The target node architecture for the scanner"
  default     = "amd64"
}