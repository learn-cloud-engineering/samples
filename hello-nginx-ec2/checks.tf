check "health_check" {
  data "http" "endpoint" {
    url = "http://${aws_instance.server.public_ip}"
  }

  assert {
    condition     = data.http.endpoint.status_code == 200
    error_message = "Health check failed: ${data.http.endpoint.url} returned ${data.http.endpoint.status_code}"
  }
}
