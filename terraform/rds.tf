# RDS 서브넷 그룹 (옵션 - 필요시 주석 해제)
# resource "aws_db_subnet_group" "wonderwander_db_subnet_group" {
#   name       = "${var.project_name}-db-subnet-group"
#   subnet_ids = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]

#   tags = {
#     Name        = "${var.project_name}-db-subnet-group"
#     Environment = var.environment
#   }
# }

# # RDS 보안 그룹
# resource "aws_security_group" "wonderwander_rds_sg" {
#   name        = "${var.project_name}-rds-sg"
#   description = "Security group for WonderWander RDS"
#   vpc_id      = aws_vpc.wonderwander_vpc.id

#   # PostgreSQL 포트 (5432) - EC2에서만 접근 허용
#   ingress {
#     description     = "PostgreSQL from EC2"
#     from_port       = 5432
#     to_port         = 5432
#     protocol        = "tcp"
#     security_groups = [aws_security_group.wonderwander_web_sg.id]
#   }

#   tags = {
#     Name        = "${var.project_name}-rds-sg"
#     Environment = var.environment
#   }
# }

# # RDS PostgreSQL 인스턴스 (프리티어)
# resource "aws_db_instance" "wonderwander_postgres" {
#   identifier                = "${var.project_name}-postgres-dev"
#   allocated_storage         = 20  # 20GB (프리티어)
#   max_allocated_storage     = 20  # 자동 확장 방지
#   storage_type              = "gp2"
#   engine                    = "postgres"
#   engine_version            = "15.4"
#   instance_class            = "db.t3.micro"  # 프리티어
#   db_name                   = "wonderwander"
#   username                  = var.db_username
#   password                  = var.db_password
#   parameter_group_name      = "default.postgres15"
#   db_subnet_group_name      = aws_db_subnet_group.wonderwander_db_subnet_group.name
#   vpc_security_group_ids    = [aws_security_group.wonderwander_rds_sg.id]
  
#   backup_retention_period   = 7
#   backup_window            = "03:00-04:00"
#   maintenance_window       = "sun:04:00-sun:05:00"
  
#   skip_final_snapshot      = true  # 개발환경이므로 스냅샷 생략
#   deletion_protection      = false # 개발환경이므로 삭제 보호 해제
  
#   publicly_accessible      = false # 보안상 비공개
#   storage_encrypted        = true

#   tags = {
#     Name        = "${var.project_name}-postgres-dev"
#     Environment = var.environment
#   }
# }