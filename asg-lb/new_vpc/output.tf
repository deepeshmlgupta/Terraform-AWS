output "vpc_id" {
  value = aws_vpc.main.id
  description = "The ID of the created VPC"
}

output "alb_dns_name" {
  value = aws_lb.web_alb.dns_name
  description = "DNS name of the Application Load Balancer"
}

output "nlb_dns_name" {
  value = aws_lb.web_nlb.dns_name
  description = "DNS name of the Network Load Balancer"
}

output "public_subnets" {
  value = [aws_subnet.public_subnet_az1.id, aws_subnet.public_subnet_az2.id]
  description = "Public subnets created"
}

output "asg_alb_name" {
  value = aws_autoscaling_group.alb_asg.name
}

output "asg_nlb_name" {
  value = aws_autoscaling_group.nlb_asg.name
}
