resource "aws_s3_bucket_website_configuration" "site_website" {
  bucket = aws_s3_bucket.site_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "index_page" {
  bucket       = aws_s3_bucket.site_bucket.id
  key          = "index.html"
  source       = "site/index.html"
  content_type = "text/html"
  etag         = filemd5("site/index.html")
}

resource "aws_s3_object" "error_page" {
  bucket       = aws_s3_bucket.site_bucket.id
  key          = "error.html"
  source       = "site/error.html"
  content_type = "text/html"
  etag         = filemd5("site/error.html")
}

resource "aws_s3_object" "movies_js" {
  bucket       = aws_s3_bucket.site_bucket.id
  key          = "movies.js"
  source       = "site/movies.js"
  content_type = "application/javascript"
  etag         = filemd5("site/movies.js")
}

resource "aws_s3_object" "config_js" {
  bucket       = aws_s3_bucket.site_bucket.id
  key          = "config.js"
  source       = local_file.api_config_js.filename
  content_type = "application/javascript"
  etag         = local_file.api_config_js.content_md5

  depends_on = [local_file.api_config_js]
}
