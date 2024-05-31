variable "s3_names" {
    description = "bucket names"
    type = list(string)
    default = null
  
}

variable "fileset_path" {
    description = "path to the folder need to be uploaded"
    type = string
    default = ""

}

variable "cloudfront_arn" {
    description = "cloudfront arn"
    type = string
    default = ""
  
}

variable "kms_key_arn" {
  description = "kms-key arn"
  type = string
  default = null
}

