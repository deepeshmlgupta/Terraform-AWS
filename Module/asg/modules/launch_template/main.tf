resource "aws_key_pair" "key" {
  key_name   = var.key_name
  public_key = file("terra-key.pub")
}

resource "aws_launch_template" "lt" {
  name_prefix   = "${var.project_name}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.key.key_name

  vpc_security_group_ids = [var.sg_id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-instance"
    }
  }
}