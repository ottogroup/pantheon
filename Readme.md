## Pantheon terraform modules

This repository contains the following terraform modules 


## Google Cloud Platform

- gcp-log-export: Provides log-export on folder or organization level
- gcp-org: Provides resources on organization level, e.g. custom roles
- gcp-permission: Provides IAM bindings on folder or organization level


### Example 

### Module `gcp-log-export` usage
On folder level

```bash
module "pantheon_gcp_folder_log_export" {
    source = "github.com/ottogroup/pantheon//terraform/modules/gcp-log-export?ref=v1.0.1"
    destination_uri = "projects/<PROJECT_ID>/topics/<TOPIC_NAME>"
    parent_resource_type = "folder"
    parent_resource_id = "folder/123456789"
}
```

On organization level
```bash
module "pantheon_gcp_org_log_export" {
    source = "github.com/ottogroup/pantheon//terraform/modules/gcp-log-export?ref=v1.0.1"
    destination_uri = "projects/<PROJECT_ID>/topics/<TOPIC_NAME>"
    parent_resource_type = "organization"
    parent_resource_id = "organization/123456789"
}
```

### Module `gcp-org` usage

```bash
module "pantheon_gcp_org" {
    source = "github.com/ottogroup/pantheon//terraform/modules/gcp-org?ref=v1.0.1"
    org_id = "123456789"
}
```

### Module `gcp-permission` usage

On folder level

```bash
module "pantheon_gcp_permission" {
    source = "github.com/ottogroup/pantheon//terraform/modules/gcp-permission?ref=v1.0.1"
    pantheon_engine_role_id = pantheon_gcp_org.output.pantheon_engine_role_id
    folder_ids = ["folder/123456789", "folder/987654321"]
    pantheon_service_account = "<SA_NAME>@<PROJECT_ID>.iam.gserviceaccount.com"
}
```

On org level

```bash
module "pantheon_gcp_permission" {
    source = "github.com/ottogroup/pantheon//terraform/modules/gcp-permission?ref=v1.0.1"
    pantheon_engine_role_id = module.pantheon_gcp_org.pantheon_engine_role_id
    org_id = "123456789"
    pantheon_service_account = "<SA_NAME>@<PROJECT_ID>.iam.gserviceaccount.com"
}
```


## Versioning

This repo uses [SemVer](http://semver.org/) based git tags for versioning which can be used to select terraform module revision [1].

### Links

- https://www.terraform.io/language/modules/sources#selecting-a-revision
