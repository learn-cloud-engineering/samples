data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "http" "endpoint" {
  url = "http://${aws_instance.server.public_ip}"

  retry {
    attempts     = 5
    min_delay_ms = 5000
  }
}
