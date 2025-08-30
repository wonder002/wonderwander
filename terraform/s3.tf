# S3 버킷 (옵션 - 파일 저장용)
# resource "aws_s3_bucket" "wonderwander_files" {
#   bucket = "${var.project_name}-files-${var.environment}-${random_id.bucket_suffix.hex}"

#   tags = {
#     Name        = "${var.project_name}-files"
#     Environment = var.environment
#   }
# }

# # 랜덤 ID (버킷명 중복 방지)
# resource "random_id" "bucket_suffix" {
#   byte_length = 4
# }

# # S3 버킷 설정
# resource "aws_s3_bucket_versioning" "wonderwander_files_versioning" {
#   bucket = aws_s3_bucket.wonderwander_files.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_encryption" "wonderwander_files_encryption" {
#   bucket = aws_s3_bucket.wonderwander_files.id

#   server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         sse_algorithm = "AES256"
#       }
#     }
#   }
# }

# resource "aws_s3_bucket_public_access_block" "wonderwander_files_pab" {
#   bucket = aws_s3_bucket.wonderwander_files.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# # CORS 설정 (필요시)
# resource "aws_s3_bucket_cors_configuration" "wonderwander_files_cors" {
#   bucket = aws_s3_bucket.wonderwander_files.id

#   cors_rule {
#     allowed_headers = ["*"]
#     allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]
#     allowed_origins = ["https://wonderwander.com", "https://dev.wonderwander.com"]
#     expose_headers  = ["ETag"]
#     max_age_seconds = 3000
#   }
# }