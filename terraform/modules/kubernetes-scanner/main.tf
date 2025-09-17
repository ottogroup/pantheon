resource "kubernetes_namespace_v1" "pantheon_scanner" {
  metadata {
    name = "pantheon-scanner"
  }
}

resource "kubernetes_service_account_v1" "pantheon_scanner" {
  metadata {
    name      = "pantheon-scanner-sa"
    namespace = kubernetes_namespace_v1.pantheon_scanner.metadata.0.name
  }
}

resource "kubernetes_cluster_role_binding_v1" "pantheon_scanner_crb" {
  metadata {
    name = "pantheon-scanner-crb"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.pantheon_scanner.metadata.0.name
    namespace = kubernetes_namespace_v1.pantheon_scanner.metadata.0.name
  }
  role_ref {
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.pantheon_scanner_cr.metadata.0.name
    api_group = "rbac.authorization.k8s.io"
  }
}

locals {
  role-document = yamldecode(file("${path.module}/../../../kubernetes/base/clusterrole.yaml"))
  rules         = local.role-document["rules"]
}

resource "kubernetes_cluster_role_v1" "pantheon_scanner_cr" {
  metadata {
    name = "pantheon-scanner-cr"
  }

  dynamic "rule" {
    for_each = local.rules
    content {
      api_groups = rule.value["apiGroups"]
      resources  = rule.value["resources"]
      verbs      = rule.value["verbs"]
    }
  }
}

resource "kubernetes_priority_class_v1" "pantheon-high-priority" {
  metadata {
    name = "pantheon-high-priority"
  }
  preemption_policy = "PreemptLowerPriority"
  value             = 10000000
}