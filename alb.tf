# Create a new load balancer



resource "aws_lb" "homework" {
  name               = "homework-alb"

  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-0313e796dc88e05a2"]
  subnets            = ["subnet-e9afac9d","subnet-9632d1f3","subnet-dc3b169a"]


#  access_logs {
#    bucket        = "foo"
#    bucket_prefix = "bar"
#    interval      = 60
#  }



#  instances                   = ["${aws_instance.foo.id}"]
  idle_timeout                = 400

  tags = {
    Name = "homework-alb"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.homework.arn}"
  port              = "80"
  protocol          = "HTTP"
#  ssl_policy        = "ELBSecurityPolicy-2016-08"
#  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.homework.arn}"
  }
}


resource "aws_lb_target_group" "homework" {
  name     = "homework-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-4ae3062f"
}

