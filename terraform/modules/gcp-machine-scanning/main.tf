
resource "null_resource" "assert_org_or_folder_ids_are_set" {
  lifecycle {
    precondition {
      condition     = (var.org_id == null && length(var.folder_ids) > 0) || (var.org_id != null && length(var.folder_ids) > 0)
      error_message = "Either org_id or folder_ids must be set. Please provide either an org_id or at least one folder_id."
    }
  }
}
