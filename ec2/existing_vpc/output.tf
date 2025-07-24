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
