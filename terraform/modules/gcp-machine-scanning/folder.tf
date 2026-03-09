#
# This file contains role bindings required for Pantheon on the folder level.
#

# Iterate over the permutation of all roles and folderIds
resource "google_folder_iam_member" "folder_level_permissions" {
  for_each = { for entry in local.folder_roles : "${entry.role}.${entry.folderId}" => entry }
  folder   = each.value.folderId
  member   = "serviceAccount:${var.pantheon_service_account}"
  role     = each.value.role
}
