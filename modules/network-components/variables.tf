variable "prefix" {
    description = "project name"
    type = string
    default = ""
  
}

variable "vpc_name" {
    description = "vpc name"
    type = string
    default = ""
}

variable "vpc_cidr" {
    description = "vpc cidr block"
    type = string
    default = ""
}

variable "azs" {
    description = "azs"
    type = list(string)
    default = null
}

variable "ig_name" {
    description = "internet gateway name"
    type = string
    default = ""
}

variable "public_subnets_cidrs" {
    description = "public cidr blocks"
    type = list(string)
    default = null
}

variable "public_route_table_name" {
  description = "public route table name"
  type = string
  default = ""
}

variable "private_subnets_cidrs" {
    description = "private cidr blocks"
    type = list(string)
    default = null
}

variable "nat_name" {
    default = "nat gateway name"
    type = string
    description = ""
}

variable "private_route_table_name" {
    description = "private route table name"
    type = string
    default = ""
}

variable "public_acl_name" {
  description = "public subnet acl name"
  type = string
  default = ""
}

variable "private_acl_name" {
    description = "private subnet acl name"
    type = string
    default = ""
}