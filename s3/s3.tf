# terraform state file setup
# create an S3 bucket to store the state file in
resource "aws_s3_bucket" "homework-terraform-state-storage-s3" {
#    bucket = "homework.gcloud.training"
    bucket = "homework-zf-dot-com"

    versioning {
      enabled = true
    }

    lifecycle {
      prevent_destroy = false
    }

    tags {
      Name = "S3 Remote Terraform State Store"
    }
}
