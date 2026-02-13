resource "random_pet" "bucket_name" {
  length = 2
}

resource "aws_s3_bucket" "site_bucket" {
  bucket = "hello-static-site-${random_pet.bucket_name.id}"

  tags = {
    Name = "hello-static-site"
  }
}
