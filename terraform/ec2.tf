# 사용자 데이터 스크립트 (서버 초기 설정)
locals {
  user_data = base64encode(templatefile("${path.module}/user-data.sh", {
    project_name = var.project_name
  }))
}

# EC2 인스턴스
resource "aws_instance" "wonderwander_dev" {
  ami                    = local.ubuntu_ami_id
  instance_type          = var.instance_type
  key_name              = aws_key_pair.wonderwander_dev.key_name
  vpc_security_group_ids = [aws_security_group.wonderwander_web_sg.id]
  subnet_id             = aws_subnet.public_subnet.id
  user_data             = local.user_data

  # 루트 볼륨 설정 (프리티어 30GB)
  root_block_device {
    volume_type = "gp3"
    volume_size = 20  # GB (프리티어 한도 내)
    encrypted   = true
  }

  # 인스턴스 메타데이터 보안 설정
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
    http_put_response_hop_limit = 1
  }

  tags = {
    Name        = "${var.project_name}-dev-server"
    Environment = var.environment
    Project     = var.project_name
    Type        = "development"
  }
}

# Elastic IP 할당
resource "aws_eip" "wonderwander_dev_eip" {
  instance = aws_instance.wonderwander_dev.id
  domain   = "vpc"

  tags = {
    Name        = "${var.project_name}-dev-eip"
    Environment = var.environment
  }

  depends_on = [aws_internet_gateway.wonderwander_igw]
}