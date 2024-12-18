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
  subjects {
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

resource "kubernetes_cluster_role_v1" "pantheon_scanner_cr" {
  metadata {
    name = "pantheon-scanner-cr"
  }

  rule {
    api_groups = ["certificates.k8s.io"]
    resources = ["certificatesigningrequests/status"]
    verbs = ["update"]
  }

  rule {
    api_groups = ["certificates.k8s.io"]
    resources = ["signers"]
    resource_names = ["kubernetes.io/kube-apiserver-client"]
    verbs = ["sign"]
  }

  rule {
    api_groups = ["certificates.k8s.io"]
    resources = ["certificatesigningrequests/approval"]
    verbs = ["update"]
  }

  rule {
    api_groups = ["certificates.k8s.io"]
    resources = ["signers"]
    resource_names = ["kubernetes.io/kube-apiserver-client"]
    verbs = ["approve"]
  }
}
