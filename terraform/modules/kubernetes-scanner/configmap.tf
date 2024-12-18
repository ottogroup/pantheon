resource "kubernetes_config_map_v1" "pantheon_scanner_cm" {
  metadata {
    name      = "pantheon-scanner-cm"
    namespace = kubernetes_namespace_v1.pantheon_scanner.metadata.0.name
  }
  data = {
    PANTHEON_CLUSTER_ASSET_CLASS           = local.config_data.pantheon_cluster_asset_class
    PANTHEON_CLUSTER_CANONICAL_ASSET_TYPE  = local.config_data.pantheon_cluster_canonical_asset_type
    PANTHEON_CLUSTER_CANONICAL_RESOURCE_ID = local.config_data.pantheon_cluster_canonical_resource_id
    PANTHEON_CLUSTER_SERVICE_ID            = local.config_data.pantheon_cluster_service_id
    PANTHEON_SINK_MESSAGE_BROKER           = local.config_data.pantheon_sink_message_broker
  }
}