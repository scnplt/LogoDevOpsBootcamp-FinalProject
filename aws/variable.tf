variable "region" {}

variable "task_execution_role_name" {}

variable "container_port" {}

variable "image_url" {
  sensitive = true
}

variable "account_id" {
  sensitive = true
}
