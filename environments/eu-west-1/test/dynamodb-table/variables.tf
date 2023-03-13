variable "project" {
  type = string
}
variable "environment" {
  type = string
}
variable "region" {
  type = string
}

variable "profile" {
  type = string
}

variable "resource" {
  type = string
}

variable "tags" {
}

variable "table_name" {
  description = "name of the dynamoDB table"
  type = string
}

