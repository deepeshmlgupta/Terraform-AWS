output "web_instance_public_ip" {
  value = aws_instance.web.public_ip
}

output "web_instance_public_dns" {
  value = aws_instance.web.public_dns
}

output "app_instance_id" {
  value = aws_instance.app.id
}

output "app_instance_private_ip" {
  value = aws_instance.app.private_ip
}
