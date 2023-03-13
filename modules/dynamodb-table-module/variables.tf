variable "dynamodb_lock_table_enabled" {
  default = true
}

variable "environment" {
}
variable "region" {
}

variable "tags" {
}

variable "resource" {}

variable "project" {}

variable "special_name" {
  description = "unique prefix for dynamo table"
}

