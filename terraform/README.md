# 🚀 AWS EC2 개발 서버 배포 가이드

## 📋 단계별 실행 가이드

### 1. SSH 키 생성
```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/wonderwander-dev -C "wonderwander-dev"
```

### 2. Terraform 변수 설정
```bash
cp terraform.tfvars.example terraform.tfvars
# terraform.tfvars 파일에서 allowed_ssh_cidr를 본인 IP로 변경
```

### 3. 본인 IP 확인
```bash
curl https://ipinfo.io/ip
# 결과를 terraform.tfvars의 allowed_ssh_cidr에 "/32" 추가하여 입력
# 예: "123.456.789.123/32"
```

### 4. Terraform 실행
```bash
cd terraform
terraform init
terraform plan    # 변경사항 미리보기
terraform apply   # 실제 배포 (yes 입력)
```

### 5. 출력 정보 확인
```bash
terraform output
# SSH 명령어, IP 주소 등이 출력됩니다
```

### 6. SSH 접속 테스트
```bash
ssh -i ~/.ssh/wonderwander-dev ubuntu@[출력된-IP]
```

### 7. GitHub Secrets 설정
Terraform 출력의 `github_secrets` 정보를 사용하여 Repository Secrets 추가

## 🔧 관리 명령어

### 서버 상태 확인
```bash
terraform show
```

### 서버 중지/시작
```bash
# 중지 (비용 절약)
aws ec2 stop-instances --instance-ids [인스턴스-ID]

# 시작
aws ec2 start-instances --instance-ids [인스턴스-ID]
```

### 인프라 삭제
```bash
terraform destroy  # 모든 리소스 삭제
```

## 💰 비용 모니터링

프리티어 한도:
- t2.micro: 월 750시간
- EBS: 30GB
- 네트워크: 인바운드 무료, 아웃바운드 1GB/월

**중요**: 사용하지 않을 때는 인스턴스를 중지하세요!