variables {
  region = "us-east-1"
}

run "deploy_static_site" {
  command = apply

  assert {
    condition     = data.http.endpoint.status_code == 200
    error_message = "Expected website to return status 200, but got ${data.http.endpoint.status_code}."
  }

  assert {
    condition     = strcontains(data.http.endpoint.response_body, "Hello")
    error_message = "The response body did not contain the expected content."
  }
}
