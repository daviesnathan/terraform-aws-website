resource "aws_security_group" "allow_all_out" {
  name        = "allow_all_out"
  description = "Allow all outbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_web_in" {
  name        = "allow_web_out"
  description = "Allow all inbound HTTP/HTTPS traffic"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_ssh_in" {
  name        = "allow_ssh_in"
  description = "Allow all SSH inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
