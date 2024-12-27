module "pre-prod" {
  source = "../../infra"
  name   = "pre-prod"
  description = "pre-prod environment"
  environment_name = "pre-prod"
  instance_type = "t2.micro"
  instances_max_size = 2
  ecr_name = "preprod001"
}