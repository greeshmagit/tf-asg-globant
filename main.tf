module "app_tier" {
     source = "./modules/app-tier/rds"
       }
module "web_tier"{
    source = "./modules/web-tier/ec2"
}