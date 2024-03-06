variable "vpc_id" {
  type = string
}

# variable "app_server_ids" {
#   type = list(string)
# }

variable "public_subnets" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

# variable "target_group_arn" {
#   type = string
# }

variable "private_subnets" {
  type = list(string)
}

variable "heating_instance_id" {
  type = string
}

variable "lighting_instance_id" {
  type = string
}

variable "auth_instance_id" {
  type = string
}

variable "status_instance_id" {
  type = string
}