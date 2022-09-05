#
# This file contains role bindings required for Pantheon on the folder level.
#

# This is required to run the cloud asset export.
resource "google_folder_iam_member" "cloudasset_viewer" {
  for_each = toset(var.folder_ids)
  folder   = each.key
  member   = "serviceAccount:${var.pantheon_service_account}"
  role     = "roles/cloudasset.viewer"
}

# query folders and projects
resource "google_folder_iam_member" "browser" {
  for_each = toset(var.folder_ids)
  folder   = each.key
  role     = "roles/browser"
  member   = "serviceAccount:${var.pantheon_service_account}"
}

# query all regular resources
resource "google_folder_iam_member" "viewer" {
  for_each = toset(var.folder_ids)
  folder   = each.key
  role     = "roles/viewer"
  member   = "serviceAccount:${var.pantheon_service_account}"
}

# query all IAM policies
resource "google_folder_iam_member" "iam_securityreviewer" {
  for_each = toset(var.folder_ids)
  folder   = each.key
  role     = "roles/iam.securityReviewer"
  member   = "serviceAccount:${var.pantheon_service_account}"
}

# for bigquery.tables.get
resource "google_folder_iam_member" "bigquery_metadata_viewer" {
  for_each = toset(var.folder_ids)
  folder   = each.key
  role     = "roles/bigquery.metadataViewer"
  member   = "serviceAccount:${var.pantheon_service_account}"
}

resource "google_folder_iam_member" "pantheon_custom" {
  for_each = toset(var.folder_ids)
  folder   = each.key
  role     = var.pantheon_engine_role_id
  member   = "serviceAccount:${var.pantheon_service_account}"
}
