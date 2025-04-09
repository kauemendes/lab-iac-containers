module "infra" {
  source = "../../infra"

  ecr_name = "ecs-django"
  role_iam = "ecs-django"
}

output "module_alb_dns_name" {
  value = module.infra.alb_dns_name
}
