resource "aws_launch_template" "web_lt" {
  name_prefix   = "web-lt-"
  image_id      = aws_ami_from_instance.web_ami.id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.web_sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Web-ASG-Instance"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
