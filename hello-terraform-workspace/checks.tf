check "health_check" {
  assert {
    condition     = data.http.endpoint.status_code == 200
    error_message = "Health check failed: ${data.http.endpoint.id} returned ${data.http.endpoint.status_code}"
  }
  assert {
    condition     = strcontains(data.http.endpoint.response_body, "Hello")
    error_message = "Could not find expected content in response body."
  }
}
