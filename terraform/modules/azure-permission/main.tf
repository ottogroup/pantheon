data "azuread_service_principal" "pantheon-engine" {
  client_id = var.pantheon_service_principal
}

data "azurerm_subscription" "subscriptions" {
  for_each = toset(var.subscriptions)
  subscription_id = each.key
}


data "azurerm_role_definition" "subscription_role" {
  for_each = toset(var.subscriptions)
  name  = var.role
  scope = data.azurerm_subscription.subscriptions[each.key].id
}

resource "azurerm_role_assignment" "pantheon_engine_security_admin" {
  for_each = toset(var.subscriptions)
  scope              = data.azurerm_subscription.subscriptions[each.key].id
  role_definition_id = data.azurerm_role_definition.subscription_role[each.key].id
  principal_id       = data.azuread_service_principal.pantheon-engine.object_id
}

data "azurerm_management_group" "management_groups" {
  for_each = toset(var.management_groups)
  name = each.key
}

data "azurerm_role_definition" "management_groups" {
  for_each = toset(var.management_groups)
  name  = var.role
  scope = data.azurerm_management_group.management_groups[each.key].id
}

resource "azurerm_role_assignment" "pantheon_engine_security_admin_management_groups" {
  for_each = toset(var.management_groups)
  scope              = data.azurerm_management_group.management_groups[each.key].id
  role_definition_id = data.azurerm_role_definition.management_groups[each.key].id
  principal_id       = data.azuread_service_principal.pantheon-engine.object_id
}

data "azurerm_resource_group" "resource_groups" {
  for_each = toset(var.resource_groups)
  name = each.key
}

data "azurerm_role_definition" "resource_groups" {
  for_each = toset(var.resource_groups)
  name  = var.role
  scope = data.azurerm_resource_group.resource_groups[each.key].id
}

resource "azurerm_role_assignment" "pantheon_engine_security_admin_resource_groups" {
  for_each = toset(var.resource_groups)
  scope              = data.azurerm_resource_group.resource_groups[each.key].id
  role_definition_id = data.azurerm_role_definition.resource_groups[each.key].id
  principal_id       = data.azuread_service_principal.pantheon-engine.object_id
}

resource "azuread_directory_role" "directory_reader" {
  display_name = var.role
}

resource "azuread_directory_role_assignment" "pantheon_engine_directory_reader" {
  role_id   = resource.azuread_directory_role.directory_reader.object_id
  principal_object_id = data.azuread_service_principal.pantheon-engine.object_id
}