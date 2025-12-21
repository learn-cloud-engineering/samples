output "api_url" {
  description = "The URL to invoke the movies API"
  value       = "${aws_api_gateway_stage.prod.invoke_url}/movies"
}
