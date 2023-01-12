resource "aws_lb" "web_lb" {
  name                       = "${var.env}-web-lb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [data.terraform_remote_state.vpc.outputs.web_lb_sg_id]
  subnets                    = data.terraform_remote_state.vpc.outputs.public_subnets_ids
  enable_deletion_protection = false
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_web_alb"
    }
  )
}

resource "aws_lb_target_group" "web_tg" {
  name                          = "${var.env}-tg"
  port                          = 80
  protocol                      = "HTTP"
  target_type                   = "instance"
  vpc_id                        = data.terraform_remote_state.vpc.outputs.vpc_id
  load_balancing_algorithm_type = "least_outstanding_requests"

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    port              = 80
    matcher             = "200,202"
    interval            = 300
  }
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.amazon_issued.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

resource "aws_lb_listener" "http_listener" {
  depends_on        = []
  load_balancer_arn = aws_lb.web_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}