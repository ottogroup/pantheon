variable "organization_id" {
  description = "The ID of the organization."
  type        = string
}

variable "oneoguard_engine_email" {
  description = "The email of the engine service account."
  type        = string
}

variable "role_name" {
  description = "The name of the custom role."
  type        = string
  default     = "oneoguard-full-access"
}

variable "denied_permission" {
  description = "The permission that should be denied. Per default all security relevant read permissions are allowed."
  type        = list(string)
  default     = []
}
