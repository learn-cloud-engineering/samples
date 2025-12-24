variables {
  region = "us-east-1"
}

run "verify_status_code_200" {
  command = apply

  assert {
    condition     = data.http.endpoint.status_code == 200
    error_message = "Should return status 200, but got ${data.http.endpoint.status_code}."
  } 
}

run "verify_movie_data_in_response_body" {
  command = apply

  assert {
    condition = strcontains(data.http.endpoint.response_body, "Inception")
    error_message = "Should find a movie title in response body."
  }
}
