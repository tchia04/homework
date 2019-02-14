provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "amzn2_lc" {
  most_recent = true

  filter {
    name   = "name"
#    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
    values = ["packer-linux-aws-demo-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["352144492228"] # Canonical
}

resource "aws_launch_configuration" "as_conf" {
#  name          = "web_config"
	name_prefix   = "homework-"
  image_id      = "${data.aws_ami.amzn2_lc.id}"
#  instance_type = "t3.small"
  instance_type = "t3.micro"
  key_name       = "dickson"
  security_groups  = ["sg-7ac0a605"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "homework_asg" {
  name                 = "homework_asg"
  launch_configuration = "${aws_launch_configuration.as_conf.name}"
	desired_capacity     = 1
  min_size             = 1
  max_size             = 1
	vpc_zone_identifier  = ["subnet-e9afac9d","subnet-9632d1f3","subnet-dc3b169a"]
#	load_balancers       = ["homework-alb"]
#  target_group_arns    = [""]
  health_check_type     = "ELB"
  target_group_arns = ["${aws_lb_target_group.homework.arn}"]

  lifecycle {
    create_before_destroy = true
  }

  depends_on = ["aws_lb.homework"]

}
