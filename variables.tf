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

# variable "current_ip" {
#   type = list(string)
# }