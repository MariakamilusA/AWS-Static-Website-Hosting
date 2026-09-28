# main.tf
provider "aws" {
  region = "us-east-1" # Change this to your preferred region
}

# Generate a random string to make the bucket name unique
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Create an S3 bucket for the static website
resource "aws_s3_bucket" "static_website" {
  bucket = "codtech-static-web-${random_id.bucket_suffix.hex}"
}

# Configure the bucket for static website hosting
resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.static_website.id

  index_document {
    suffix = "index.html"
  }
}

# Disable Block Public Access so the bucket can be public
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.static_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Add a bucket policy to allow public read access
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.static_website.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_website.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.public_access]
}

# Upload index.html
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.static_website.id
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"
}

# Upload styles.css
resource "aws_s3_object" "styles" {
  bucket       = aws_s3_bucket.static_website.id
  key          = "styles.css"
  source       = "styles.css"
  content_type = "text/css"
}

# Upload script.js
resource "aws_s3_object" "script" {
  bucket       = aws_s3_bucket.static_website.id
  key          = "script.js"
  source       = "script.js"
  content_type = "application/javascript"
}

# Output the website URL
output "website_endpoint" {
  description = "The URL of the static website"
  value       = aws_s3_bucket_website_configuration.website_config.website_endpoint
}
