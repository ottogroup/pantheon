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
  role       = aws_iam_role.gcp_federation.name
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
  pantheon_full_policy = {
    Statement : local.pantheon_full_policy_document["Statement"]
    Version : local.pantheon_full_policy_document["Version"]
  }
  // 2
  pantheon_full_policy2_document = local.cf-document["Resources"]["PantheonFullPolicy1"]["Properties"]["PolicyDocument"]
  pantheon_full_policy2 = {
    Statement : local.pantheon_full_policy2_document["Statement"]
    Version : local.pantheon_full_policy2_document["Version"]
  }
  // 3
  pantheon_full_policy3_document = local.cf-document["Resources"]["PantheonFullPolicy2"]["Properties"]["PolicyDocument"]
  pantheon_full_policy3 = {
    Statement : local.pantheon_full_policy3_document["Statement"]
    Version : local.pantheon_full_policy3_document["Version"]
  }
  // 4
  pantheon_full_policy4_document = local.cf-document["Resources"]["PantheonFullPolicy3"]["Properties"]["PolicyDocument"]
  pantheon_full_policy4 = {
    Statement : local.pantheon_full_policy4_document["Statement"]
    Version : local.pantheon_full_policy4_document["Version"]
  }
  // 5
  pantheon_full_policy5_document = local.cf-document["Resources"]["PantheonFullPolicy4"]["Properties"]["PolicyDocument"]
  pantheon_full_policy5 = {
    Statement : local.pantheon_full_policy5_document["Statement"]
    Version : local.pantheon_full_policy5_document["Version"]
  }
  // deny actions
  pantheon_deny_actions1 = {
    Statement : [
      {
        Action : var.pantheon_full_access_policy_deny_actions
        Effect : "Deny"
        Resource : "*"
      }
    ]
    Version : local.pantheon_full_policy3_document["Version"]
  }
}
// 1
resource "aws_iam_policy" "pantheon_full_policy" {
  name   = var.pantheon_full_access_policy_name
  path   = "/"
  policy = jsonencode(local.pantheon_full_policy)
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
  policy = jsonencode(local.pantheon_full_policy2)
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
  policy = jsonencode(local.pantheon_full_policy3)
}
resource "aws_iam_policy_attachment" "attach_PantheonFullPolicy3_to_gcp_federation" {
  policy_arn = aws_iam_policy.pantheon_full_policy3.arn
  name       = "pantheon-has-full-access-3"
  roles      = [aws_iam_role.gcp_federation.name]
}
// 4
resource "aws_iam_policy" "pantheon_full_policy4" {
  name   = "${var.pantheon_full_access_policy_name}4"
  path   = "/"
  policy = jsonencode(local.pantheon_full_policy4)
}
resource "aws_iam_policy_attachment" "attach_PantheonFullPolicy4_to_gcp_federation" {
  policy_arn = aws_iam_policy.pantheon_full_policy4.arn
  name       = "pantheon-has-full-access-4"
  roles      = [aws_iam_role.gcp_federation.name]
}
// 5
resource "aws_iam_policy" "pantheon_full_policy5" {
  name   = "${var.pantheon_full_access_policy_name}5"
  path   = "/"
  policy = jsonencode(local.pantheon_full_policy5)
}
resource "aws_iam_policy_attachment" "attach_PantheonFullPolicy5_to_gcp_federation" {
  policy_arn = aws_iam_policy.pantheon_full_policy5.arn
  name       = "pantheon-has-full-access-5"
  roles      = [aws_iam_role.gcp_federation.name]
}
// deny actions
resource "aws_iam_policy" "pantheon_deny_policy1" {
  count  = length(var.pantheon_full_access_policy_deny_actions) > 0 ? 1 : 0
  name   = "${var.pantheon_full_access_policy_name}DenyActions1"
  path   = "/"
  policy = jsonencode(local.pantheon_deny_actions1)
}
resource "aws_iam_policy_attachment" "attach_PantheonDenyActionsPolicy1_to_gcp_federation" {
  count      = length(var.pantheon_full_access_policy_deny_actions) > 0 ? 1 : 0
  policy_arn = aws_iam_policy.pantheon_deny_policy1[0].arn
  name       = "pantheon-has-not-full-access-on-1"
  roles      = [aws_iam_role.gcp_federation.name]
}