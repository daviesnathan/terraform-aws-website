/*
  main VPC subnet
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
