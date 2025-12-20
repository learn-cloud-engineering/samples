variables {
  region = "us-east-1"
}

run "verify_igw_is_attached_to_default_vpc" {
  command = apply

  assert {
    error_message = "No VPCs are attached to the internet gateway."
    condition     = length(data.aws_internet_gateway.default.attachments) > 0
  }

  assert {
    error_message = "The default VPC is not attached to the internet gateway."
    condition     = contains(local.igw_attached_vpc_ids, data.aws_vpc.default.id)
  }
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
    condition     = strcontains(data.http.endpoint.response_body, "Hello World")
    error_message = "Should have correct title."
  }

  assert {
    condition     = strcontains(data.http.endpoint.response_body, "Server")
    error_message = "Should have correct body content."
  }

  assert {
    condition     = can(regex("172.17.\\d{1,3}.\\d{1,3}:80", data.http.endpoint.response_body))
    error_message = "The response body did not contain a valid container IP in the 172.17.x.x:80 range."
  }
}
