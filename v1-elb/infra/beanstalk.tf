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
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "DisableIMDSv1"
    value     = true
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

resource "aws_elastic_beanstalk_application_version" "elb-app-version" {
  depends_on  = [
    aws_s3_object.docker-zip, 
    aws_elastic_beanstalk_environment.beanstalk_env,
    aws_elastic_beanstalk_application.beanstalk_app
  ]
  name        = "${var.name}-elb-app-version-2"
  application = aws_elastic_beanstalk_application.beanstalk_app.name
  description = "application version created by terraform"
  bucket      = aws_s3_bucket.elb-depolyment-bucket.id
  key         = aws_s3_object.docker-zip.id
}