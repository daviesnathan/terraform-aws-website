resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "main_igw"
    Environment = "Production"
    Owner = "${var.owner}"
  }
}
