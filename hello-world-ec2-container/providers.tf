provider "aws" {
  region = var.region
  
  default_tags {
    tags = {
      ManagedBy = "Terraform"
      SourceRepo = "https://github.com/learn-cloud-engineering/samples" 
    }
  }
}
