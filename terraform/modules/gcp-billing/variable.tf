variable "billing_account_id" {
  type        = string
  default     = null
  description = "The ID of the billing account that is attached to the resources been scanned."
}

variable "pantheon_service_account" {
  type        = string
  description = "The service account used to scan resources. Will be provided by the team."
}
