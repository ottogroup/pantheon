variable "pantheon_service_principal" {
  description = "The email address of the Google service account"
  type        = string
}

variable "role" {
  description = "The role to be assigned to the service account"
  type        = string
  default     = "Security Reader"
}