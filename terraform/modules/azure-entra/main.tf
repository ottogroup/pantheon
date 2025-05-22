data "azuread_service_principal" "pantheon-service-principal" {
  client_id = var.pantheon_service_principal
}

resource "azuread_directory_role" "directory_reader" {
  display_name = var.role
}

resource "azuread_directory_role_assignment" "pantheon_engine_directory_reader" {
  role_id   = resource.azuread_directory_role.directory_reader.object_id
  principal_object_id = data.azuread_service_principal.pantheon-service-principal.object_id
}