resource "google_billing_account_iam_member" "billing_viewer" {
  member             = "serviceAccount:${var.pantheon_service_account}"
  role               = "roles/billing.viewer"
  billing_account_id = var.billing_account_id
}
