# The public IP address of the EC2 instance
output "public_ip" {
  value       = aws_instance.server.public_ip
  description = "The public IP address of the server."
}
