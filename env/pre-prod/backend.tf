terraform {
  backend "s3" {
    bucket = "kauecode-iac-containers"
    key    = "prd/terraform.tfstate"
    region = "sa-east-1"
  }
}
