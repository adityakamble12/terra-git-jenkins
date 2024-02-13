
resource "aws_sns_topic" "example_topic" {
  name = "example-topic"
  display_name = "Example SNS Topic"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "SNS:Publish",
      "Resource": "*"
    }
  ]
}
POLICY

  delivery_policy = <<POLICY
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 1,
      "maxDelayTarget": 60,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1,
      "maxReceivesPerMinute": 60
    }
  }
}
POLICY

  redrive_policy = <<POLICY
{
  "deadLetterTargetArn": "${aws_sqs_queue.example_deadletter_queue.arn}",
  "maxReceiveCount": 5
}
POLICY

  kms_master_key_id = aws_kms_key.example_key.id

  content_based_deduplication = true
  fifo_queue                  = false
  application_success_feedback_role_arn = aws_iam_role.example_role.arn
  application_failure_feedback_role_arn = aws_iam_role.example_role.arn
  raw_message_delivery        = false
  tags = {
    Environment = "Production"
    Team        = "DevOps"
  }
}

resource "aws_sqs_queue" "example_deadletter_queue" {
  name = "example-deadletter-queue"
}

resource "aws_kms_key" "example_key" {
  description             = "Example KMS Key"
  deletion_window_in_days = 10
  is_enabled              = true
}

resource "aws_iam_role" "example_role" {
  name = "sns-example-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "sns.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_sns_topic_subscription" "example_subscription" {
  topic_arn = aws_sns_topic.example_topic.arn
  protocol  = "email"
  endpoint  = "you@example.com"
}
