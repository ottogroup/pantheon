
variable "pantheon_role_name" {
  type        = string
  description = "AWS IAM Role name"
}

variable "pantheon_service_account_id" {
  type        = number
  description = "GSP service account id used to scan resources. Will be provided by the team."
}
