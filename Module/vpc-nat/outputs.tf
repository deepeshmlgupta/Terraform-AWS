# VPC Information
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR range of the VPC"
  value       = var.vpc_cidr
}

# Subnet Information
output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_cidrs" {
  description = "CIDR blocks of public subnets"
  value       = var.public_subnets
}

output "private_subnet_cidrs" {
  description = "CIDR blocks of private subnets"
  value       = var.private_subnets
}

# NAT Gateway Information
output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = module.nat.nat_gateway_id
}

# EC2 - Web Tier
output "web_instance_public_ip" {
  description = "The public IP address of the Web EC2 instance"
  value       = module.ec2.web_instance_public_ip
}

output "web_instance_public_dns" {
  description = "The public DNS of the Web EC2 instance"
  value       = module.ec2.web_instance_public_dns
}

# EC2 - App Tier
output "app_instance_id" {
  description = "The ID of the App EC2 instance"
  value       = module.ec2.app_instance_id
}

output "app_instance_private_ip" {
  description = "The private IP address of the App EC2 instance"
  value       = module.ec2.app_instance_private_ip
}
