resource "aws_instance" "web" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.web_sg_id]
  associate_public_ip_address = true
  tags = {
    Name = "${var.vpc_name}-web"
  }
} 

resource "aws_instance" "app" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.app_sg_id]
  tags = {
    Name = "${var.vpc_name}-app"
  }
}
