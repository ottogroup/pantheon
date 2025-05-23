variable "pantheon_service_principal" {
  description = "The email address of the Google service account"
  type        = string
}

variable "role" {
  description = "The role to be assigned to the service account"
  type        = string
  default     = "Security Reader"
}

variable "subscriptions" {
  description = "A list of subscription IDs to which the IAM binding should be applied"
  type        = list(string)
  default     = []
}

variable "resource_groups" {
  description = "A list of resource group names to which the IAM binding should be applied"
  type        = list(string)
  default     = []
}

variable "management_groups" {
  description = "A list of specific resource IDs to which the IAM binding should be applied"
  type        = list(string)
  default     = []
}