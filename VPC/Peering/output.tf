output "vpc_id_web" {
    value = aws_vpc.vpc_a.id
}

output "vpc_subnet_web" {
    value = aws_subnet.subnet_a.id
}

output "vpc_id_app" {
    value = aws_vpc.vpc_b.id
}

output "vpc_subnet_app" {
    value = aws_subnet.subnet_b.id
}

output "vpc_peering" {
    value = aws_vpc_peering_connection.peer.id
}

output "ec2_web_publicIP" {
    value = aws_instance.web_ec2.public_ip
}

output "ec2_web_privateIp" {
    value = aws_instance.web_ec2.private_ip
}

output "ec2_web_dns" {
    value = aws_instance.web_ec2.public_dns
}

output "ec2_app_privateIp" {
    value = aws_instance.app_ec2.private_ip
}