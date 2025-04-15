resource "aws_s3_bucket" "static_website" {
  bucket = "${local.prefix}-web-host"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  # object_ownership = "BucketOwnerEnforced"
}

resource "aws_s3_bucket_public_access_block" "static_website" {
  bucket = aws_s3_bucket.static_website.bucket

  block_public_acls   = false
  block_public_policy = false
  ignore_public_acls  = false
  restrict_public_buckets = false
}

/* resource "aws_s3_bucket_policy" "static_website_policy" {
  bucket = aws_s3_bucket.static_website.bucket
  policy = templatefile("${path.module}/bucket_policy/web_hosting.json", { 
    bucket_name = aws_s3_bucket.static_website.bucket
  })
} */
