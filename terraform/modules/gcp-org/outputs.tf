output "pantheon_engine_role_id" {
  type        = string
  description = "The ID Pantheon Engine custom role."
  value       = google_organization_iam_custom_role.pantheon_engine_permissions.id
}
