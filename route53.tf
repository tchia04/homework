# create a route 53 record that points homework.gcloud.training to the ALB created so we can use loader.io 

# loader.io verification http://homework.gcloud.training/loaderio-14cd55e65597953829f714fdd2ba66b1/


resource "aws_route53_record" "homework" {
#  zone_id = "${aws_route53_zone.primary.zone_id}"
  zone_id = "Z2R3WAYBH5IR2D"
  name    = "homework.gcloud.training"
  type    = "A"


  alias {
    name                   = "${aws_lb.homework.dns_name}"
    zone_id                = "${aws_lb.homework.zone_id}"
    evaluate_target_health = true
  }
}

