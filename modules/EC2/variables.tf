variable "ami" {
  description = "ami id"
  type = string
  default = ""
}

variable "subnet_id" {
    description = "subnet id"
    type = string
    default = null
  
}

variable "volume" {
  description = "storage volume size"
  type = string
  default = ""
}

variable "user_data" {
  description = "path to script.sh"
  type = string
  default = ""
}

variable "instance_name" {
  description = "instance name"
  type = string
  default = ""
}

variable "instance_type" {
  description = "instance type"
  type = string
  default = ""
}

variable "security_group_id" {
  description = "security group id"
  type = string
  default = null
}

variable "key_name" {
  description = "ssh key name"
  type = string
  default = ""
}

variable "iam_role" {
  description = "iam role name"
  type = string
  default = ""
}

variable "profile_name" {
  description = "iam instance profile name"
  type = string
  default = ""
}
