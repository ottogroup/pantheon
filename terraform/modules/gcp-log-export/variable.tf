variable "parent_resource_type" {
  type        = string
  description = "Either 'folder' or 'organization'. Needs to be set by user."
}

variable "parent_resource_id" {
  type        = string
  description = "The folder resp. organization number, e.g. 123456789. Needs to be set by user."
}

variable "destination_uri" {
  type        = string
  description = "The full qualified destination URI of the PubSub topic the logging sink should write to in the form 'pubsub.googleapis.com/projects/<PROJECT_ID>/topics/<TOPIC_NAME>'. Will be provided by the team."
}

variable "pantheon_service_account" {
  type        = string
  description = "The service account used to scan resources. Will be provided by the team."
}
