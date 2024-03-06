
variable "instance_type" {
  type        = string
}


variable "public_subnets" {
  type        = list(string)
}

variable "private_subnets" {
  type        = list(string)
}

variable "security_group_ids" {
  type        = list(string)
}

variable "lighting_ami" {
  type = string
}

variable "heating_ami" {
  type = string
}

variable "auth_ami" {
  type = string
}

variable "status_ami" {
  type = string
}

variable "key_name" {
  type = string
}