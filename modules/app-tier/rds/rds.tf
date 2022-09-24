resource "aws_db_subnet_group" "db_subnet"{
 /*subnet_ids = [data.aws_subnet.pri_sub_id.id]*/
    
   subnet_ids = [local.pri_subnet_ids[0],local.pri_subnet_ids[1]]
}
resource "aws_db_instance" "db_instance"{
    identifier = var.db_instance_identifier
    allocated_storage = 20
    engine = "mysql"
    engine_version = "5.7"
    instance_class = "db.t2.micro"
    db_name = var.database_name
    username = var.database_user
    password = var.database_password
    parameter_group_name = "default.mysql5.7"
    skip_final_snapshot = true
    db_subnet_group_name = aws_db_subnet_group.db_subnet.name
    vpc_security_group_ids = [aws_security_group.db_sg.id]
    final_snapshot_identifier = "ignore"
}
 resource "aws_subnet" "prisubnet"{
    for_each = var.privatesubnets
    vpc_id = aws_vpc.vpc.id
    cidr_block = each.value
    availability_zone = each.key
    tags = {
        Name = "tf-private"
    }
 }
 resource "aws_vpc" "vpc"{
    cidr_block = var.vpc_cidr
}
resource "aws_security_group" "db_sg"{
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
}
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