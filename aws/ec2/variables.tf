variable "vpc_name" {}

variable "vpc_cidr_block" {}

variable "public_port" {}

variable "container_port" {}

variable "target_group_name" {}

variable "lb_name" {}

variable "subnet_confs" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
  }))
}