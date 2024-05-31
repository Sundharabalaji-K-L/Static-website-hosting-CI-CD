variable "secret_name" {
  description = "secret name"
  type = string 
}

variable "secret_string" {
  description = "secrets value need to be stored"
  type = string
}

variable "tags" {
  description = "map of tag key and value"
  type = map(any)
}

variable "description" {
  description = "description about the secret"
  type = string
}