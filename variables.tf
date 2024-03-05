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

variable "hash_key" {
  type = string
}

variable "instance_type" {
  type        = string
}

variable "hash_key_type" {
  type = string
}