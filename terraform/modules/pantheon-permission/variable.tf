variable "org_id" {
  type        = string
  description = "The ID of the organization that owns the resources that you want to scan."
}

variable "folder_id" {
  type        = string
  default     = null
  description = "Optional: The ID of a folder you want to attach the permissions to. Per default, the permissions will be granted on the org level."
}

variable "pantheon_service_account" {
  type        = string
  description = "The service account used to scan resources. Will be provided by the team."
}
