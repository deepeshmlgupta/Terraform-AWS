# VPC A - Web Tier
resource "aws_vpc" "vpc_a" {
  cidr_block = var.vpc_a_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-a-web-tier"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.vpc_a.id
  cidr_block        = var.subnet_a_cidr
  availability_zone = var.az_a
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-a-public"
  }
}

resource "aws_internet_gateway" "igw_a" {
  vpc_id = aws_vpc.vpc_a.id
  tags = {
    Name = "igw-a"
  }
}

# Add route to the default route table of VPC A (Internet Gateway route)
resource "aws_route" "route_a_to_igw" {
  route_table_id         = aws_vpc.vpc_a.default_route_table_id  # Reference to default route table of VPC A
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_a.id
}

# VPC Peering Connection (A to B)
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = aws_vpc.vpc_a.id
  peer_vpc_id   = aws_vpc.vpc_b.id
  auto_accept   = true

  tags = {
    Name = "vpc-a-to-b-peering"
  }
}

# Add route from VPC A to VPC B via Peering (to default route table of VPC A)
resource "aws_route" "route_a_to_b" {
  route_table_id         = aws_vpc.vpc_a.default_route_table_id  # Reference to default route table of VPC A
  destination_cidr_block = var.vpc_b_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

# VPC B - App Tier
resource "aws_vpc" "vpc_b" {
  cidr_block = var.vpc_b_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-b-app-tier"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.vpc_b.id
  cidr_block        = var.subnet_b_cidr
  availability_zone = var.az_b

  tags = {
    Name = "subnet-b-private"
  }
}

# Add route from VPC B to VPC A via Peering (to default route table of VPC B)
resource "aws_route" "route_b_to_a" {
  route_table_id            = aws_vpc.vpc_b.default_route_table_id  # Reference to default route table of VPC B
  destination_cidr_block    = var.vpc_a_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

# Security Group for Web EC2 (public)
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.vpc_a.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

# Security Group for App EC2 (private)
resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  description = "Allow ICMP and SSH from Web EC2"
  vpc_id      = aws_vpc.vpc_b.id

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.vpc_a_cidr]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_a_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-sg"
  }
}

# Key Pair for EC2 Instances
resource "aws_key_pair" "my_key" {
  key_name   = "terra-key"
  public_key = file("terra-key.pub")
}

# EC2 Instance for Web (VPC A)
resource "aws_instance" "web_ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnet_a.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.my_key.key_name
  vpc_security_group_ids      = [aws_security_group.web_sg.id]

  tags = {
    Name = "web-ec2"
  }
}

# EC2 Instance for App (VPC B)
resource "aws_instance" "app_ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnet_b.id
  vpc_security_group_ids      = [aws_security_group.app_sg.id]
  key_name                    = aws_key_pair.my_key.key_name

  tags = {
    Name = "app-ec2"
  }
}

# Output VPC CIDR for both VPCs
output "vpc_a_cidr" {
  value = aws_vpc.vpc_a.cidr_block
}

output "vpc_b_cidr" {
  value = aws_vpc.vpc_b.cidr_block
}
