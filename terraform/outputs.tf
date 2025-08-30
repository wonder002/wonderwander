# 출력 값들
output "instance_id" {
  description = "EC2 인스턴스 ID"
  value       = aws_instance.wonderwander_dev.id
}

output "instance_public_ip" {
  description = "EC2 인스턴스 공개 IP (Elastic IP)"
  value       = aws_eip.wonderwander_dev_eip.public_ip
}

output "instance_public_dns" {
  description = "EC2 인스턴스 공개 DNS"
  value       = aws_instance.wonderwander_dev.public_dns
}

output "ssh_connection_command" {
  description = "SSH 접속 명령어"
  value       = "ssh -i ~/.ssh/wonderwander-dev ubuntu@${aws_eip.wonderwander_dev_eip.public_ip}"
}

output "application_url" {
  description = "애플리케이션 접속 URL"
  value       = "http://${aws_eip.wonderwander_dev_eip.public_ip}:8080"
}

output "health_check_url" {
  description = "헬스체크 URL"
  value       = "http://${aws_eip.wonderwander_dev_eip.public_ip}:8080/actuator/health"
}

# GitHub Secrets에 추가할 정보
output "github_secrets" {
  description = "GitHub Repository Secrets에 추가할 정보"
  value = {
    DEV_HOST     = aws_eip.wonderwander_dev_eip.public_ip
    DEV_USERNAME = "ubuntu"
    DEV_PORT     = "22"
    DEV_SSH_KEY  = "~/.ssh/wonderwander-dev 파일의 private key 내용을 복사하세요"
  }
  sensitive = false
}

# IAM 사용자 정보 (민감)
output "iam_access_key_id" {
  description = "IAM Access Key ID (AWS CLI 설정용)"
  value       = aws_iam_access_key.terraform_user_key.id
  sensitive   = true
}

output "iam_secret_access_key" {
  description = "IAM Secret Access Key (AWS CLI 설정용)"
  value       = aws_iam_access_key.terraform_user_key.secret
  sensitive   = true
}

# 보안 정책 ARN들
output "policy_arns" {
  description = "생성된 IAM 정책 ARN들"
  value = {
    ec2_policy        = aws_iam_policy.wonderwander_ec2_policy.arn
    vpc_policy        = aws_iam_policy.wonderwander_vpc_policy.arn
    rds_policy        = aws_iam_policy.wonderwander_rds_policy.arn
    s3_policy         = aws_iam_policy.wonderwander_s3_policy.arn
    cloudwatch_policy = aws_iam_policy.wonderwander_cloudwatch_policy.arn
  }
}