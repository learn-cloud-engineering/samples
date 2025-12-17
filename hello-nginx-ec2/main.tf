resource "aws_instance" "server" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.server_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              # Install Docker
              yum update -y
              yum install -y docker
              
              # Start and enable Docker service
              systemctl start docker
              systemctl enable docker
              
              # Add default user to the docker group to run docker without sudo
              usermod -a -G docker ec2-user
              
              # Pull and run image
              docker run -d -p 80:80 --name hello-nginx nginxdemos/hello
              EOF

  tags = {
    Name = "hello-nginx"
  }
}
