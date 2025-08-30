# AWS 리전 설정
variable "aws_region" {
  description = "AWS 리전"
  type        = string
  default     = "ap-northeast-2"  # 서울 리전
}

# 인스턴스 타입
variable "instance_type" {
  description = "EC2 인스턴스 타입"
  type        = string
  default     = "t2.micro"  # 프리티어
}

# 환경 태그
variable "environment" {
  description = "배포 환경"
  type        = string
  default     = "development"
}

# 프로젝트 이름
variable "project_name" {
  description = "프로젝트 이름"
  type        = string
  default     = "wonderwander"
}

# 허용할 SSH IP 주소 (본인 IP로 변경 필요)
variable "allowed_ssh_cidr" {
  description = "SSH 접속을 허용할 IP 주소 (CIDR 형식)"
  type        = string
  default     = "0.0.0.0/0"  # 보안상 본인 IP로 변경 권장
}

# RDS 설정 (옵션)
variable "db_username" {
  description = "RDS 데이터베이스 사용자명"
  type        = string
  default     = "wonderwander"
  sensitive   = true
}

variable "db_password" {
  description = "RDS 데이터베이스 비밀번호"
  type        = string
  default     = ""  # terraform.tfvars에서 설정
  sensitive   = true
}