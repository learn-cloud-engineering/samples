output "website_url" {
  value       = "http://${aws_s3_bucket_website_configuration.site_website.website_endpoint}"
  description = "The URL of the static website."
}

output "api_invoke_url" {
  value       = "${aws_api_gateway_stage.prod.invoke_url}/movies"
  description = "The invoke URL for the /movies endpoint."
}
