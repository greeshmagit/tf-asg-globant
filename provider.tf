provider aws {
    region = var.region
   /* version = ""
    access_key = var.access_key
    secret_key = var.secret_key*/
}
terraform{
    backend  "s3"{
        bucket = "geetha-tf"
        key = "terraform.tfstate"
        region = "ap-south-1"
        dynamodb_table = "geetha-terraform"
    }
}