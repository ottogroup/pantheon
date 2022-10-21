#
# This file contains role bindings required for Pantheon on the org level.
#

# Only iterate over roles, if the configuration is on org level, else iterate over empty list (create not resources)
resource "google_organization_iam_member" "org_level_permissions" {
  for_each = local.is_org_level ? toset(module.gcp-roles.necessary_gcp_roles) : []
  org_id = var.org_id
  member = "serviceAccount:${var.pantheon_service_account}"
  role   = each.key
}
