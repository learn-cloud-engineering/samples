# Create a default VPC only if one does not already exist
resource "aws_default_vpc" "default" {
  tags = {
    Name = "default-vpc"
  }
}
