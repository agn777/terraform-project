variable "public_subnets" {
  type        = list(string)
  # CIDR ranges
}

variable "private_subnets" {
  type        = list(string)
  # CIDR ranges
}

variable "availability_zones" {
  type        = list(string)
}

variable "hash_key" {
  type = string
}

variable "instance_type" {
  type        = string
}

variable "hash_key_type" {
  type = string
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

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "req_size" {
  type = number
}

locals {
  services = {
    heating = {
      name             = "Heating"
      ami              = var.heating_ami
      subnet_id        = module.vpc.public_subnets[0]
      target_group_arn = module.load_balancing.heating_target_group_arn
      associate_public_ip_address = true
    },
    lighting = {
      name             = "Lighting"
      ami              = var.lighting_ami
      subnet_id        = module.vpc.public_subnets[1]
      target_group_arn = module.load_balancing.lighting_target_group_arn
      associate_public_ip_address = true
    },
    status = {
      name             = "Status"
      ami              = var.status_ami
      subnet_id        = module.vpc.public_subnets[2]
      target_group_arn = module.load_balancing.status_target_group_arn
      associate_public_ip_address = true
    },
    auth = {
      name             = "Auth"
      ami              = var.auth_ami
      subnet_id        = module.vpc.private_subnets[0]
      target_group_arn = module.load_balancing.auth_target_group_arn
      associate_public_ip_address = false
    }
  }
}