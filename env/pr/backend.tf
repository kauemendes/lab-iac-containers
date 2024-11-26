terraform {
  backend "s3" {
    bucket = "kauecode-iac-containers"
    key    = "pr/terraform.tfstate"
    region = "sa-east-1"
  }
}
