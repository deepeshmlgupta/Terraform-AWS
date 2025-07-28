# resource "aws_autoscaling_group" "web_asg" {
#   name                      = "web-asg"
#   desired_capacity          = 2
#   max_size                  = 3
#   min_size                  = 1
#   vpc_zone_identifier       = [data.aws_subnet.existing_subnet.id]

#   target_group_arns         = [aws_lb_target_group.web_tg.arn]
#   health_check_type         = "ELB"
#   health_check_grace_period = 300

#   launch_template {
#     id      = aws_launch_template.web_lt.id
#     version = "$Latest"
#   }

#   tag {
#     key                 = "Name"
#     value               = "Web-ASG-Instance"
#     propagate_at_launch = true
#   }

#   lifecycle {
#     create_before_destroy = true
#   }

#   termination_policies = ["OldestInstance"]
# }


#NLB

resource "aws_autoscaling_group" "web_asg" {
  name                      = "web-asg"
  desired_capacity          = 2
  max_size                  = 3
  min_size                  = 1
  vpc_zone_identifier       = [
    data.aws_subnet.public_subnet_az1.id,
    data.aws_subnet.public_subnet_az2.id
  ]

  target_group_arns         = [aws_lb_target_group.web_tg_nlb.arn]
  health_check_type         = "EC2" # NLB doesn't support ELB health checks

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Web-ASG-Instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }

  termination_policies = ["OldestInstance"]
}
