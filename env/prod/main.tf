module "prd" {
  source = "../../infra"
  ecr_name = "kauecode-app"
  iam_role = "ecs-sas"
}

output "ip_lb_dns_name" {
  value = module.prd.lb_dns_name
}