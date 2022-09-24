resource "aws_launch_configuration" "alc"{
    name_prefix = "web-instance"
    image_id = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    security_groups =[aws_security_group.default.id]
    associate_public_ip_address = true
    user_data = data.template_file.tempfile.rendered
}  
resource "aws_autoscaling_group" "asg"{
    depends_on = [aws_launch_configuration.alc]
    launch_configuration = aws_launch_configuration.alc.id
    min_size = var.asg_min
    max_size = var.asg_max
    desired_capacity = 2
    health_check_type = "ELB"
    force_delete = true
    target_group_arns = [aws_lb_target_group.lb_tg.arn]
    vpc_zone_identifier = [local.pub_subnet_ids[0]]
    tag {
          key = "Name"
          value = "ts-asg"
          propagate_at_launch = true
        }
}

