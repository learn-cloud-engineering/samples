resource "aws_s3_bucket_website_configuration" "site_website" {
  bucket = aws_s3_bucket.site_bucket.id

  index_document {
    suffix = aws_s3_object.index_page.key
  }

  error_document {
    key = aws_s3_object.error_page.key
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

resource "aws_s3_object" "error_page" {
  bucket       = aws_s3_bucket.site_bucket.id
  key          = "error.html"
  source       = "site/error.html"
  content_type = "text/html"

  # The file's MD5 hash changes when the file is modified.
  # This ensures that Terraform will detect the change and re-upload the file.
  etag = filemd5("site/error.html")
}
