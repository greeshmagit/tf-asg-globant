output ami_id{
    value = aws_launch_configuration.alc.id
}
output "vpc_id"{
    value = aws_vpc.vpc.id
}
output target_group_arn{
    value = aws_lb_target_group.lb_tg.arn
}
output load_balancer_arn{
    value = aws_lb.alb.arn
}