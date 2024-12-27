resource "aws_elastic_beanstalk_application" "beanstalk_app" {
  name        = var.name
  description = var.description
}

resource "aws_elastic_beanstalk_environment" "beanstalk_env" {
  name                = var.environment_name
  application         = aws_elastic_beanstalk_application.beanstalk_app.name
  solution_stack_name = "64bit Amazon Linux 2 v4.0.5 running Docker"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.instances_max_size
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.elb_ec2_profile.name
  }
}