resource "stackit_authorization_organization_custom_role" "oneoguard_full_access" {
  resource_id = var.organization_id
  name        = var.role_name
  description = "Stackit full access role for one.O Guard Security Monitoring"
  permissions = local.filtered_permissions
}


resource "stackit_authorization_organization_role_assignment" "oneoguard_full_access" {
  resource_id = var.organization_id
  role        = stackit_authorization_organization_custom_role.oneoguard_full_access.name
  subject     = var.oneoguard_engine_email
}
