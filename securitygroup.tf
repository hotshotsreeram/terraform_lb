resource "aws_security_group" "lb-web-server" {
  name        = "lb-web-server"
  description = "Allow incoming HTTP Connections"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_block]
  }
}