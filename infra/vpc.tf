module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-ecs"
  cidr = "10.0.0.0/16"

  azs             = ["eu-east-1a", "eu-east-1b", "eu-east-1c"]
  private_subnets = ["10.0.20.0/24", "10.0.30.0/24", "10.0.40.0/24"]
  public_subnets  = ["10.0.191.0/24", "10.0.192.0/24", "10.0.193.0/24"]

  enable_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "prd"
    managed_by  = "terraform"
  }
}