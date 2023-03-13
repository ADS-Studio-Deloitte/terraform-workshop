output "sqs_names" {
  value = {
    for key, value in module.sqs_queues : key => value.queue_arn
  }
}