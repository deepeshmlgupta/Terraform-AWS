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

resource "aws_route_table" "rt_a" {
  vpc_id = aws_vpc.vpc_a.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_a.id
  }

  tags = {
    Name = "rt-a-public"
  }
}

resource "aws_route_table_association" "rta_a" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.rt_a.id
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

# VPC Peering
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = aws_vpc.vpc_a.id
  peer_vpc_id   = aws_vpc.vpc_b.id
  auto_accept   = true

  tags = {
    Name = "vpc-a-to-b-peering"
  }
}

# Route updates for VPC A and VPC B
resource "aws_route" "route_a_to_b" {
  route_table_id         = aws_route_table.rt_a.id
  destination_cidr_block = var.vpc_b_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

resource "aws_route_table" "rt_b" {
  vpc_id = aws_vpc.vpc_b.id

  route {
    cidr_block = var.vpc_a_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  }

  tags = {
    Name = "rt-b-private"
  }
}

resource "aws_route_table_association" "rta_b" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.rt_b.id
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

#key-pain
resource "aws_key_pair" "my_key" {
    key_name = "terra-key"
    public_key = file("terra-key.pub")
}

# EC2 Instances
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

resource "aws_instance" "app_ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet_b.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  key_name               = aws_key_pair.my_key.key_name

  tags = {
    Name = "app-ec2"
  }
}
