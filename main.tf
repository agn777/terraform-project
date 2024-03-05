module "vpc" {
  source             = "./modules/vpc"
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
  # current_ip = var.current_ip
}

module "Lighting_database" {
  source     = "./modules/database"
  hash_key   = var.hash_key
  table_name = "Lighting"
  hash_key_type = var.hash_key_type
}

module "Heating_database" {
  source     = "./modules/database"
  hash_key   = var.hash_key
  table_name = "Heating"
  hash_key_type = var.hash_key_type
}

module "app-servers" {
  source             = "./modules/app-servers"
  public_subnets     = module.vpc.public_subnets
  security_group_ids = module.security.security_group_ids
  instance_type      = var.instance_type
  private_subnets    = module.vpc.private_subnets
}
