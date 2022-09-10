variable "region" {
  type        = string
  description = "aws region for the instance and lb"
}

variable "cidr_block" {
  type        = string
  description = "cidr block addess"
}

variable "lb_target_group" {
  type        = string
  description = "name of the target group"
}

variable "lb_name" {
  type        = string
  description = "name of the load balancer"
}

variable "ami" {
  type        = string
  description = "ami id for ec2 instance"
}

variable "type" {
  type        = string
  description = "ami instance type"
  sensitive   = true
}

variable "key" {
  type        = string
  description = "key for ec2 instance"
  sensitive   = true
}



