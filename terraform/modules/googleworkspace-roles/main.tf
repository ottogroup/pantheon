data "googleworkspace_privileges" "privileges" {}

locals {
  required_role_privileges = [
    "ADMIN_REPORTING_ACCESS",
    "GROUPS_RETRIEVE",
    "ORGANIZATION_UNITS_RETRIEVE",
    "REPORTS",
    "USERS_RETRIEVE",
    "SIT_VIEW_METADATA",
    "VIEW_GSC_RULE",
  ]
  role_privileges = [
    for privilege in data.googleworkspace_privileges.privileges.items : privilege
    if contains(local.required_role_privileges, privilege.privilege_name)
  ]
}

resource "googleworkspace_role" "pantheon" {
  name        = var.name
  description = "Pantheon service will use it to read domain users, groups, group members and users activities."

  dynamic "privileges" {
    for_each = local.role_privileges
    content {
      service_id     = privileges.value["service_id"]
      privilege_name = privileges.value["privilege_name"]
    }
  }
}
