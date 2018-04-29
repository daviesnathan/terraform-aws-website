/*
  name: dns_zone
  purpose: Sets the zone id for use by aws_route53_record resources. Passed in
           from module declaration in the higher level.
*/
variable "dns_zone" {}

/*
  name: owner
  purpose: Sets the resource owner tags. Passed in from module declaration.
*/
variable "owner" {}
