resource "aws_cloudwatch_event_rule" "ec2_ops_lambda_event_rule" {
  name = "ec2_ops_lambda_event_rule"
  description = "Start and stop EC2 machines"
  schedule_expression = "cron(0 19 * * ? *)"
}

resource "aws_cloudwatch_event_target" "ec2_ops_lambda_target" {
  arn = aws_lambda_function.ec2_ops_lambda_function.arn
  rule = aws_cloudwatch_event_rule.ec2_ops_lambda_event_rule.name
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ec2_ops_lambda_function.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.ec2_ops_lambda_event_rule.arn
}
