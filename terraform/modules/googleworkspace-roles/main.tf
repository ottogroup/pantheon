data "googleworkspace_privileges" "privileges" {}

locals {
  required_role_privileges = [
    // some API privileges will implicitly include other privileges in UI
    // some privileges in UI will implicitly include other privileges in API

    // Admin console privileges -> Organisational units -> Read
    // Admin API privileges -> Organisation units -> Read
    "ORGANIZATION_UNITS_RETRIEVE",
    // Admin console privileges -> Users -> Read
    // Admin API privileges -> Users -> Read
    "USERS_RETRIEVE",
    // Admin console privileges -> Security Center -> Activity Rules -> View
    "VIEW_GSC_RULE",
    // Admin console privileges -> Security Center -> Audit and Investigation -> View -> *
    "SIT_ADMIN_VIEW_METADATA",
    "SIT_AUDITOR_VIEW_METADATA",
    "SIT_AXT_VIEW_METADATA",
    "SIT_CAA_VIEW_METADATA",
    "SIT_CALENDAR_VIEW_METADATA",
    "SIT_CHAT_VIEW_METADATA",
    "SIT_CHROME_VIEW_METADATA",
    "SIT_CLASSROOM_VIEW_METADATA",
    "SIT_CLOUD_SEARCH_VIEW_METADATA",
    "SIT_CONTACTS_VIEW_METADATA",
    "SIT_COURSEKIT_VIEW_METADATA",
    "SIT_CURRENTS_VIEW_METADATA",
    "SIT_DATASTUDIO_VIEW_METADATA",
    "SIT_DEVICE_VIEW_METADATA",
    "SIT_DIRECTORY_SYNC_VIEW_METADATA",
    "SIT_DRIVE_VIEW_METADATA",
    "SIT_GMAIL_VIEW_METADATA",
    "SIT_GOOGLE_PROFILES_VIEW_METADATA",
    "SIT_GRADUATION_VIEW_METADATA",
    "SIT_GROUPSALT_VIEW_METADATA",
    "SIT_GROUPS_VIEW_METADATA",
    "SIT_HODOR_VIEW_METADATA",
    "SIT_JAMBOARD_VIEW_METADATA",
    "SIT_KEEP_VIEW_METADATA",
    "SIT_LDAP_VIEW_METADATA",
    "SIT_MEET_HARDWARE_VIEW_METADATA",
    "SIT_MEET_VIEW_METADATA",
    "SIT_OAUTH_VIEW_METADATA",
    "SIT_PASSWORD_VAULT_VIEW_METADATA",
    "SIT_RULE_VIEW_METADATA",
    "SIT_SAML_VIEW_METADATA",
    "SIT_SCIM_DS_VIEW_METADATA",
    "SIT_TASKS_VIEW_METADATA",
    "SIT_USER_LEVEL_TAKEOUT_VIEW_METADATA",
    "SIT_USER_VIEW_METADATA",
    "SIT_VIEW_METADATA",
    "SIT_VOICE_VIEW_METADATA",
    // Admin console privileges -> Reports
    "REPORTS",
    "ADMIN_REPORTING_ACCESS",
    // Admin API privileges -> Groups -> Read
    "GROUPS_RETRIEVE",
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

resource "googleworkspace_role_assignment" "pantheon" {
  for_each    = var.pantheon_service_accounts
  role_id     = googleworkspace_role.pantheon.id
  assigned_to = each.value
}