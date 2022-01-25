resource "aws_security_group" "sg" {
  name        = "Security-group"
  description = "Security group"
  vpc_id      = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.sg_port_cidr
    content {
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = "tcp"
      cidr_blocks = ingress.value
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "SG-${var.env}-1"
    Environment = var.env
  }
}
