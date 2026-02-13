output "website_url" {
  value       = "http://${aws_s3_bucket_website_configuration.site_website.website_endpoint}"
  description = "The URL of the static website."
}
