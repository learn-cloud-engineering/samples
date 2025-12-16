# You can change this to your preferred region
variable "region" {
  default     = "us-east-1"
  description = "The AWS region to deploy resources in"
  type        = string

  validation {
    condition = contains([
      "ap-southeast-1", # Singapore
      "us-east-1",      # North Virginia
      "me-south-1",     # Bahrain
    ], var.region)
    error_message = "Error: Not a valid region."
  }
}

variable "instance_type" {
  default     = "t3.micro"
  description = "Free tier eligible instance type"
  type        = string
}
