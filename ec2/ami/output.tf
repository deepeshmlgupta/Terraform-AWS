output "ami_id" {
  value = aws_ami_from_instance.web_ami.id
}
