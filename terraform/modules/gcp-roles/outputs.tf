output "necessary_gcp_roles" {
  value = [
    # This is required to run the cloud asset export.
    "roles/cloudasset.viewer",
    # query organizations, folders and projects
    "roles/browser",
    # query all regular resources
    "roles/viewer",
    # query all IAM policies
    "roles/iam.securityReviewer",
    # for bigquery.tables.get
    "roles/bigquery.metadataViewer",
    # for storage.buckets.get
    "roles/firebase.viewer",
    # for essentialcontacts.organizations.contacts.list
    "roles/essentialcontacts.viewer",
    #
    var.pantheon_engine_role_id
  ]
  description = "A list of all recommended gcp roles for pantheon. "
}