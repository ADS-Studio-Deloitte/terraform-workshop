resource "aws_dynamodb_table" "tf_locks" {
  count        = var.dynamodb_lock_table_enabled ? 1 : 0
  name         = "${var.bucket-prefix}-${var.region}-${var.environment}-dolittle-tf-backend-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  ttl {
    attribute_name = ""
    enabled        = false
  }

  tags = {
    ManagedByTerraform = "true"
    TerraformModule    = "aws-backend"
  }


}


resource "aws_s3_bucket" "tf_backend_bucket" {
  bucket = "${var.bucket-prefix}-${var.region}-${var.environment}-dolittle-tf-backend-bucket"


  tags = merge(
    var.tags,
    {
    TerraformModule = var.resource }
  )



}

data "aws_iam_policy_document" "tf_backend_bucket_policy" {
  statement {
    sid    = "RequireEncryptedTransport"
    effect = "Deny"
    actions = [
      "s3:*",
    ]
    resources = [
      "${aws_s3_bucket.tf_backend_bucket.arn}/*",
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = [
        false,
      ]
    }
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }

  statement {
    sid    = "RequireEncryptedStorage"
    effect = "Deny"
    actions = [
      "s3:PutObject",
    ]
    resources = [
      "${aws_s3_bucket.tf_backend_bucket.arn}/*",
    ]
    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values = [
        "AES256"
      ]
    }
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "tf_backend_bucket_policy" {
  bucket = aws_s3_bucket.tf_backend_bucket.id
  policy = data.aws_iam_policy_document.tf_backend_bucket_policy.json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.tf_backend_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.tf_backend_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}