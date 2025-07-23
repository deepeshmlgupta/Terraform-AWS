output "ec2_pubip" {
  value = aws_instance.terra-instance.public_ip
}

output "ec2_dns" {
  value = aws_instance.terra-instance.public_dns
}

output "ec2_priip" {
  value = aws_instance.terra-instance.private_ip
}

output "ec2_key" {
  value = aws_instance.terra-instance.key_name
}