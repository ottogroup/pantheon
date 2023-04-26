locals {
  gcp_federation = {
    Version = "2012-10-17"
    // federation part
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "accounts.google.com"
        }
        Action = [
          "sts:AssumeRoleWithWebIdentity",
        ]
        Condition = {
          "StringEquals" : {
            "accounts.google.com:sub"  = tostring(var.pantheon_service_account_id),
            "accounts.google.com:oaud" = "http://aws.skunk.team"
          }
          Null = {
            "accounts.google.com:sub"  = "false"
            "accounts.google.com:oaud" = "false"
          }
        }
      }
    ]
  }
}

// policy federation
// see: https://gist.github.com/wvanderdeijl/c6a9a9f26149cea86039b3608e3556c1
resource "aws_iam_role" "gcp_federation" {
  name               = var.pantheon_role_name
  path               = "/"
  description        = "Allow Pantheon to scan resources in AWS"
  assume_role_policy = jsonencode(local.gcp_federation)
}
data "aws_iam_policy" "SecurityAudit" {
  name = "SecurityAudit"
}
resource "aws_iam_role_policy_attachment" "attach_SecurityAudit_to_gcp_federation" {
  role       = aws_iam_role.gcp_federation.name
  policy_arn = data.aws_iam_policy.SecurityAudit.arn
}
data "aws_iam_policy" "ViewOnlyAccess" {
  name = "ViewOnlyAccess"
}
resource "aws_iam_policy_attachment" "attach_ViewOnlyAccess_to_gcp_federation" {
  policy_arn = data.aws_iam_policy.ViewOnlyAccess.arn
  name       = "pantheon-has-view-only-access"
  roles      = [aws_iam_role.gcp_federation.name]
}
locals {
  pantheon_full_policy_document = jsondecode(file("${path.module}/cloud-formation/Stackset-Pantheon-Role-AWSLinkedAccounts.json"))["Resources"]["PantheonFullPolicy"]["Properties"]["PolicyDocument"]
  pantheon_full_policy_document_with_deny_actions = length(var.pantheon_full_access_policy_deny_actions) > 0 ? {
    Statement : concat(
      local.pantheon_full_policy_document["Statement"],
      [
        {
          Action : var.pantheon_full_access_policy_deny_actions,
          Effect : "Deny",
          Resource : "*"
        }
      ]
    )
    Version : local.pantheon_full_policy_document["Version"]
  } : local.pantheon_full_policy_document
}

resource "aws_iam_policy" "pantheon_full_policy" {
  name   = var.pantheon_full_access_policy_name
  path   = "/"
  policy = jsonencode(local.pantheon_full_policy_document_with_deny_actions)
}
resource "aws_iam_policy_attachment" "attach_PantheonFullPolicy_to_gcp_federation" {
  policy_arn = aws_iam_policy.pantheon_full_policy.arn
  name       = "pantheon-has-full-access"
  roles      = [aws_iam_role.gcp_federation.name]
}