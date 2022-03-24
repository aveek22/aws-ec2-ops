resource "aws_iam_role_policy" "ec2_ops_lambda_policy" {
  name = "ec2_ops_lambda_policy"
  role = aws_iam_role.ec2_ops_lambda_role.id

  policy = file("../terraform/iam-role/lambda-policy.json")
}

resource "aws_iam_role" "ec2_ops_lambda_role" {
  name = "ec2_ops_lambda_role"
  assume_role_policy = file("../terraform/iam-role/lambda-assume-policy.json")

  tags = {
    Application = "ec2_ops"
  }
}