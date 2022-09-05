#
# This file contains role bindings required for Pantheon on the org level.
#

# This is required to run the cloud asset export.
resource "google_organization_iam_member" "cloudasset_viewer" {
  count  = local.is_org_level ? 1 : 0
  org_id = var.org_id
  member = "serviceAccount:${var.pantheon_service_account}"
  role   = "roles/cloudasset.viewer"
}

# query organizations, folders and projects
resource "google_organization_iam_member" "browser" {
  count  = local.is_org_level ? 1 : 0
  org_id = var.org_id
  role   = "roles/browser"
  member = "serviceAccount:${var.pantheon_service_account}"
}

# query all regular resources
resource "google_organization_iam_member" "viewer" {
  count  = local.is_org_level ? 1 : 0
  org_id = var.org_id
  role   = "roles/viewer"
  member = "serviceAccount:${var.pantheon_service_account}"
}

# query all IAM policies
resource "google_organization_iam_member" "iam_securityreviewer" {
  count  = local.is_org_level ? 1 : 0
  org_id = var.org_id
  role   = "roles/iam.securityReviewer"
  member = "serviceAccount:${var.pantheon_service_account}"
}

# for bigquery.tables.get
resource "google_organization_iam_member" "bigquery_metadata_viewer" {
  count  = local.is_org_level ? 1 : 0
  org_id = var.org_id
  role   = "roles/bigquery.metadataViewer"
  member = "serviceAccount:${var.pantheon_service_account}"
}

resource "google_organization_iam_member" "pantheon_custom" {
  count  = local.is_org_level ? 1 : 0
  org_id = var.org_id
  role   = var.pantheon_engine_role_id
  member = "serviceAccount:${var.pantheon_service_account}"
}
