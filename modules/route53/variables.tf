variable "domain_name" {
  description = "domain name"
  type = string
  default = ""
}

variable "cloudfront_domain_name" {
  description = "cloudfront domain name"
  type = string
  default = ""
}

variable "cloudfront_zone_id" {
  description = "cloudfront zone id"
  type = string
  default = ""
}

variable "acm_cname" {
  description = "acm cname record"
  type = string
  default = ""
}

variable "certificate_arn" {
  description = "acm certificate arn"
  type = string
  default = ""
  
}


variable "resource_record_value" {
  description = "resource record value"
  type = list(string)
  default = null
  
}

variable "resource_record_name" {
  description = "resource record name"
  type = string
  default = null
  
}

variable "resource_record_type" {
  description = "resource record type"
  type = string
  default = null
}

