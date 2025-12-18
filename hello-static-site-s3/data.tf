data "http" "endpoint" {
  url        = "http://${aws_s3_bucket_website_configuration.site_website.website_endpoint}"
  depends_on = [aws_s3_bucket_policy.allow_public_read]
}
