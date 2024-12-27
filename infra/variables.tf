variable "ecr_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "name" {
  description = "Name of the Elastic Beanstalk application"
  type        = string
}

variable "description" {
  description = "Description of the Elastic Beanstalk application"
  type        = string
}

variable "environment_name" {
  description = "Name of the Elastic Beanstalk environment"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the Elastic Beanstalk environment"
  type        = string
}

variable "instances_max_size" {
  description = "Maximum number of instances for the Elastic Beanstalk environment"
  type        = number
}