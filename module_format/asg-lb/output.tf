# VPC Outputs
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs in the VPC"
  value       = module.vpc.public_subnet_ids
}

# Security Outputs
output "security_group_id" {
  description = "Security Group ID for EC2 instances"
  value       = module.security.sg_id
}

# Launch Template Outputs
output "launch_template_id" {
  description = "Launch template ID used by ASGs"
  value       = module.launch_template.lt_id
}

# ALB Outputs
output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "alb_target_group_arn" {
  description = "ARN of the ALB Target Group"
  value       = module.alb.alb_tg_arn
}

# NLB Outputs
output "nlb_dns_name" {
  description = "DNS name of the Network Load Balancer"
  value       = module.nlb.nlb_dns_name
}

output "nlb_target_group_arn" {
  description = "ARN of the NLB Target Group"
  value       = module.nlb.nlb_tg_arn
}

# ASG Outputs
output "asg_alb_name" {
  description = "Name of the Auto Scaling Group for ALB"
  value       = module.asg_alb.asg_name
}

output "asg_nlb_name" {
  description = "Name of the Auto Scaling Group for NLB"
  value       = module.asg_nlb.asg_name
}
