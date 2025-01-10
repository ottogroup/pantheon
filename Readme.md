## Pantheon terraform modules

This repository contains the following terraform modules 


## Amazon Web Services (AWS)

- aws-policies: Provides required access policies

### Module `aws-policies` usage


```bash
module "pantheon_access_policies" {
    source                      = "github.com/ottogroup/pantheon//terraform/modules/aws-policies?ref=v1.1.26"
    pantheon_service_account_id = "100020003000400050006"
    pantheon_role_name          = "pantheon-audit-access"
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
  source                   = "github.com/ottogroup/pantheon//terraform/modules/gcp-log-export?ref=v1.1.26"
  destination_uri          = "pubsub.googleapis.com/projects/<PROJECT_ID>/topics/<TOPIC_NAME>"
  parent_resource_type     = "folder"
  parent_resource_id       = "123456789"
  pantheon_service_account = "<SA_NAME>@<PROJECT_ID>.iam.gserviceaccount.com"
}
```

On organization level
```bash
module "pantheon_gcp_org_log_export" {
  source                   = "github.com/ottogroup/pantheon//terraform/modules/gcp-log-export?ref=v1.1.26"
  destination_uri          = "pubsub.googleapis.com/projects/<PROJECT_ID>/topics/<TOPIC_NAME>"
  parent_resource_type     = "organization"
  parent_resource_id       = "123456789"
  pantheon_service_account = "<SA_NAME>@<PROJECT_ID>.iam.gserviceaccount.com"
}
```

### Module `gcp-org` usage

```bash
module "pantheon_gcp_org" {
    source = "github.com/ottogroup/pantheon//terraform/modules/gcp-org?ref=v1.1.26"
    org_id = "123456789"
}
```

### Module `gcp-permission` usage

On folder level

```bash
module "pantheon_gcp_permission" {
  source                   = "github.com/ottogroup/pantheon//terraform/modules/gcp-permission?ref=v1.1.26"
  pantheon_engine_role_id  = module.pantheon_gcp_org.output.pantheon_engine_role_id
  folder_ids = ["123456789", "987654321"]
  pantheon_service_account = "<SA_NAME>@<PROJECT_ID>.iam.gserviceaccount.com"
}
```

On org level

```bash
module "pantheon_gcp_permission" {
  source                   = "github.com/ottogroup/pantheon//terraform/modules/gcp-permission?ref=v1.1.20"
  pantheon_engine_role_id  = module.pantheon_gcp_org.pantheon_engine_role_id
  org_id                   = "123456789"
  pantheon_service_account = "<SA_NAME>@<PROJECT_ID>.iam.gserviceaccount.com"
}
```

### Module `gcp-billing` usage

```bash
module "pantheon_gcp_billing" {
  source                   = "github.com/ottogroup/pantheon//terraform/modules/gcp-billing?ref=v1.1.26"
  billing_account_id       = "00AA00-000AAA-00AA0A"
  pantheon_service_account = "<SA_NAME>@<PROJECT_ID>.iam.gserviceaccount.com"
}
```

## Kubernetes

- kubernetes-scanner: Deploy kubernetes scanner agent

### Terraform module `kubernetes-scanner` usage

```bash
module "pantheon_kubernetes_scanner" {
  source                                            = "github.com/ottogroup/pantheon//terraform/modules/kubernetes-scanner?ref=v1.1.26"
  pantheon_kubernetes_scanner_image                 = "docker image url"
  pantheon_kubernetes_cluster_asset_class           = "The asset class of the cluster"
  pantheon_kubernetes_cluster_canonical_asset_type  = "The canonical asset type of the cluster"
  pantheon_kubernetes_cluster_canonical_resource_id = "The canonical resource id of the cluster"
  pantheon_kubernetes_cluster_service_id            = "The service id cluster"
  pantheon_kubernetes_sink_message_broker           = "The sink message broker"
}
```

### kustomize usage

dev.env
```bash
PANTHEON_CLUSTER_ASSET_CLASS="The asset class of the cluster"
PANTHEON_CLUSTER_SERVICE_ID="The service id cluster"
PANTHEON_CLUSTER_CANONICAL_ASSET_TYPE="The canonical asset type of the cluster"
PANTHEON_CLUSTER_CANONICAL_RESOURCE_ID= "The canonical resource id of the cluster"
PANTHEON_SINK_MESSAGE_BROKER="The sink message broker"
```

kustomization.yaml
```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

generatorOptions:
  disableNameSuffixHash: true

configMapGenerator:
  - name: pantheon-scanner-cm
    namespace: pantheon-scanner
    envs:
      - dev.env

resources:
  - https://github.com/ottogroup/pantheon//kubernetes/base/?timeout=120&ref=main
```

If you want to disable the ingestion of a asset type, you can add the following a comma seperated list of ignored resource with schema "<service>/<version>/<method>", e.g.:
```bash
IGNORED_RESOURCES="networking.k8s.io/v1/ingresses,/v1/secrets"
```
**Note:** the service core is in kubernetes a empty string.

## Versioning

This repo uses [SemVer](http://semver.org/) based git tags for versioning which can be used to select terraform module revision [1].

### Links

- https://www.terraform.io/language/modules/sources#selecting-a-revision
- Docs generated with: https://github.com/terraform-docs/terraform-docs
