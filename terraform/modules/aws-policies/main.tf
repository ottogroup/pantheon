locals {
  cf-document = jsondecode(file("${path.module}/cloud-formation/Stackset-Pantheon-Role-AWSLinkedAccounts.json"))

}
data "aws_iam_policy_document" "federation" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]
    condition {
      test     = "StringEquals"
      variable = "accounts.google.com:sub"
      values = [
        tostring(var.pantheon_service_account_id)
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "accounts.google.com:oaud"
      values = [
        local.cf-document["Resources"]["Role"]["Properties"]["AssumeRolePolicyDocument"]["Statement"][0]["Condition"]["StringEquals"]["accounts.google.com:oaud"]
      ]
    }
    principals {
      type        = "Federated"
      identifiers = ["accounts.google.com"]
    }
  }
}

// policy federation
// see: https://gist.github.com/wvanderdeijl/c6a9a9f26149cea86039b3608e3556c1
resource "aws_iam_role" "gcp_federation" {
  name               = var.pantheon_role_name
  path               = "/"
  description        = "Allow Pantheon to scan resources in AWS"
  assume_role_policy = data.aws_iam_policy_document.federation.json
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
resource "aws_iam_role_policy_attachment" "attach_ViewOnlyAccess_to_gcp_federation" {
  role      = aws_iam_role.gcp_federation.name
  policy_arn = data.aws_iam_policy.ViewOnlyAccess.arn
}

data "aws_iam_policy_document" "override" {
  statement {
    effect    = "Deny"
    actions   = var.pantheon_full_access_policy_deny_actions
    resources = ["*"]
  }
}

locals {
  // 1
  pantheon_full_policy_document = local.cf-document["Resources"]["PantheonFullPolicy0"]["Properties"]["PolicyDocument"]
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
  // 2
  pantheon_full_policy2_document = local.cf-document["Resources"]["PantheonFullPolicy1"]["Properties"]["PolicyDocument"]
  pantheon_full_policy2_document_with_deny_actions = length(var.pantheon_full_access_policy_deny_actions) > 0 ? {
    Statement : concat(
      local.pantheon_full_policy2_document["Statement"],
      [
        {
          Action : var.pantheon_full_access_policy_deny_actions,
          Effect : "Deny",
          Resource : "*"
        }
      ]
    )
    Version : local.pantheon_full_policy2_document["Version"]
  } : local.pantheon_full_policy2_document
  // 3
  pantheon_full_policy3_document = local.cf-document["Resources"]["PantheonFullPolicy2"]["Properties"]["PolicyDocument"]
  pantheon_full_policy3_document_with_deny_actions = length(var.pantheon_full_access_policy_deny_actions) > 0 ? {
    Statement : concat(
      local.pantheon_full_policy3_document["Statement"],
      [
        {
          Action : var.pantheon_full_access_policy_deny_actions,
          Effect : "Deny",
          Resource : "*"
        }
      ]
    )
    Version : local.pantheon_full_policy3_document["Version"]
  } : local.pantheon_full_policy3_document
}
// 1
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
// 2
resource "aws_iam_policy" "pantheon_full_policy2" {
  name   = "${var.pantheon_full_access_policy_name}2"
  path   = "/"
  policy = jsonencode(local.pantheon_full_policy2_document_with_deny_actions)
}
resource "aws_iam_policy_attachment" "attach_PantheonFullPolicy2_to_gcp_federation" {
  policy_arn = aws_iam_policy.pantheon_full_policy2.arn
  name       = "pantheon-has-full-access-2"
  roles      = [aws_iam_role.gcp_federation.name]
}
// 3
resource "aws_iam_policy" "pantheon_full_policy3" {
  name   = "${var.pantheon_full_access_policy_name}3"
  path   = "/"
  policy = jsonencode(local.pantheon_full_policy3_document_with_deny_actions)
}
resource "aws_iam_policy_attachment" "attach_PantheonFullPolicy3_to_gcp_federation" {
  policy_arn = aws_iam_policy.pantheon_full_policy3.arn
  name       = "pantheon-has-full-access-3"
  roles      = [aws_iam_role.gcp_federation.name]
}