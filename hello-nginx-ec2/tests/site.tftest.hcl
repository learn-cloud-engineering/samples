variables {
  region = "us-east-1"
}

run "deploy_static_site" {
  command = apply

  assert {
    condition     = data.http.endpoint.status_code == 200
    error_message = "Expected website to return status 200, but got ${data.http.endpoint.status_code}."
  } 
}

run "verify_site_content" {
  command = apply

  assert {
    condition     = strcontains(data.http.endpoint.response_body, "Hello World")
    error_message = "Should have correct title."
  }

  assert {
    condition     = strcontains(data.http.endpoint.response_body, "Server")
    error_message = "Should have correct body content."
  }

  assert {
    condition     = strcontains(data.http.endpoint.response_body, "172.17.0.2:80")
    error_message = "Should have correct container private IP address."
  }
}