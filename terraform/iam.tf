# IAM 정책 생성
resource "aws_iam_policy" "wonderwander_ec2_policy" {
  name        = "${var.project_name}-ec2-minimal-policy"
  description = "Minimal EC2 permissions for WonderWander Terraform"
  policy      = file("${path.module}/iam-policies/ec2-minimal-policy.json")

  tags = {
    Name        = "${var.project_name}-ec2-policy"
    Environment = var.environment
  }
}

resource "aws_iam_policy" "wonderwander_vpc_policy" {
  name        = "${var.project_name}-vpc-minimal-policy"
  description = "Minimal VPC permissions for WonderWander Terraform"
  policy      = file("${path.module}/iam-policies/vpc-minimal-policy.json")

  tags = {
    Name        = "${var.project_name}-vpc-policy"
    Environment = var.environment
  }
}

resource "aws_iam_policy" "wonderwander_rds_policy" {
  name        = "${var.project_name}-rds-minimal-policy"
  description = "Minimal RDS permissions for WonderWander"
  policy      = file("${path.module}/iam-policies/rds-minimal-policy.json")

  tags = {
    Name        = "${var.project_name}-rds-policy"
    Environment = var.environment
  }
}

resource "aws_iam_policy" "wonderwander_s3_policy" {
  name        = "${var.project_name}-s3-minimal-policy"
  description = "Minimal S3 permissions for WonderWander"
  policy      = file("${path.module}/iam-policies/s3-minimal-policy.json")

  tags = {
    Name        = "${var.project_name}-s3-policy"
    Environment = var.environment
  }
}

resource "aws_iam_policy" "wonderwander_cloudwatch_policy" {
  name        = "${var.project_name}-cloudwatch-logs-policy"
  description = "CloudWatch Logs permissions for WonderWander"
  policy      = file("${path.module}/iam-policies/cloudwatch-logs-policy.json")

  tags = {
    Name        = "${var.project_name}-cloudwatch-policy"
    Environment = var.environment
  }
}

# IAM 사용자 생성
resource "aws_iam_user" "terraform_user" {
  name = "${var.project_name}-terraform-user"
  path = "/"

  tags = {
    Name        = "${var.project_name}-terraform-user"
    Environment = var.environment
    Purpose     = "Terraform automation"
  }
}

# 정책 연결
resource "aws_iam_user_policy_attachment" "ec2_policy_attachment" {
  user       = aws_iam_user.terraform_user.name
  policy_arn = aws_iam_policy.wonderwander_ec2_policy.arn
}

resource "aws_iam_user_policy_attachment" "vpc_policy_attachment" {
  user       = aws_iam_user.terraform_user.name
  policy_arn = aws_iam_policy.wonderwander_vpc_policy.arn
}

resource "aws_iam_user_policy_attachment" "rds_policy_attachment" {
  user       = aws_iam_user.terraform_user.name
  policy_arn = aws_iam_policy.wonderwander_rds_policy.arn
}

resource "aws_iam_user_policy_attachment" "s3_policy_attachment" {
  user       = aws_iam_user.terraform_user.name
  policy_arn = aws_iam_policy.wonderwander_s3_policy.arn
}

resource "aws_iam_user_policy_attachment" "cloudwatch_policy_attachment" {
  user       = aws_iam_user.terraform_user.name
  policy_arn = aws_iam_policy.wonderwander_cloudwatch_policy.arn
}

# Access Key 생성 (주의: 출력됨)
resource "aws_iam_access_key" "terraform_user_key" {
  user = aws_iam_user.terraform_user.name
}