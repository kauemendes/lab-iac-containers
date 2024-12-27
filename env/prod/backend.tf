terraform {
  backend "s3" {
    bucket = "kauecode-iac-containers"
    key    = "pre-prd/terraform.tfstate"
    region = "sa-east-1"
  }
}
