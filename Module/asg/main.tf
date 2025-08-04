module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr              = var.vpc_cidr
  vpc_name              = var.project_name
  public_subnet_az1_cidr = var.public_subnet_az1_cidr
  public_subnet_az2_cidr = var.public_subnet_az2_cidr
  az1                   = var.az1
  az2                   = var.az2
}

module "security" {
  source       = "./modules/security"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "launch_template" {
  source          = "./modules/launch_template"
  project_name    = var.project_name
  ami_id          = var.ami_id 
  instance_type   = var.instance_type
  key_name        = var.key_name
  # public_key_path = var.public_key_path
  sg_id           = module.security.sg_id
}
 
module "alb" {
  source        = "./modules/alb"
  project_name  = var.project_name
  sg_id         = module.security.sg_id
  subnet_ids    = module.vpc.public_subnet_ids
  vpc_id        = module.vpc.vpc_id
  listener_port = var.alb_listener_port
}

module "nlb" {
  source        = "./modules/nlb"
  project_name  = var.project_name
  subnet_ids    = module.vpc.public_subnet_ids
  vpc_id        = module.vpc.vpc_id
  listener_port = var.nlb_listener_port
}

module "asg_alb" {
  source           = "./modules/asg"
  project_name     = var.project_name
  lb_type          = "alb"
  lt_id            = module.launch_template.lt_id
  asg_min          = var.asg_min_size
  asg_max          = var.asg_max_size
  asg_desired      = var.asg_desired_capacity
  subnet_ids       = module.vpc.public_subnet_ids
  target_group_arn = module.alb.alb_tg_arn
}

module "asg_nlb" {
  source           = "./modules/asg"
  project_name     = var.project_name
  lb_type          = "nlb"
  lt_id            = module.launch_template.lt_id
  asg_min          = var.asg_min_size
  asg_max          = var.asg_max_size
  asg_desired      = var.asg_desired_capacity
  subnet_ids       = module.vpc.public_subnet_ids
  target_group_arn = module.nlb.nlb_tg_arn
}