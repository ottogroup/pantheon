variable "org_id" {
  type        = string
  default     = null
  description = "The ID of the organization that owns the resources that you want to scan. Needs to be set by user."
}

variable "folder_ids" {
  type        = list(string)
  default     = []
  description = "Optional: The ID of a folder you want to attach the permissions to. Per default, the permissions will be granted on the org level. The format for each element is folders/{folder_id}. Needs to be set by user."
}

variable "pantheon_engine_role_id" {
  type        = string
  description = "The ID of org level custom role of Pantheon Engine. Will be provided by output of gcp-org module."
}

variable "pantheon_service_account" {
  type        = string
  description = "The service account used to scan resources. Will be provided by the team."
}

variable "pantheon_gcp_roles" {
  type        = list(string)
  default     = null
  description = "The roles that will be applied to all folders or the organization. The default are the recommended roles."
}
