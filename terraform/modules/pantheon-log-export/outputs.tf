output "writer_identity" {
  value = try(google_logging_folder_sink.this[0].writer_identity, google_logging_organization_sink.this[0].writer_identity, "")
}
