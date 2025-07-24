# 🔑 Key Pair
resource "aws_key_pair" "my_key" {
    key_name = "terra-key-ec2"
    public_key = file("terra-key.pub")
}

# Fetch existing VPC
# Use existing VPC by tag name
data "aws_vpc" "existing_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Use existing Subnet by tag name and VPC ID
data "aws_subnet" "existing_subnet" {
  filter {
    name   = "tag:Name"
    values = [var.subnet_name]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing_vpc.id]
  }
}



# EC2 Instance
resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnet.existing_subnet.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  key_name                    = aws_key_pair.my_key.key_name
  associate_public_ip_address = true

  user_data = file("vmsetup.sh")

  root_block_device {
    volume_size = var.root_storage
    volume_type = "gp3"
  }

  tags = {
    Name = "Terraform-Web-Instance"
  }
}
