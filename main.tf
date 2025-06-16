resource "aws_sns_topic" "this" {
  name                        = var.name
  display_name                = var.display_name
  fifo_topic                  = var.fifo_topic
  content_based_deduplication = var.content_based_deduplication
  kms_master_key_id          = var.kms_master_key_id
  tags                       = var.tags
}

resource "aws_sns_topic_policy" "this" {
  count  = var.create_topic_policy ? 1 : 0
  arn    = aws_sns_topic.this.arn
  policy = var.topic_policy
}

resource "aws_sns_topic_subscription" "this" {
  for_each = var.subscriptions

  topic_arn = aws_sns_topic.this.arn
  protocol  = each.value.protocol
  endpoint  = each.value.endpoint
  filter_policy = each.value.filter_policy != null ? jsonencode(each.value.filter_policy) : null
  raw_message_delivery = each.value.raw_message_delivery
} 