module "ecs_cluster" {
  source       = "terraform-aws-modules/ecs/aws"
  cluster_name = "django-api-cluster"
  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }

  services = {
    djano-api = {
      cpu    = 1024
      memory = 4096

      # Container definition(s)
      container_definitions = {
        django-api = {
          cpu       = 256
          memory    = 512
          essential = true
          image     = aws_ecr_repository.ecr_repo.image_uri
          port_mappings = [
            {
              name          = "django-api"
              containerPort = 80
              protocol      = "tcp"
            }
          ]

          # Example image used requires access to write to root filesystem
          readonly_root_filesystem = false

          enable_cloudwatch_logging = false
          log_configuration = {
            logDriver = "awsfirelens"
            options = {
              Name                    = "django-api-task"
              region                  = "sa-east-1"
              delivery_stream         = "ecs-stream"
              log-driver-buffer-limit = "2097152"
            }
          }
          memory_reservation = 100
        }
      }

      service_connect_configuration = {
        namespace = "example"
        service = {
          client_alias = {
            port     = 80
            dns_name = "django-api"
          }
          port_name      = "django-api"
          discovery_name = "django-api"
        }
      }

      load_balancer = {
        service = {
          target_group_arn = "arn:aws:elasticloadbalancing:eu-west-1:1234567890:targetgroup/bluegreentarget1/209a844cd01825a4"
          container_name   = "django-api"
          container_port   = 80
        }
      }

      subnet_ids = ["subnet-abcde012", "subnet-bcde012a", "subnet-fghi345a"]
      security_group_rules = {
        alb_ingress_3000 = {
          type                     = "ingress"
          from_port                = 80
          to_port                  = 80
          protocol                 = "tcp"
          description              = "Service port"
          source_security_group_id = aws_security_group.this.id
        }
        egress_all = {
          type        = "egress"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
  }

  tags = {
    Environment = "dev"
    Project     = "lab-iac-containers"
  }
}
