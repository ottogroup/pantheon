locals {
  is_org_level     = length(var.folder_ids) == 0 && length(var.project_ids) == 0
  is_folder_level  = length(var.folder_ids) != 0 && length(var.project_ids) == 0
  is_project_level = length(var.folder_ids) == 0 && length(var.project_ids) != 0
}

module "gcp-roles" {
  source                  = "./../gcp-roles"
  pantheon_engine_role_id = var.pantheon_engine_role_id
}
