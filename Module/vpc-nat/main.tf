module "vpc" {
  source            = "./modules/vpc"
  vpc_name          = var.vpc_name
  vpc_cidr          = var.vpc_cidr
  public_subnets    = var.public_subnets
  private_subnets   = var.private_subnets
  availability_zones = var.availability_zones
} 

module "nat" {
  source            = "./modules/nat-gateway"
  vpc_name          = var.vpc_name
  vpc_id            = module.vpc.vpc_id
  igw_id            = module.vpc.igw_id
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_id  = module.vpc.public_subnet_ids[0]
}

module "sg" {
  source   = "./modules/security-groups"
  vpc_name = var.vpc_name
  vpc_id   = module.vpc.vpc_id
}

resource "aws_key_pair" "key" {
  key_name   = "terra-key"
  public_key = file("terra-key.pub")
} 

module "ec2" {
  source            = "./modules/ec2"
  vpc_name          = var.vpc_name
  ami               = var.ami
  instance_type     = var.instance_type
  key_name          = aws_key_pair.key.key_name
  public_subnet_id  = module.vpc.public_subnet_ids[0]
  private_subnet_id = module.vpc.private_subnet_ids[0]
  web_sg_id         = module.sg.web_sg_id
  app_sg_id         = module.sg.app_sg_id
}
