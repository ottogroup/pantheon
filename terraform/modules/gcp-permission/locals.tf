locals {
  folder_roles = flatten(
      [
      for role in module.gcp-roles.necessary_gcp_roles : [
        for folderId in var.folder_ids : {
          role     = role
          folderId = folderId
        }
      ]
    ]
  )
}
