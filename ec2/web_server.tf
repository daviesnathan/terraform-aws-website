/*
  Web Blog Instance
  eu-west-1 blog.ndavies.io
*/
resource "aws_instance" "web" {
  ami = "ami-016f9e78"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.main.id}"
  key_name = "${aws_key_pair.deploy_key.id}"
  associate_public_ip_address = true

  vpc_security_group_ids = [
    "${aws_security_group.allow_all_out.id}",
    "${aws_security_group.allow_web_in.id}",
    "${aws_security_group.allow_ssh_in.id}",
  ]

  root_block_device = {
    delete_on_termination = true
  }

  tags = {
    Name = "blog.ndavies.io"
    Environment = "Production"
    Owner = "${var.owner}"
  }
}

/*
  Blog Route53 Record
  blog.ndavies.io
*/
resource "aws_route53_record" "blog_web" {
  zone_id = "${var.dns_zone}"
  name    = "blog.ndavies.io"
  type    = "A"
  ttl     = 60

  records = [
    "${aws_instance.web.public_ip}"
  ]
}
