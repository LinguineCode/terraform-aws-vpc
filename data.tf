data "aws_availability_zones" "available" {}

data "aws_security_group" "default" {
  vpc_id = "${aws_vpc.main.id}"
  name   = "default"
}
