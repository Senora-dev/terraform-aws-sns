variable "name" {
  description = "The name of the SNS topic"
  type        = string
}

variable "display_name" {
  description = "The display name for the SNS topic"
  type        = string
  default     = null
}

variable "fifo_topic" {
  description = "Boolean indicating whether or not to create a FIFO (first-in-first-out) topic"
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Boolean indicating whether or not to enable content-based deduplication for FIFO topics"
  type        = bool
  default     = false
}

variable "kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "create_topic_policy" {
  description = "Whether to create a topic policy"
  type        = bool
  default     = false
}

variable "topic_policy" {
  description = "The fully-formed AWS policy as JSON"
  type        = string
  default     = null
}

variable "subscriptions" {
  description = "Map of subscriptions to create"
  type = map(object({
    protocol              = string
    endpoint              = string
    filter_policy         = optional(map(list(string)))
    raw_message_delivery  = optional(bool, false)
  }))
  default = {}
} 