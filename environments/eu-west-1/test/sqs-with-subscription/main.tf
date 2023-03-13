data "aws_sns_topic" "dolittle_topic" {
  name = var.topic_name
}

module "sqs_queues" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "4.0.1"
  for_each = toset(var.queue_name_list)
  name = "${var.project}-${each.value}-${var.region}-${var.environment}-queue"
  tags = var.tags
}

locals {
  queues = { for queue in var.queue_name_list : queue => module.sqs_queues[queue].queue_arn }
}

resource "aws_sns_topic_subscription" "topic_subscription" {
  for_each = local.queues
  endpoint  = each.value
  protocol  = "sqs"
  topic_arn = data.aws_sns_topic.dolittle_topic.arn
}