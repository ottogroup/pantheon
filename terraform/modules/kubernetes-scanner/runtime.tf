locals {
  cronjob_schedule = "@midnight"
}

resource "kubernetes_cron_job_v1" "scanner" {
  metadata {
    name      = "pantheon-scanner"
    namespace = kubernetes_namespace_v1.pantheon_scanner.metadata.0.name
  }
  spec {
    schedule                      = local.cronjob_schedule
    timezone                      = "Europe/Berlin"
    concurrency_policy            = "Forbid"
    failed_jobs_history_limit     = 1
    starting_deadline_seconds     = 0
    successful_jobs_history_limit = 3

    job_template {
      spec {
        backoff_limit = 0
        completions   = 1

        template {
          spec {
            restart_policy       = "OnFailure"
            service_account_name = kubernetes_service_account_v1.pantheon_scanner.metadata.name
            affinity {
              node_affinity {
                preferred_during_scheduling_ignored_during_execution {
                  weight = 1
                  preference {
                    match_expressions {
                      key      = "kubernetes.io/arch"
                      operator = "In"
                      values = [var.pantheon_kubernetes_node_architecture]
                    }
                  }
                }
              }
            }

            container {
              name              = "scanner"
              image             = var.pantheon_kubernetes_scanner_image
              image_pull_policy = "Always"

              env_from {
                config_map_ref {
                  name = kubernetes_config_map_v1.pantheon_scanner_cm.metadata.name
                }
              }
              port {
                name           = "health"
                container_port = 8080
                protocol       = "TCP"
              }
              liveness_probe {
                http_get {
                  path = "/healthz"
                  port = "health"
                }
              }
              readiness_probe {
                http_get {
                  path = "/readyz"
                  port = "health"
                }
              }
              resources {
                limits = {
                  "cpu"    = "300m"
                  "memory" = "300Mi"
                }
                requests = {
                  "cpu"    = "300m"
                  "memory" = "300Mi"
                }
              }
              security_context {
                allow_privilege_escalation = false
                privileged                 = false
                read_only_root_filesystem  = false

                capabilities {
                  add = []
                  drop = [
                    "NET_RAW",
                  ]
                }
              }
            }

            security_context {
              supplemental_groups = []
              run_as_non_root = false

              seccomp_profile {
                type = "RuntimeDefault"
              }
            }

            toleration {
              effect   = "NoSchedule"
              key      = "kubernetes.io/arch"
              operator = "Equal"
              value    = var.pantheon_kubernetes_node_architecture
            }
          }
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations
    ]
  }
}
