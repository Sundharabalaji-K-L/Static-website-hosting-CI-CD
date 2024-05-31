variable "policies" {
  description = "map of Iam policies"
  type = map(any)
  default = null
}

variable "iam_role" {
    description = "iam role name"
    default = ""
    type = string
}

