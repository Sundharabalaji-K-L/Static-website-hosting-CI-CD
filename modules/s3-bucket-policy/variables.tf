variable "bucket_name" {
    description = "bucket name"
    type = string
    default = ""
  
}

variable "policies" {
  description = "map of bucket policies"
  type = string
  default = ""
}
