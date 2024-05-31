variable "role_name" {
  description = "Name for the IAM role"
  type        = string
  default = ""
}

variable "assume_role_policy" {
  description = "Assume role policy document"
  type = string
  default = ""
}