## Pantheon gcp-log-export terraform module

Provides resources to setup a logging sink on folder or organization level to a destination URI. 

This module is mandatory.

## Note

This module is a stripped down version of the [official log-export module](https://github.com/terraform-google-modules/terraform-google-log-export).

The main difference is that this version skips functionality which are not necessary in the Pantheon
context. Moreover, it provides a hard-coded filter expression that is required with Pantheon on the receiving side.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_logging_folder_sink.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_folder_sink) | resource |
| [google_logging_organization_sink.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_organization_sink) | resource |
| [random_id.sink_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_destination_uri"></a> [destination\_uri](#input\_destination\_uri) | The full qualified destination URI of the PubSub topic the logging sink should write to in the form 'pubsub.googleapis.com/projects/<PROJECT\_ID>/topics/<TOPIC\_NAME>'. Will be provided by the team. | `string` | n/a | yes |
| <a name="input_parent_resource_id"></a> [parent\_resource\_id](#input\_parent\_resource\_id) | The folder resp. organization number, e.g. 123456789. Needs to be set by user. | `string` | n/a | yes |
| <a name="input_parent_resource_type"></a> [parent\_resource\_type](#input\_parent\_resource\_type) | Either 'folder' or 'organization'. Needs to be set by user. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_writer_identity"></a> [writer\_identity](#output\_writer\_identity) | The generated service account used to write to the destination URI. It is in the form 'serviceAccount:o<org-id>-<random number>@gcp-sa-logging.iam.gserviceaccount.com' or 'serviceAccount:f<folder id>-<random number>@gcp-sa-logging.iam.gserviceaccount.com'. |