region                  = "ap-south-1"
project_name            = "asg-project"
vpc_cidr                = "10.0.0.0/16"
public_subnet_az1_cidr  = "10.0.1.0/24"
public_subnet_az2_cidr  = "10.0.2.0/24"
az1                     = "ap-south-1a"
az2                     = "ap-south-1b"

ami_id                  = "ami-039c4e735c752c449"
instance_type           = "t2.micro"
key_name                = "terra-key"
# public_key_path         = "terra-key.pub"

asg_min_size            = 1
asg_max_size            = 3
asg_desired_capacity    = 2

alb_listener_port       = 80
nlb_listener_port       = 80
  