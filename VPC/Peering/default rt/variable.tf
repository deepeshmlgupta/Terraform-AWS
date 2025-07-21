variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_a_cidr" {
  description = "CIDR block for VPC A (Web Tier)"
  type        = string
}

variable "vpc_b_cidr" {
  description = "CIDR block for VPC B (App Tier)"
  type        = string
}

variable "subnet_a_cidr" {
  description = "CIDR block for Subnet A (in VPC A)"
  type        = string
}

variable "subnet_b_cidr" {
  description = "CIDR block for Subnet B (in VPC B)"
  type        = string
}

variable "az_a" {
  description = "Availability Zone for Subnet A"
  type        = string
}

variable "az_b" {
  description = "Availability Zone for Subnet B"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to use for both EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
}

# variable "key_name" {
#   description = "EC2 Key pair name"
#   type        = string
# }
