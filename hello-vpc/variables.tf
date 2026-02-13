variable "name_prefix" {
  default = "ce"
  type    = string
}

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
