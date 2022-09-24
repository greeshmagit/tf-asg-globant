resource "aws_lb_target_group" "lb_tg"{
    name        = var.target_group_name
    target_type = var.target_type
    port        = 80
    protocol    = "HTTP"
    vpc_id      = aws_vpc.vpc.id
    health_check{
        path                = "/index.html"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        interval            = 30
    }
} 
resource "aws_lb" "alb"{
    name                = "tf-ALB"
    internal            = false
    ip_address_type     = "ipv4"
    load_balancer_type  = var.load_balancer_type
    security_groups     = [aws_security_group.lb_sg.id]
    subnets             = [local.pub_subnet_ids[0],local.pub_subnet_ids[1]]
    tags = {
        Environment = "test"
    }
}
resource "aws_lb_listener" "lis_rule_http"{
    load_balancer_arn = aws_lb.alb.arn
    port              = 80
    protocol          = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.lb_tg.arn
   }
}
/*resource "aws_lb_listener" "lis_rule_https"{
    load_balancer_arn = aws_lb.alb.arn
    port              = 443
    protocol          = "HTTPS"
    default_action {
      type = "redirect"
      redirect {
          status_code       = "HTTP_301"
    }
   }
}*/