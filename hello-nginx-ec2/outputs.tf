locals {
  igw_attached_vpc_ids = [
    for attachment in data.aws_internet_gateway.default.attachments : attachment.vpc_id
  ]
}

output "public_ip" {
  description = "The public IP address of the web server."
  value       = aws_instance.server.public_ip
}

output "private_ip" {
  description = "The private IP address of the web server."
  value       = aws_instance.server.private_ip
}

output "vpc_id" {
  description = "The default VPC id."
  value = data.aws_vpc.default.id
}

output "igw_attached_vpc_ids" {
  description = "List of all VPC ids attached to the internet gateway."
  value = [
    for attachment in data.aws_internet_gateway.default.attachments : attachment.vpc_id
  ]
}
