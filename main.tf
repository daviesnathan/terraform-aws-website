terraform {
  backend "s3" {
    bucket = "terraform-aws-remote-state"
    key = "terraform-aws-website.tfstate"
    region = "eu-west-1"
  }
}

variable "owner" {
  default = "Not defined."
}

variable "deploy_key" {
  default = "Not defined."
}

provider "aws" {}

module "cloudfront" {
  dns_zone = "Z2TMUMYK9QCMW0"
  owner = "${var.owner}"
  source   = "./cloudfront"
}

module "ec2" {
  deploy_key = "${var.deploy_key}"
  dns_zone = "Z2TMUMYK9QCMW0"
  owner = "${var.owner}"
  source = "./ec2"
}
