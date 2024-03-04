module "vpc" {
  source          = "./modules/vpc"
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  availability_zones = var.availability_zones
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
  # current_ip = var.current_ip
}

module "database" {
  source = "./modules/database"
  hash_key = var.hash_key
  table_name = "Lighting"
}

module "database_2" {
  source = "./modules/database"
  hash_key = var.hash_key
  table_name = "Heating"
}