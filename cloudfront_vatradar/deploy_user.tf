/*
  Define ndavies.io S3 deployment user
*/
resource "aws_iam_user" "deploy" {
  name = "vatradar_com_deploy"
}

/*
  Define S3 Policy
  This policy grants programmatic access to the deploy_user.
*/
data "aws_iam_policy_document" "s3_policy_deploy" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = ["${aws_s3_bucket.source.arn}"]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
    ]

    resources = ["${aws_s3_bucket.source.arn}/*"]
  }
}

/*
  Attach the s3_policy_deploy to the deploy user
*/
resource "aws_iam_user_policy" "deploy_policy" {
  name = "vatradar_com_deploy_s3"
  user = "${aws_iam_user.deploy.name}"

  policy = "${data.aws_iam_policy_document.s3_policy_deploy.json}"
}
