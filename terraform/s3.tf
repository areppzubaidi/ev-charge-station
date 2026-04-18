resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "artifacts" {
  bucket = "ev-station-artifacts-${random_id.suffix.hex}"
  force_destroy = true
}

resource "aws_s3_bucket" "logs" {
  bucket = "ev-station-logs-${random_id.suffix.hex}"
  force_destroy = true
}

output "artifacts_bucket" {
  value = aws_s3_bucket.artifacts.bucket
}

output "logs_bucket" {
  value = aws_s3_bucket.logs.bucket
}
