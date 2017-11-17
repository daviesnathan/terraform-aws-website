resource "aws_key_pair" "deploy_key" {
  key_name = "deploy_ndavies.io"
  public_key = "${file("${var.deploy_key}")}"
}
