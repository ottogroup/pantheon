# special permissions that are not part of the managed viewer roles
resource "google_organization_iam_custom_role" "pantheon_engine_permissions" {
  org_id      = var.org_id
  role_id     = "pantheonextra"
  title       = "Pantheon Engine"
  description = "Permissions for Pantheon Engine that are not part of GCP managed viewer roles."
  permissions = [
    "cloudasset.feeds.get",
    "source.repos.getProjectConfig",
    # There is no viewer role that contains this permission,
    # except Legacy Bucket Reader which you can only assign on the bucket level.
    "storage.buckets.get",
    # Required for iap.projects.brands.identityAwareProxyClients
    "clientauthconfig.clients.listWithSecrets",
  ]
}
