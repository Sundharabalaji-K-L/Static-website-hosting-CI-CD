variable "policies" {
    description = "kms key policies"
    type = map(any)
    default = null
}

variable "key_id" {
    description = "kms key id"
    type = string
    default = null
}

