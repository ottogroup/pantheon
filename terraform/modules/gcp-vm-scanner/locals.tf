locals {
  folder_roles = flatten(
    [
      for folderId in var.folder_ids : {
        role     = var.pantheon_vmscanner_role_id
        folderId = folderId
      }
    ]
  )
}