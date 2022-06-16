variable "project_name" {
}

variable "project_environment" {
}

variable "bucket_name" {
}

variable "allow_unauthenticated_identities" {
  type = bool
  default = true
}

variable "allow_classic_flow" {
  type = bool
  default = false
}
