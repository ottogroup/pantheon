variable "name" {
  type        = string
  default     = "Pantheon Directory Reader"
  description = "The name of the role."
}

variable "pantheon_service_accounts" {
  type        = map(number)
  description = "Role assignments for pantheon service accounts in google workspace need GSA unique ID. Format email: GSA unique ID"
}
