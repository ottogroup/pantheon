#
# This file contains role bindings required for Pantheon on the project level.
#

# Iterate over the permutation of all roles and projectIDs
resource "google_project_iam_member" "project_level_permissions" {
  for_each =  local.is_project_level ? { for entry in local.project_roles : "${entry.role}.${entry.projectId}" => entry } : {}
  project   = each.value.projectId
  member   = "serviceAccount:${var.pantheon_service_account}"
  role     = each.value.role
}
