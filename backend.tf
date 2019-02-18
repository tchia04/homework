
terraform {
 backend "s3" {
 encrypt = false
# bucket = "homework.gcloud.training"
 bucket = "homework-zf-dot-com"
 region = "us-west-2"
 profile  = "default"
 key = "app/terraform.tfstate"
# dynamodb_table = "homework.gcloud.training"
 dynamodb_table = "terraform-lock"

 }
# depends_on = ["homework-terraform-state-storage-s3j"]
}


