resource "aws_security_group" "this" {
  name   = "alb-ecs"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "this-ing-1" {
  type              = "ingress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] #0.0.0.0 - 255.255.255.255
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "this-egr-1" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"] #0.0.0.0 - 255.255.255.255
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group" "private" {
  name   = "private-ecs"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "this-ing-2" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.this.id
  security_group_id        = aws_security_group.private.id
}

resource "aws_security_group_rule" "this-egr-2" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"] #0.0.0.0 - 255.255.255.255
  security_group_id = aws_security_group.private.id
}
