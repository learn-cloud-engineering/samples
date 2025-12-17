resource "random_pet" "bucket_name" {
  length = 4
}

resource "aws_s3_bucket" "site_bucket" {
  bucket = "hello-static-site-${random_pet.bucket_name.id}"

  tags = {
    Name = "hello-static-site"
  }
}

resource "aws_s3_object" "index_page" {
  bucket       = aws_s3_bucket.site_bucket.id
  key          = "index.html"
  source       = "site/index.html"
  content_type = "text/html"
  
  # The file's MD5 hash changes when the file is modified.
  # This ensures that Terraform will detect the change and re-upload the file.
  etag = filemd5("site/index.html")
}
