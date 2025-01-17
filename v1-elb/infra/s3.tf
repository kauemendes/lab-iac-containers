resource "aws_s3_bucket" "elb-depolyment-bucket" {
  bucket = "${var.name}-kauecode-deployment-bucket"
  tags = {
    Name        = "${var.name}-deployment-bucket"
    managed-by  = "terraform"
  }
}

resource "aws_s3_object" "docker-zip" {
  depends_on = [aws_s3_bucket.elb-depolyment-bucket]
  bucket = "${var.name}-kauecode-deployment-bucket"
  key    = "${var.name}.zip"
  source = "${var.name}.zip"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${var.name}.zip")
}