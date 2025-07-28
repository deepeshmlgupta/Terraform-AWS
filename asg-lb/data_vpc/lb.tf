# # Target Group
# resource "aws_lb_target_group" "web_tg" {
#   name     = "web-target-group"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = data.aws_vpc.existing_vpc.id
#   target_type = "instance"

#   health_check {
#     protocol            = "HTTP"
#     path                = "/"
#     interval            = 30
#     timeout             = 5
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#   }

#   tags = {
#     Name = "Web-TG"
#   }
# }

# # ALB (Application Load Balancer)
# resource "aws_lb" "web_alb" {
#   name               = "web-alb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.web_sg.id]
#   subnets            = [
#     data.aws_subnet.public_subnet_az1.id,
#     data.aws_subnet.public_subnet_az2.id
#   ]
#   enable_deletion_protection = false

#   tags = {
#     Name = "web-alb"
#   }
# }

# # ALB Listener (Port 80 → Forward to TG)
# resource "aws_lb_listener" "web_listener" {
#   load_balancer_arn = aws_lb.web_alb.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.web_tg.arn
#   }
# }


# NLB
resource "aws_lb" "web_nlb" {
  name               = "web-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [
    data.aws_subnet.public_subnet_az1.id,
    data.aws_subnet.public_subnet_az2.id
  ]
  enable_cross_zone_load_balancing = true

  tags = {
    Name = "web-nlb"
  }
}

resource "aws_lb_target_group" "web_tg_nlb" {
  name        = "web-tg-nlb"
  port        = 80
  protocol    = "TCP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.existing_vpc.id

  health_check {
    protocol = "TCP"
    port     = "traffic-port"
  }

  tags = {
    Name = "web-tg-nlb"
  }
}

resource "aws_lb_listener" "web_listener_nlb" {
  load_balancer_arn = aws_lb.web_nlb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg_nlb.arn
  }
}
