variable "sg_name" {
  description = "security group name"
  type = string
   default = ""
}

variable "vpc_id" {
    description = "vpc_id"
    type = string
    default = null
}

variable "ingress_rules" {
  description = "ingess rules for security group"
  type = map(any)
  default = null
}

