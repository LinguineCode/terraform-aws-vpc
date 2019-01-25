# terraform-aws-vpc

A terraform module that takes a simple approach to setting up a VPC with all the dozens of related resources in only ~100 lines of code.

## Features

  1. Creates VPC, NAT gateways, routing tables, routes. Up to 10 private, and 10 public, subnets-per-AZ based on your input.
  1. Automatically discover availability zones.
  1. Automatically calculate CIDR ranges based on quantity of availability zones and the size you want the subnets to be.
  1. Create two NAT Gateways and assign them to subnets on an odd/even basis for multi-AZ.
  1. Resists the temptation to allow for snowflake customization features like VPC Peering, VPN routing, DHCP Options, etc. Keep it simple, when possible.

## Usage

##### Launch an EC2 instance into a single subnet

```terraform
resource "aws_instance" "web" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${module.vpc.default_security_group"]
  subnet_id              = "${element(module.vpc.private_subnet_ids["private"],0)}"
}
```

##### Launch an ELB into multiple subnets
```terraform
resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${module.vpc.default_security_group"]
  subnets            = ["${module.vpc.public_subnet_ids["public"]}"]
}
```

## Outputs

Supported module outputs are:
  1. `default_security_group_id` (string)
  1. `private_subnet_ids` (map)
  1. `public_subnet_ids` (map)
  1. `vpc_id` (string)

Example console output with these custom variables defined:
```
private_subnet_nametags = ["app1", "app2", "db"]
public_subnet_nametags = ["lb", "bastion"]
```

```
default_security_group_id = sg-286b0e60
private_subnet_ids = {
  app1 = [subnet-17f47c5d subnet-4833f614 subnet-b774b8d0 subnet-9d8543b3 subnet-eb9884d4 subnet-5548dd5a]
  app2 = [subnet-a39584c7 subnet-f512b3fa subnet-95c7eaaa subnet-3ca49461 subnet-a14d7f8e subnet-d7ff3b9d]
  db = [subnet-884476a7 subnet-8014b58f subnet-2bf33761 subnet-b8cfe287 subnet-bca090e1 subnet-9f9e8ffb]
  unused3 = []
  unused4 = []
  unused5 = []
  unused6 = []
  unused7 = []
  unused8 = []
  unused9 = []
}
public_subnet_ids = {
  lb = [subnet-b5fe76ff subnet-7923e625 subnet-1d7fb37a subnet-767dba58 subnet-05e1fd3a subnet-fc58cdf3]
  bastion = [subnet-c02509ef subnet-472b2523 subnet-7c01f636 subnet-4f614312 subnet-626db46d subnet-2b9cc614]
  unused2 = []
  unused3 = []
  unused4 = []
  unused5 = []
  unused6 = []
  unused7 = []
  unused8 = []
  unused9 = []
}
vpc_id = vpc-e9f1cc92
```