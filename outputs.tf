output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "default_security_group_id" {
  value = "${aws_default_security_group.default.id}"
}
