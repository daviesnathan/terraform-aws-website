/*
  main_subnet
  10.0.1.0/24
*/
resource "aws_subnet" "main" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"

  tags {
    Name = "main_subnet"
    Environment = "Production"
    Owner = "${var.owner}"
  }
}

/*
  main_routetable association to
  main_subnet
*/
resource "aws_route_table_association" "main" {
  subnet_id      = "${aws_subnet.main.id}"
  route_table_id = "${aws_route_table.rtb.id}"
}
