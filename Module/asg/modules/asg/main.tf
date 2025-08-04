resource "aws_autoscaling_group" "asg" {
  name                = "${var.project_name}-${var.lb_type}-asg"
  desired_capacity    = var.asg_desired
  min_size            = var.asg_min
  max_size            = var.asg_max
  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = [var.target_group_arn]

  launch_template {
    id      = var.lt_id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-${var.lb_type}-asg-instance"
    propagate_at_launch = true
  }
}
 