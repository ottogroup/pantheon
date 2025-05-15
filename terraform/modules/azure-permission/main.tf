data "azuread_service_principal" "pantheon-engine" {
  client_id = var.pantheon_service_principal
}

data "azurerm_subscription" "subscriptions" {
  for_each = toset(var.subscriptions)
  subscription_id = each.key
}


data "azurerm_role_definition" "subscription_role" {
  for_each = var.subscriptions
  name     = var.role
  scope    = each.value
}

resource "azurerm_role_assignment" "pantheon_engine_security_admin" {
  for_each = toset(var.subscriptions)
  scope              = data.azurerm_subscription.subscriptions[each.key].id
  role_definition_id = data.azurerm_role_definition.subscription_role[each.key].id
  principal_id       = data.azuread_service_principal.pantheon-engine.object_id
}
