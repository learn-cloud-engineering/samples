variables {
  region = "us-east-1"
}

test {
  parallel = true
}

run "ensure_free_tier_instance_type" {
  command = plan

  assert {
    error_message = "EC2 instance must use the free tier t3.micro instance type."
    condition     = aws_instance.server.instance_type == "t3.micro"
  }

}

run "ensure_instance_has_name_tag" {
  command = plan
  
  assert {
    error_message = "EC2 instance must have a Name tag."
    condition     = length(aws_instance.server.tags.Name) > 0
  }
}

run "ensure_security_group_has_name_tag" {
  command = plan
  
  assert {
    error_message = "Security Group must have a Name tag."
    condition = length(aws_security_group.server_sg.tags.Name) > 0
  }
  
  assert {
    error_message = "Security Group Name tag must be `${aws_instance.server.tags.Name}-sg` but got `${aws_security_group.server_sg.tags.Name}` instead."
    condition = aws_security_group.server_sg.tags.Name == "${aws_instance.server.tags.Name}-sg"
  }
}