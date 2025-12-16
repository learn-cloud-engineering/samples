variables {
  bucket_prefix = "test"
}

run "verify_minimum_requirements" {
  command = plan

  assert {
    error_message = "EC2 instance must use the free tier t3.micro instance type."
    condition     = aws_instance.web_server.instance_type == "t3.micro"
  }

  assert {
    error_message = "EC2 instance must have a Name tag."
    condition     = length(aws_instance.web_server.tags.Name) > 0
  }

  assert {
    error_message = "Security Group must have a Name tag."
    condition = length(aws_security_group.web_server_sg.tags.Name) > 0
  }
}