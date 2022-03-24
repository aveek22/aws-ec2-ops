locals {
  lambda-zip-location = "../build/lambda.zip"
}

data "archive_file" "lambda" {
  type = "zip"
  source_dir = "../lambda-function/"
  output_path = local.lambda-zip-location
}

resource "aws_lambda_function" "ec2_ops_lambda_function" {
  filename = local.lambda-zip-location
  function_name = "ec2_ops_lambda_function"
  role = aws_iam_role.ec2_ops_lambda_role.arn
  handler = "app.main"
  source_code_hash = "${data.archive_file.lambda.output_base64sha256}"
  runtime          = "python3.9"
  timeout          =  90

  tags = {
    Application = "ec2_ops"
  }
}