resource "aws_kms_key_policy" "example" {
  for_each = var.policies
  key_id   = var.key_id
  policy   = each.value["document"]
}
