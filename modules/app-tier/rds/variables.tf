variable "db_instance_identifier"{
    default = "tf-mysql"
}
variable "database_name"{
    default = "Sqladmin"
}
variable "database_password"{
    default = "Sql1dmin"
}
variable "database_user"{
    default = "terraform"
}
variable "vpc_cidr"{
    type = string
    default = "10.0.0.0/16"
    description = "choose CIDR block for vpc"
}
/*variable "publicsubnets"{
    type = map(any)
    default = {
        "ap-south-1a" : "10.0.0.0/24",
        "ap-south-1b" : "10.0.1.0/24"
    }
}*/
variable "privatesubnets"{
    type = map(any)
    default = {
        "ap-south-1a" : "10.0.2.0/24"
        "ap-south-1b" : "10.0.3.0/24"
    }
}