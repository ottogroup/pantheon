output "writer_identity" {
  value       = try(google_logging_folder_sink.this[0].writer_identity, google_logging_organization_sink.this[0].writer_identity, "")
  description = "The generated service account used to write to the destination URI. It is in the form 'serviceAccount:o<org-id>-<random number>@gcp-sa-logging.iam.gserviceaccount.com' or 'serviceAccount:f<folder id>-<random number>@gcp-sa-logging.iam.gserviceaccount.com'."
}
