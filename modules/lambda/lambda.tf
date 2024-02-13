
resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_lambda_function" "example_lambda" {
  function_name    = "example_lambda_function"
  description      = "Example Lambda Function"
  handler          = "index.handler"
  runtime          = "nodejs14.x"
  role             = aws_iam_role.lambda_execution_role.arn
  filename         = "path/to/your/lambda.zip"  # Path to your Lambda deployment package
  source_code_hash = filebase64sha256("path/to/your/lambda.zip")

  memory_size          = 256
  timeout             = 10
  publish             = true
  tracing_config {
    mode = "Active"
  }

  vpc_config {
    subnet_ids         = ["subnet-xxxxxxxxxxxxxxxxx", "subnet-yyyyyyyyyyyyyyyyy"]
    security_group_ids = ["sg-xxxxxxxxxxxxxxxxx"]
  }

  environment {
    variables = {
      KEY1 = "VALUE1",
      KEY2 = "VALUE2"
    }
  }

  tags = {
    Environment = "Production"
    Team        = "DevOps"
  }

  # Optional: Uncomment the following if you want to create an API Gateway trigger for the Lambda
  # depends_on = [aws_api_gateway_rest_api.example_api]

  # Optional: Uncomment the following if you want to configure the Lambda to trigger on an S3 bucket event
  # event_source {
  #   s3_bucket = aws_s3_bucket.example_bucket.id
  #   events    = ["s3:ObjectCreated:*"]
  # }

  # Optional: Uncomment the following if you want to configure the Lambda to trigger on an SNS topic event
  # event_source {
  #   sns_topic_arn = aws_sns_topic.example_topic.arn
  #   events        = ["sns:Publish"]
  # }
}
