resource "aws_iam_policy" "custom_iam_policy" {
  for_each = var.policies

  name        = each.key
  description = each.value["description"]
  policy      = each.value["document"]
}

resource "aws_iam_policy_attachment" "custom_policy_attachment" {
  for_each = var.policies

  name       = each.key
  roles      = [var.iam_role]  # Assuming you have an IAM role named jenkins_s3_role
  policy_arn = aws_iam_policy.custom_iam_policy[each.key].arn
}