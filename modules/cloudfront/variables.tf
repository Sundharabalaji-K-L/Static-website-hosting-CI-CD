variable "oac_name" {
    description = "oac name"
    type = string
    default = ""
}

variable "oac_desc" {
  description = "oac desc"
  type = string
  default = ""
}

variable "origins" {
    description = "map of origins"
    type = map(any)
    default = null
  
}

variable "type" {
  description = "origin access coontrol origin type"
  type = string
  default = ""
}

variable "domain_name" {
    description = "domain name"
    type = string
    default = ""
}

variable "certificate_arn" {
  description = "certificate arn"
  type = string
  default = ""
}
variable "aliases" {
  type = list(string)
  default = null
}