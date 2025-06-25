# Complete SNS Example

This example demonstrates the complete usage of the SNS module to create a topic with a custom policy, multiple subscriptions, and tags.

## Usage

To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

## Requirements

| Name      | Version |
|-----------|---------|
| terraform | >= 1.0  |
| aws       | >= 4.0  |

## Providers

| Name | Version |
|------|---------|
| aws  | >= 4.0  |

## Resources Created

This example will create:

* An SNS topic with:
  * Custom topic policy (allowing CloudWatch to publish)
  * Multiple subscriptions (email, Lambda, etc.)
  * Tags for environment and project

## Inputs

All values are pre-configured in the `main.tf` file for this example. See the module's documentation for all available variables.

## Outputs

| Name             | Description                        |
|------------------|------------------------------------|
| topic_arn        | The ARN of the SNS topic           |
| topic_name       | The name of the SNS topic          |
| topic_id         | The ID of the SNS topic            |
| subscription_arns| Map of subscription ARNs           |

---

*This example is maintained by Senora.dev.* 