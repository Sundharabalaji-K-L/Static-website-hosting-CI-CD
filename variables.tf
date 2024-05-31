variable "prefix" {
  description = "project name"
  type        = string
}

variable "vpc_cidr" {
  description = "vpc cidr block"
  type        = string
}

variable "azs" {
  description = "azs"
  type        = list(string)
}


variable "public_subnets_cidrs" {
  description = "public cidr blocks"
  type        = list(string)
}

variable "private_subnets_cidrs" {
  description = "private cidr blocks"
  type        = list(string)
}

variable "ami" {
  description = "ami id"
  type        = string
}

variable "volume" {
  description = "storage volume size"
  type        = string
}


variable "instance_type" {
  description = "instance type"
  type        = string
}

variable "s3_names" {
  description = "bucket names"
  type        = list(string)
  default     = null

}

variable "domain_name" {
  description = "domain name"
  type        = string
}

variable "aws_region" {
  description = "aws region"
  type        = string
}

variable "tf_token" {
  description = "Token for accessing Terraform Cloud or Terraform Enterprise"
  type        = string
}

variable "tf_app_pass" {
  description = "app-password for gmail"
  type        = string
}

