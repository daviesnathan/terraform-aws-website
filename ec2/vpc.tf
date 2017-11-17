/*
  main VPC
  10.0.0.0/16
*/
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main_vpc"
    Environment = "Production"
    Owner = "${var.owner}"
  }
}

/*
  main VPC routing table
  Send all outbound traffic via the internet gateway
*/
resource "aws_route_table" "rtb" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "main_routetable"
    Environment = "Production"
    Owner = "${var.owner}"
  }
}
