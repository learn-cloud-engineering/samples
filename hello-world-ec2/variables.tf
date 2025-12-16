# You can change this to your preferred region
variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string

  validation {
    condition = contains([
      "ap-southeast-1", # Singapore
      "me-south-1",     # Bahrain
      "us-east-1",      # North Virginia
    ], var.region)
    error_message = "💁 Region must be either ap-southeast-1, me-south-1, or us-east-1."
  }
}

variable "instance_type" {
  default     = "t3.micro"
  description = "Free tier eligible instance type"
  type        = string

  validation {
    condition = (var.instance_type == "t3.micro")
    error_message = "value"
  }
}
