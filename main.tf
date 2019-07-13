resource "aws_vpc" "main" {
  cidr_block           = "${var.cidr_block}"
  enable_dns_hostnames = true

  tags = {
    Name = "${trimspace(var.name_tag_prefix)}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_subnet" "private" {
  count = "${(length(data.aws_availability_zones.available.names) * length(var.private_subnet_nametags))}"

  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${element(concat(data.aws_availability_zones.available.names,data.aws_availability_zones.available.names,data.aws_availability_zones.available.names,data.aws_availability_zones.available.names,data.aws_availability_zones.available.names,data.aws_availability_zones.available.names,data.aws_availability_zones.available.names,data.aws_availability_zones.available.names,data.aws_availability_zones.available.names,data.aws_availability_zones.available.names), count.index)}"
  cidr_block        = "${cidrsubnet("${aws_vpc.main.cidr_block}", "${var.cidr_newbits}", length(aws_subnet.public.*.id) + count.index)}"

  tags = {
    Name        = "${trimspace(var.name_tag_prefix)} ${element(var.private_subnet_nametags, ceil(count.index / length(data.aws_availability_zones.available.names)))}"
    Description = "${element(var.private_subnet_nametags, ceil(count.index / length(data.aws_availability_zones.available.names)))}"
    Type        = "private"
  }
}

resource "aws_subnet" "public" {
  count = "${(length(data.aws_availability_zones.available.names) * length(var.public_subnet_nametags))}"

  vpc_id                  = "${aws_vpc.main.id}"
  availability_zone       = "${element(concat(data.aws_availability_zones.available.names,data.aws_availability_zones.available.names,data.aws_availability_zones.available.names,data.aws_availability_zones.available.names,data.aws_availability_zones.available.names,data.aws_availability_zones.available.names,data.aws_availability_zones.available.names,data.aws_availability_zones.available.names,data.aws_availability_zones.available.names,data.aws_availability_zones.available.names), "${count.index}")}"
  cidr_block              = "${cidrsubnet("${aws_vpc.main.cidr_block}", "${var.cidr_newbits}", "${count.index}")}"
  map_public_ip_on_launch = true

  tags = {
    Name        = "${trimspace(var.name_tag_prefix)} ${element(var.public_subnet_nametags, ceil(count.index / length(data.aws_availability_zones.available.names)))}"
    Description = "${element(var.public_subnet_nametags, ceil(count.index / length(data.aws_availability_zones.available.names)))}"
    Type        = "public"
  }
}

resource "aws_eip" "main" {
  count = 2

  vpc = true
}

resource "aws_nat_gateway" "main" {
  count = 2

  allocation_id = "${element(aws_eip.main.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"

  tags = {
    Name = "${trimspace(var.name_tag_prefix)}"
  }
}

resource "aws_route_table" "private" {
  count  = "${length(data.aws_availability_zones.available.names)}"
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "${trimspace(var.name_tag_prefix)} private"
    Type = "private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "${trimspace(var.name_tag_prefix)} public"
    Type = "public"
  }
}

resource "aws_route" "defaultprivate" {
  count = "${length(data.aws_availability_zones.available.names)}"

  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.main.*.id, count.index)}"
}

resource "aws_route" "defaultpublic" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
}

resource "aws_route_table_association" "private" {
  count = "${(length(data.aws_availability_zones.available.names) * length(var.private_subnet_nametags))}"

  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index % 2 == 0 ? 1 : 2)}"
}

resource "aws_route_table_association" "public" {
  count = "${(length(data.aws_availability_zones.available.names) * length(var.public_subnet_nametags))}"

  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}
