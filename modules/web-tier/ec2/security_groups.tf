resource "aws_security_group" default{
    vpc_id = aws_vpc.vpc.id
    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks =["0.0.0.0/0"]
    }
    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "tf-ec2-sg"
    }
}
resource "aws_security_group" "lb_sg"{
    vpc_id = aws_vpc.vpc.id
    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress{
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "tf-lb-sg"
    }
}
/*resource "aws_security_group" "db_sg"{
    vpc_id = aws_vpc.vpc.id
    ingress{
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [aws_security_group.default.id]
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "tf-rds-sg"
    }
}*/

