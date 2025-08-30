#!/bin/bash

# 시스템 업데이트
apt-get update
apt-get upgrade -y

# 필수 패키지 설치
apt-get install -y \
    curl \
    wget \
    unzip \
    git \
    htop \
    vim \
    ufw

# Docker 설치
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker ubuntu

# Docker Compose 설치
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# 방화벽 설정
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 8080/tcp
ufw --force enable

# 스왑 파일 생성 (메모리 부족 방지)
fallocate -l 1G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab

# 배포 디렉토리 생성
mkdir -p /home/ubuntu/deploy
chown ubuntu:ubuntu /home/ubuntu/deploy

# 배포 스크립트 생성
cat > /home/ubuntu/deploy/deploy.sh << 'EOF'
#!/bin/bash
set -e

echo "🚀 Starting deployment..."

# 기존 컨테이너 정리
docker stop wonderwander-dev || true
docker rm wonderwander-dev || true

# 이전 이미지 정리 (디스크 공간 절약)
docker image prune -f

# 새 이미지 pull
echo "📦 Pulling new image: $IMAGE_TAG"
docker pull $IMAGE_TAG

# 컨테이너 실행
echo "🏃 Starting new container..."
docker run -d \
  --name wonderwander-dev \
  --restart unless-stopped \
  -p 8080:8080 \
  -e SPRING_PROFILES_ACTIVE=dev \
  $IMAGE_TAG

# 헬스체크
echo "🏥 Checking application health..."
sleep 10
for i in {1..30}; do
  if curl -f http://localhost:8080/actuator/health > /dev/null 2>&1; then
    echo "✅ Application is healthy!"
    exit 0
  fi
  echo "⏳ Waiting for application to start... ($i/30)"
  sleep 5
done

echo "❌ Application failed to start properly"
docker logs wonderwander-dev
exit 1
EOF

chmod +x /home/ubuntu/deploy/deploy.sh
chown ubuntu:ubuntu /home/ubuntu/deploy/deploy.sh

# 로그 로테이션 설정
cat > /etc/logrotate.d/docker << 'EOF'
/var/lib/docker/containers/*/*.log {
    rotate 7
    daily
    compress
    size=1M
    missingok
    delaycompress
    copytruncate
}
EOF

# 시스템 재시작 시 Docker 자동 시작
systemctl enable docker

echo "✅ Server setup completed!"