resource "aws_lb" "ecs-lb" {
  name               = "ecs-lb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_ecs_public.id]
  subnets            = [for subnet in module.vpc.public_subnets : subnet]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
    managed_by  = "terraform"
  }
}

resource "aws_lb_target_group" "target_group" {
  name        = "ecs-tg"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.ecs-lb.arn
  port              = "3000"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

output "lb_dns_name" {
  value = aws_lb.ecs-lb.dns_name
}