# AWS SNS Terraform Module

This Terraform module creates an Amazon SNS (Simple Notification Service) topic with optional subscriptions and policies.

## Features

- Create SNS topics (standard or FIFO)
- Configure topic policies
- Add multiple subscriptions with filter policies
- Support for various subscription protocols (email, SMS, HTTP/HTTPS, Lambda, etc.)
- Tagging support

## Usage

### Basic Usage

```hcl
module "sns" {
  source = "Senora-dev/sns/aws"

  name         = "my-topic"
  display_name = "My Topic"
}
```

### Complete Usage

```hcl
module "sns" {
  source = "path/to/module"

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
      endpoint = "arn:aws:lambda:us-east-1:123456789012:function:my-function"
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
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| aws | >= 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The name of the SNS topic | string | - | yes |
| display_name | The display name for the SNS topic | string | null | no |
| fifo_topic | Boolean indicating whether or not to create a FIFO topic | bool | false | no |
| content_based_deduplication | Boolean indicating whether or not to enable content-based deduplication for FIFO topics | bool | false | no |
| kms_master_key_id | The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK | string | null | no |
| tags | A map of tags to add to all resources | map(string) | {} | no |
| create_topic_policy | Whether to create a topic policy | bool | false | no |
| topic_policy | The fully-formed AWS policy as JSON | string | null | no |
| subscriptions | Map of subscriptions to create | map(object) | {} | no |

### Subscription Object

```hcl
{
  protocol              = string
  endpoint              = string
  filter_policy         = optional(map(list(string)))
  raw_message_delivery  = optional(bool, false)
}
```

## Outputs

| Name | Description |
|------|-------------|
| topic_arn | The ARN of the SNS topic |
| topic_name | The name of the SNS topic |
| topic_id | The ID of the SNS topic |
| subscription_arns | Map of subscription ARNs |

## Examples

- [Basic Example](examples/basic/main.tf) - Creates a simple SNS topic
- [Complete Example](examples/complete/main.tf) - Creates an SNS topic with policies and subscriptions

## Notes

1. For FIFO topics, the topic name must end with `.fifo`
2. When using filter policies, make sure the subscription protocol supports it
3. The `topic_policy` should be a valid JSON string containing the IAM policy
4. For Lambda subscriptions, make sure to grant the necessary permissions to the Lambda function

## License

MIT Licensed. See LICENSE for full details. 

## Maintainers

This module is maintained by [Senora.dev](https://senora.dev). 