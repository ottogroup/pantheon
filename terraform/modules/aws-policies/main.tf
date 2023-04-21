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
  roles = [aws_iam_role.gcp_federation.name]
}
