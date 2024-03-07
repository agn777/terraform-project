variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "req_size" {
  type = number
}

variable "availability_zones" {
  type = list(string)
}

variable "instance_type" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "lb_target_group_arns" {
  type        = map(string)
}

variable "key_name" {
  type = string
}

variable "services" {
  description = "A list of services"
  type = map(object({
    name                        = string
    ami                         = string
    subnet_id                   = string
    associate_public_ip_address = bool
    target_group_arn            = string
  }))
}
