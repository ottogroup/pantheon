locals {
  is_folder_level = var.parent_resource_type == "folder"
  is_org_level    = var.parent_resource_type == "organization"
}

locals {
  ignore_principals = join("\n  ",
    concat(
      ["AND NOT protoPayload.authenticationInfo.principalEmail=\"${var.pantheon_service_account}\""],
  [for email in var.ignore_principal_emails : join("", ["AND NOT protoPayload.authenticationInfo.principalEmail=\"", email, "\""])]))
  filter = <<EOT
  logName:"/logs/cloudaudit.googleapis.com%2Factivity"
  AND NOT severity="ERROR"
  AND NOT protoPayload.response.@type="type.googleapis.com/error"
  AND NOT protoPayload.serviceData.@type="type.googleapis.com/google.appengine.legacy.AuditData"
  AND NOT protoPayload.response.@type="type.googleapis.com/operation"
  AND NOT protoPayload.response.@type="type.googleapis.com/google.cloud.sql.v1beta4.Operation"
  AND NOT protoPayload.response.@type="type.googleapis.com/google.cloud.sql.v1.Operation"
  AND NOT protoPayload.response.@type="type.googleapis.com/google.longrunning.Operation"
  AND NOT (protoPayload.methodName:("v1.compute.instanceGroups.addInstances" OR "v1.compute.instanceGroups.removeInstances" OR "v1.compute.instances.insert" OR "v1.compute.instances.delete") AND protoPayload.authenticationInfo.principalEmail=~".*@cloudservices.gserviceaccount.com")
  AND NOT protoPayload.methodName="cloudsql.instances.connect"
  AND NOT protoPayload.methodName="cloudsql.instances.restart"
  AND NOT protoPayload.methodName:"storage.objects"
  AND NOT protoPayload.methodName="beta.compute.sslCertificates.delete"
  AND NOT protoPayload.methodName:"google.cloud.bigquery.v2.JobService."
  AND NOT protoPayload.methodName:"google.cloud.ml.v1.JobService.CreateJob"
  AND NOT protoPayload.methodName="google.longrunning.Operations.GetOperation"
  AND NOT protoPayload.methodName="v1.compute.instances.detachDisk"
  AND NOT protoPayload.methodName="v1.compute.instances.attachDisk"
  AND NOT protoPayload.methodName:"google.datastore.admin.v1.DatastoreAdmin."
  AND NOT protoPayload.methodName="CheckInvitationRequired"
  AND NOT protoPayload.methodName:".compute.instanceGroupManagers."
  AND NOT protoPayload.methodName:"v1.compute.instanceGroups."
  AND NOT protoPayload.methodName:".compute.instanceTemplates."
  AND NOT protoPayload.methodName="tableservice.delete"
  AND NOT protoPayload.methodName="tableservice.insert"
  AND NOT protoPayload.methodName="tableservice.update"
  AND NOT protoPayload.methodName="datasetservice.delete"
  AND NOT protoPayload.methodName="datasetservice.insert"
  AND NOT protoPayload.methodName="datasetservice.update"
  AND NOT protoPayload.methodName:"InsertProjectOwnershipInvite"
  AND NOT protoPayload.serviceName="accessapproval.googleapis.com"
  AND NOT protoPayload.serviceName="bigquerybiengine.googleapis.com"
  AND NOT protoPayload.serviceName="bigqueryreservation.googleapis.com"
  AND NOT protoPayload.serviceName="billingbudgets.googleapis.com"
  AND NOT protoPayload.serviceName="clientauthconfig.googleapis.com"
  AND NOT protoPayload.serviceName="cloudbuild.googleapis.com"
  AND NOT protoPayload.serviceName="clouderrorreporting.googleapis.com"
  AND NOT protoPayload.serviceName="cloudidentity.googleapis.com"
  AND NOT protoPayload.serviceName="cloudprofiler.googleapis.com"
  AND NOT protoPayload.serviceName="cloudscheduler.googleapis.com"
  AND NOT protoPayload.serviceName="cloudshell.googleapis.com"
  AND NOT protoPayload.serviceName="cloudtrace.googleapis.com"
  AND NOT protoPayload.serviceName="containeranalysis.googleapis.com"
  AND NOT protoPayload.serviceName="datacatalog.googleapis.com"
  AND NOT protoPayload.serviceName="documentai.googleapis.com"
  AND NOT protoPayload.serviceName="iamcredentials.googleapis.com"
  AND NOT protoPayload.serviceName="k8s.io"
  AND NOT protoPayload.serviceName="language.googleapis.com"
  AND NOT protoPayload.serviceName="logging.googleapis.com"
  AND NOT protoPayload.serviceName="monitoring.googleapis.com"
  AND NOT protoPayload.serviceName="networkmanagement.googleapis.com"
  AND NOT protoPayload.serviceName="policytroubleshooter.googleapis.com"
  AND NOT protoPayload.serviceName="recommendationengine.googleapis.com"
  AND NOT protoPayload.serviceName="recommender.googleapis.com"
  AND NOT protoPayload.serviceName="remotebuildexecution.googleapis.com"
  AND NOT protoPayload.serviceName="servicecontrol.googleapis.com"
  AND NOT protoPayload.serviceName="servicedirectory.googleapis.com"
  AND NOT protoPayload.serviceName="serviceusage.googleapis.com"
  AND NOT protoPayload.serviceName="speech.googleapis.com"
  AND NOT protoPayload.serviceName="websecurityscanner.googleapis.com"
  AND NOT protoPayload.serviceName="admin.googleapis.com"
  AND NOT protoPayload.methodName:"google.cloud.aiplatform.internal."
  ${local.ignore_principals}
EOT
}

resource "random_id" "sink_name" {
  byte_length = 4
  prefix      = "pantheon-"
}

resource "google_logging_folder_sink" "this" {
  count            = local.is_folder_level ? 1 : 0
  destination      = var.destination_uri
  folder           = var.parent_resource_id
  name             = random_id.sink_name.hex
  filter           = local.filter
  include_children = true
}

resource "google_logging_organization_sink" "this" {
  count            = local.is_org_level ? 1 : 0
  destination      = var.destination_uri
  org_id           = var.parent_resource_id
  name             = random_id.sink_name.hex
  filter           = local.filter
  include_children = true
}
