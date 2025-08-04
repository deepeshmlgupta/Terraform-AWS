output "nlb_dns_name" {
  description = "DNS name of the Network Load Balancer"
  value       = aws_lb.nlb.dns_name
}

output "nlb_tg_arn" {
  description = "ARN of the NLB Target Group"
  value       = aws_lb_target_group.nlb_tg.arn
}
