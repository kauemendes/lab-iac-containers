resource "aws_security_group" "sg_ecs_public" {
  name   = "sg_ecs_public"
  vpc_id = module.vpc.vpc_id
  tags = {
    Name       = "allow_tls"
    managed_by = "terraform"
  }
}

resource "aws_security_group_rule" "sg_rl_ingresspub" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_ecs_public.id
}

resource "aws_security_group_rule" "sg_rl_egresspub" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_ecs_public.id
}

resource "aws_security_group" "sg_ecs_private" {
  name   = "sg_ecs_private"
  vpc_id = module.vpc.vpc_id
  tags = {
    Name       = "allow_tls"
    managed_by = "terraform"
  }
}

resource "aws_security_group_rule" "sg_rl_ingress" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.sg_ecs_public.id
  security_group_id        = aws_security_group.sg_ecs_private.id
}

resource "aws_security_group_rule" "sg_rl_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_ecs_private.id
}
