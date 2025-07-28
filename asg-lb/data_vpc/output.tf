output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

output "web_url" {
  value = "http://${aws_instance.web.public_ip}"
}

output "ec2_dns" {
  value = aws_instance.web.public_dns
}

output "ec2_priip" { 
  value = aws_instance.web.private_ip
}

output "ec2_key" {
  value = aws_instance.web.key_name
}

output "web_ami_id" {
  value = aws_ami_from_instance.web_ami.id
}

output "launch_template_id" {
  value = aws_launch_template.web_lt.id
}

output "asg_name" {
  value = aws_autoscaling_group.web_asg.name
}

# output "alb_dns_name" {
#   value = aws_lb.web_alb.dns_name
# }

output "nlb_dns_name" {
  value = aws_lb.web_nlb.dns_name
}