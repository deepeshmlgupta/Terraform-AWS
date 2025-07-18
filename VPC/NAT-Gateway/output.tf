output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}

output "web_instance_public_ip" {
  value = aws_instance.web.public_ip
}

output "web_instance_dns" {
  value = aws_instance.web.public_dns
}

output "web_instance_private" {
  value = aws_instance.web.private_ip
}

output "app_instance_private_ip" {
  value = aws_instance.app.private_ip
}