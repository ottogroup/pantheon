variable "pantheon_role_name" {
  type        = string
  description = "AWS IAM Role name"
}

variable "pantheon_full_access_policy_name" {
  type        = string
  description = "AWS IAM Policy name"
  default     = "PantheonFullPolicy"
}

variable "pantheon_full_access_policy_deny_actions" {
  type        = list(string)
  description = "Deny actions for PantheonFullPolicy"
  default     = []
}

variable "pantheon_service_account_id" {
  type        = number
  description = "GCP service account id used to scan resources. Will be given by the Pantheon provider."
}
