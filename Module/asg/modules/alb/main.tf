resource "aws_lb" "alb" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_id]
  subnets            = var.subnet_ids
}

resource "aws_lb_target_group" "alb_tg" {
  name        = "${var.project_name}-alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id 
  target_type = "instance"
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}
