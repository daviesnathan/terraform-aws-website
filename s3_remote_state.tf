resource "aws_s3_bucket" "s3_remote_state_bucket" {
    bucket       = "terraform-aws-remote-state"
    acl          = "private"

    versioning {
      enabled = true
    }

    tags {
      Name        = "terraform-aws-remote-state"
      Environment = "Management"
      Owner       = "${var.owner}"
    }
}
