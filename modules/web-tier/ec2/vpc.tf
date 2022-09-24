resource "aws_vpc" "vpc"{
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
}
resource "aws_subnet" "pubsubnet"{
    for_each = var.publicsubnets
    vpc_id = aws_vpc.vpc.id
    cidr_block = each.value
    availability_zone = each.key
    tags = {
        Name = "tf-public"
    }
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
 resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.vpc.id
 }
 resource "aws_route_table" "pubroute"{
    vpc_id = aws_vpc.vpc.id
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "tf-public-rt"
    }
 }
 resource "aws_eip" "eip"{
    vpc = true
 }
 resource "aws_nat_gateway" "ngw"{
    allocation_id = aws_eip.eip.id
    subnet_id = data.aws_subnet.pub_sub_id.id
 }
 resource "aws_route_table" "priroute"{
    vpc_id = aws_vpc.vpc.id
     route {
            cidr_block = "0.0.0.0/0"
            gateway_id = aws_nat_gateway.ngw.id
    }
 }
 resource "aws_route_table_association" "pubrta"{
    count = length(local.pub_subnet_ids)
    subnet_id = local.pub_subnet_ids[count.index]
    route_table_id = aws_route_table.pubroute.id
 }
 resource "aws_route_table_association" "prirta"{
    count = length(local.pri_subnet_ids)
    subnet_id = local.pri_subnet_ids[count.index]
    route_table_id = aws_route_table.priroute.id
 }