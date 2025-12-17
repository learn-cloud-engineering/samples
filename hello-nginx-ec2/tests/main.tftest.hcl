variables {
  region = "us-east-1"
}

run "verify_minimum_requirements" {
  command = plan

  assert {
    error_message = "EC2 instance must use the free tier t3.micro instance type."
    condition     = aws_instance.server.instance_type == "t3.micro"
  }

  assert {
    error_message = "EC2 instance must have a Name tag."
    condition     = length(aws_instance.server.tags.Name) > 0
  }

  assert {
    error_message = "Security Group must have a Name tag."
    condition = length(aws_security_group.server_sg.tags.Name) > 0
  }
  
  assert {
    error_message = "Security Group Name tag must be `${aws_instance.server.tags.Name}-sg` but got `${aws_security_group.server_sg.tags.Name}` instead."
    condition = aws_security_group.server_sg.tags.Name == "${aws_instance.server.tags.Name}-sg"
  }
}