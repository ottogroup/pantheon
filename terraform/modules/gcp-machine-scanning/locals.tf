locals {
  folder_roles = flatten(
    [
      for folderId in var.folder_ids : {
        role     = var.pantheon_machine_scanning_role_id
        folderId = folderId
      }
    ]
  )
  is_org_level = length(var.folder_ids) == 0
}