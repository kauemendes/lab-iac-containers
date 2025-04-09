resource "aws_lb" "this" {
  name            = "ecs-django"
  security_groups = [aws_security_group.this.id]
  subnets         = [module.vpc.public_subnets]
}

resource "aws_lb_target_group" "this" {
  name        = "ecs-django"
  port        = 8000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "8000"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

output "alb_dns_name" {
  value = aws_alb.alb.dns_name
}
