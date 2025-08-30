# VPC 생성
resource "aws_vpc" "wonderwander_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.project_name}-vpc"
    Environment = var.environment
  }
}

# 인터넷 게이트웨이
resource "aws_internet_gateway" "wonderwander_igw" {
  vpc_id = aws_vpc.wonderwander_vpc.id

  tags = {
    Name        = "${var.project_name}-igw"
    Environment = var.environment
  }
}

# 퍼블릭 서브넷
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.wonderwander_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-public-subnet"
    Environment = var.environment
  }
}

# 라우팅 테이블
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.wonderwander_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wonderwander_igw.id
  }

  tags = {
    Name        = "${var.project_name}-public-rt"
    Environment = var.environment
  }
}

# 서브넷과 라우팅 테이블 연결
resource "aws_route_table_association" "public_rta" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}