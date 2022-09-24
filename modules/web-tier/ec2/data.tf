data "template_file" "tempfile"{
    template = file("./scripts/userdata.sh")
}
data "aws_subnet" "pub_sub_id"{
        id = local.pub_subnet_ids[0]
    }