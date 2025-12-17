variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  
  validation {
    condition = contains([
      "ap-southeast-1", # Singapore
      "us-east-1",      # North Virginia
      "me-south-1",     # Bahrain
    ], var.region)
    error_message = "💁 Region must be either ap-southeast-1, me-south-1, or us-east-1."
  }
}

variable "instance_type" {
  default = "t3.micro"
  description = "Free tier eligible instance type"
  type        = string
}
