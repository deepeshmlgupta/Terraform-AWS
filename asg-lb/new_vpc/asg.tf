resource "aws_autoscaling_group" "alb_asg" {
  name                      = "alb-asg"
  desired_capacity          = var.asg_desired_capacity
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  vpc_zone_identifier       = [aws_subnet.public_subnet_az1.id, aws_subnet.public_subnet_az2.id]
  health_check_type         = "ELB"
  target_group_arns         = [aws_lb_target_group.alb_tg.arn]

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "alb-asg-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "nlb_asg" {
  name                      = "nlb-asg"
  desired_capacity          = 2
  max_size                  = 3
  min_size                  = 1
  vpc_zone_identifier       = [aws_subnet.public_subnet_az1.id, aws_subnet.public_subnet_az2.id]
  target_group_arns         = [aws_lb_target_group.nlb_tg.arn]

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "nlb-asg-instance"
    propagate_at_launch = true
  }
}
