module "vpc" {
  source             = "./modules/vpc"
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

module "Lighting_database" {
  source        = "./modules/database"
  hash_key      = var.hash_key
  table_name    = "Lighting"
  hash_key_type = var.hash_key_type
}

module "Heating_database" {
  source        = "./modules/database"
  hash_key      = var.hash_key
  table_name    = "Heating"
  hash_key_type = var.hash_key_type
}

module "app-servers" {
  source             = "./modules/app-servers"
  public_subnets     = module.vpc.public_subnets
  security_group_ids = module.security.security_group_ids
  instance_type      = var.instance_type
  private_subnets    = module.vpc.private_subnets
  lighting_ami       = var.lighting_ami
  heating_ami        = var.heating_ami
  auth_ami           = var.auth_ami
  status_ami         = var.status_ami
  key_name           = var.key_name
}

module "load_balancing" {
  source               = "./modules/load_balancing"
  vpc_id               = module.vpc.vpc_id
  public_subnets       = module.vpc.public_subnets
  security_group_ids   = module.security.security_group_ids
  private_subnets      = module.vpc.private_subnets
  heating_instance_id  = module.app-servers.heating_id
  lighting_instance_id = module.app-servers.lighting_id
  auth_instance_id     = module.app-servers.auth_id
  status_instance_id   = module.app-servers.status_id
}

module "autoscaling_group" {
  source                 = "./modules/autoscaling_group"
  max_size               = var.max_size
  min_size               = var.min_size
  req_size               = var.req_size
  availability_zones     = var.availability_zones
  instance_type          = var.instance_type
  vpc_security_group_ids = module.security.security_group_ids
  lb_target_group_arns   = module.load_balancing.target_group_arns
  public_subnets         = module.vpc.public_subnets
  private_subnets        = module.vpc.private_subnets
  key_name               = var.key_name
  services               = local.services
}

# testing a commit

