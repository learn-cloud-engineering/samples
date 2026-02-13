variables {
  region = "us-east-1"
}

run "verify_status_code_200" {
  command = apply

  assert {
    condition     = data.http.endpoint.status_code == 200
    error_message = "Expected website to return status 200, but got ${data.http.endpoint.status_code}."
  } 
}

run "verify_site_content" {
  command = apply

  assert {
    condition     = strcontains(data.http.endpoint.response_body, "Hello, Static Site on S3!")
    error_message = "Expected correct heading in site content."
  }
}
