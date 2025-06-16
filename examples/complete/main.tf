provider "aws" {
  region = "us-east-1"
}

module "sns" {
  source = "../../"

  name         = "my-topic"
  display_name = "My Topic"
  fifo_topic   = false

  create_topic_policy = true
  topic_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudwatch.amazonaws.com"
        }
        Action = [
          "SNS:Publish"
        ]
        Resource = "*"
      }
    ]
  })

  subscriptions = {
    email = {
      protocol = "email"
      endpoint = "user@example.com"
    }
    lambda = {
      protocol = "lambda"
      endpoint = "arn:aws:lambda:us-east-1:639138615159:function:my-function"
      filter_policy = {
        event_type = ["ALARM", "OK"]
      }
    }
  }

  tags = {
    Environment = "production"
    Project     = "my-project"
  }
} 