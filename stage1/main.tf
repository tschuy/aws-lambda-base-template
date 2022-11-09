terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/stage1.tfstate"
  }
}

data "terraform_remote_state" "stage1" {
  backend = "s3"

  # var configured in CI
  config = {
    bucket  = var.remote_bucket_name
    region  = "us-west-2"
    key     = "indent/stage0.tfstate"
  }
}
