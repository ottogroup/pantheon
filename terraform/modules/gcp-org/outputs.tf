output "pantheon_engine_role_id" {
  value       = google_organization_iam_custom_role.pantheon_engine_permissions.id
  description = "The identifier of the created custom role with the format organizations/{{org_id}}/roles/{{role_id}}."
}

output "pantheon_vmscanner_role_id" {
  value       = google_organization_iam_custom_role.pantheon_vmscanner_permissions.id
  description = "The identifier of the created custom role with the format organizations/{{org_id}}/roles/{{role_id}}."
}
