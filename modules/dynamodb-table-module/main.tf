resource "aws_dynamodb_table" "hello-table" {
  name         = "${var.project}-${var.special_name}-${var.region}-${var.environment}-hello-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"
  range_key    = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }

  tags = var.tags
}