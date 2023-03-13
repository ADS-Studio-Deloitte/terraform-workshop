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

variable "queue_name_list" {
  description = "list of the queue names"
  type = list(string)
}

variable "topic_name" {
  description = "name of the topic for subscription"
  type = string
}