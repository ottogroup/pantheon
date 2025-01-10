resource "kubernetes_config_map_v1" "pantheon_scanner_cm" {
  metadata {
    name      = "pantheon-scanner-cm"
    namespace = kubernetes_namespace_v1.pantheon_scanner.metadata.0.name
  }
  data = {
    PANTHEON_CLUSTER_ASSET_CLASS           = var.pantheon_kubernetes_cluster_asset_class
    PANTHEON_CLUSTER_CANONICAL_ASSET_TYPE  = var.pantheon_kubernetes_cluster_canonical_asset_type
    PANTHEON_CLUSTER_CANONICAL_RESOURCE_ID = var.pantheon_kubernetes_cluster_canonical_resource_id
    PANTHEON_CLUSTER_SERVICE_ID            = var.pantheon_kubernetes_cluster_service_id
    PANTHEON_SINK_MESSAGE_BROKER           = var.pantheon_kubernetes_sink_message_broker
  }
}