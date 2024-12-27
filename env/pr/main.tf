module "production" {
  source = "../../infra"
  name   = "production"
  description = "Production environment"
  environment_name = "production"
  instance_type = "t2.micro"
  instances_max_size = 5
  ecr_name = "prod001"
}