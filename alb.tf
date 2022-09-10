resource "aws_lb_target_group" "lb-target-group" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = var.lb_target_group
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.default.id

}

resource "aws_lb" "application-lb" {
  name               = var.lb_name
  internal           = false
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb-web-server.id]
  subnets            = data.aws_subnet_ids.subnet.ids


}

resource "aws_alb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.application-lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.lb-target-group.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "ec2_attach" {
  count            = length(aws_instance.lb-web-server)
  target_group_arn = aws_lb_target_group.lb-target-group.arn
  target_id        = aws_instance.lb-web-server[count.index].id
}


