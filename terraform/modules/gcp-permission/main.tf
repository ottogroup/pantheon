locals {
  is_org_level = length(var.folder_ids) == 0
}

module "gcp-roles" {
  source = "./../gcp-roles"
  pantheon_engine_role_id = var.pantheon_engine_role_id
}
