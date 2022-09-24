locals{
    pri_subnet_ids = [for y in aws_subnet.prisubnet : y.id]
}