variable "region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Name of the project (used for resource naming)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_az1_cidr" {
  description = "CIDR block for public subnet in AZ1"
  type        = string
}

variable "public_subnet_az2_cidr" {
  description = "CIDR block for public subnet in AZ2"
  type        = string
}

variable "az1" {
  description = "Availability Zone 1"
  type        = string
}

variable "az2" {
  description = "Availability Zone 2"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
} 

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

# variable "public_key_path" {
#   description = "Path to the SSH public key"
#   type        = string
# }

variable "asg_min_size" {
  description = "Minimum size of Auto Scaling Group"
  type        = number
}

variable "asg_max_size" {
  description = "Maximum size of Auto Scaling Group"
  type        = number
}

variable "asg_desired_capacity" {
  description = "Desired capacity of Auto Scaling Group"
  type        = number
}

variable "alb_listener_port" {
  description = "Listener port for ALB"
  type        = number
}

variable "nlb_listener_port" {
  description = "Listener port for NLB"
  type        = number
}
