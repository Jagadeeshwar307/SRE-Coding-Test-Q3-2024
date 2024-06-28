provider "aws" {
  region = "us-west-2" # Change to your desired region
}

resource "aws_instance" "SumoLogic" {
  ami           = "ami-01572eda7c4411960" # Amazon Linux 2 AMI in us-west-2
  instance_type = "t2.micro"
  tags = {
    Name = "SumoLogic"
  }
}

resource "aws_sns_topic" "SumoQuery1" {
  name = "SumoQuery1-sns-topic"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  name   = "lambda-policy"
  role   = aws_iam_role.lambda_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ec2:RebootInstances",
          "logs:*",
          "sns:Publish"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_lambda_function" "SumoQueryFunction" {
  filename         = "SumoQuery.zip"
  function_name    = "SumoQueryFunction"
  role             = aws_iam_role.lambda_role.arn
  handler          = "SumoQuery.Sumo_Logic"
  runtime          = "python3.8"
  source_code_hash = filebase64sha256("SumoQuery.zip")
}

resource "aws_lambda_permission" "SNSpolicy" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.SumoQueryFunction.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.SumoQuery1.arn
}

resource "aws_sns_topic_subscription" "SumoQuery1" {
  topic_arn = aws_sns_topic.SumoQuery1.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.SumoQueryFunction.arn

  depends_on = [aws_lambda_permission.SNSpolicy]
}

output "instance_id" {
  value = aws_instance.SumoLogic.id
}

output "sns_topic_arn" {
  value = aws_sns_topic.SumoQuery1.arn
}

output "lambda_function_name" {
  value = aws_lambda_function.SumoQueryFunction.function_name
}
