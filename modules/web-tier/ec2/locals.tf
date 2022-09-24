locals{
    pub_subnet_ids = [for x in aws_subnet.pubsubnet : x.id]
    pri_subnet_ids = [for y in aws_subnet.prisubnet : y.id]
}
