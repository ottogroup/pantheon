locals {
  folder_roles = flatten(
    [
      for role in var.pantheon_gcp_roles == null ? module.gcp-roles.necessary_gcp_roles : var.pantheon_gcp_roles : [
        for folderId in var.folder_ids : {
          role     = role
          folderId = folderId
        }
      ]
    ]
  )

  project_roles = flatten(
    [
      for role in var.pantheon_gcp_roles == null ? module.gcp-roles.necessary_gcp_roles : var.pantheon_gcp_roles : [
        for projectId in var.project_ids : {
          role      = role
          projectId = folderId
        }
      ]
    ]
  )
}
