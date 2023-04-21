## Pantheon terraform modules

This repository contains the following terraform modules 


## Amazon Web Services (AWS)

- aws-policies: Provides required access policies

### Module `aws-policies` usage


```bash
module "pantheon_access_policies" {
    source                      = "github.com/ottogroup/pantheon//terraform/modules/aws-policies?ref=v1.1.4"
    pantheon_service_account_id = "100020003000400050006"
    pantheon_role_name          = "pantheon-security-audit"
}
```

## Google Cloud Platform

- gcp-log-export: Provides log-export on folder or organization level
- gcp-org: Provides resources on organization level, e.g. custom roles
- gcp-permission: Provides IAM bindings on folder or organization level
- gcp-billing: Provides IAM bindings for the billing account


### Example 

### Module `gcp-log-export` usage
On folder level

```bash
module "pantheon_gcp_folder_log_export" {
    source = "github.com/ottogroup/pantheon//terraform/modules/gcp-log-export?ref=v1.0.3"
    destination_uri = "pubsub.googleapis.com/projects/<PROJECT_ID>/topics/<TOPIC_NAME>"
    parent_resource_type = "folder"
    parent_resource_id = "123456789"
}
```

On organization level
```bash
module "pantheon_gcp_org_log_export" {
    source = "github.com/ottogroup/pantheon//terraform/modules/gcp-log-export?ref=v1.0.3"
    destination_uri = "pubsub.googleapis.com/projects/<PROJECT_ID>/topics/<TOPIC_NAME>"
    parent_resource_type = "organization"
    parent_resource_id = "123456789"
}
```

### Module `gcp-org` usage

```bash
module "pantheon_gcp_org" {
    source = "github.com/ottogroup/pantheon//terraform/modules/gcp-org?ref=v1.0.3"
    org_id = "123456789"
}
```

### Module `gcp-permission` usage

On folder level

```bash
module "pantheon_gcp_permission" {
    source = "github.com/ottogroup/pantheon//terraform/modules/gcp-permission?ref=v1.0.3"
    pantheon_engine_role_id = module.pantheon_gcp_org.output.pantheon_engine_role_id
    folder_ids = ["123456789", "987654321"]
    pantheon_service_account = "<SA_NAME>@<PROJECT_ID>.iam.gserviceaccount.com"
}
```

On org level

```bash
module "pantheon_gcp_permission" {
    source = "github.com/ottogroup/pantheon//terraform/modules/gcp-permission?ref=v1.0.3"
    pantheon_engine_role_id = module.pantheon_gcp_org.pantheon_engine_role_id
    org_id = "123456789"
    pantheon_service_account = "<SA_NAME>@<PROJECT_ID>.iam.gserviceaccount.com"
}
```

### Module `gcp-billing` usage

```bash
module "pantheon_gcp_billing" {
    source = "github.com/ottogroup/pantheon//terraform/modules/gcp-billing?ref=v1.0.3"
    billing_account_id = "00AA00-000AAA-00AA0A"
    pantheon_service_account = "<SA_NAME>@<PROJECT_ID>.iam.gserviceaccount.com"
}
```

## Versioning

This repo uses [SemVer](http://semver.org/) based git tags for versioning which can be used to select terraform module revision [1].

### Links

- https://www.terraform.io/language/modules/sources#selecting-a-revision
- Docs generated with: https://github.com/terraform-docs/terraform-docs
