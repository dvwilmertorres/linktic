provider "aws" {
  region = var.aws_region
}
# S3 Bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "bucket-linktic"
}


# Security group definition
resource "aws_security_group" "linktic" {
  name        = "linktic"
  description = "linktic_sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 4200
    to_port     = 4200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "web" {
  ami           = var.ami_redhat
  instance_type = var.instance_type
  user_data = file("scripts/install_frontend.sh")
  vpc_security_group_ids = [aws_security_group.linktic.id]
  key_name               = var.key_name
  tags = {
    Name        = "webserver"
  }
}
resource "aws_instance" "backend" {
  ami           = var.ami_redhat
  instance_type = var.instance_type
  user_data = file("scripts/install_docker.sh")
  vpc_security_group_ids = [aws_security_group.linktic.id]
  key_name               = var.key_name
  tags = {
    Name        = "backserver"
  }
}
# EC2 Instance
resource "aws_instance" "postgres" {
  ami           = var.ami_redhat
  instance_type = var.instance_type
  user_data = file("scripts/install_postgresql.sh")
  vpc_security_group_ids = [aws_security_group.linktic.id]
  key_name               = var.key_name
  tags = {
    Name        = "MyPostgresDB"
  }
}

# Route53 Zone
resource "aws_route53_zone" "primary" {
  name = "devops.sh"
}

# Route53 Record
resource "aws_route53_record" "web" {
  zone_id = aws_route53_zone.primary.id
  name    = "webserver"
  type    = "A"
  ttl     = 300
  records = [aws_instance.web.public_ip]
}


resource "aws_cognito_user_pool" "user_pool" {
  name = "linktic-pool"

 schema {
    attribute_data_type = "String"
    name                = "email"
    required            = true
    mutable             = false
  }

  auto_verified_attributes = ["email"]

}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "linktic-web"
  user_pool_id = aws_cognito_user_pool.user_pool.id
  generate_secret = false

  allowed_oauth_flows = ["code"]
  allowed_oauth_scopes = ["phone", "email", "openid", "profile", "aws.cognito.signin.user.admin"]
  callback_urls = ["http://localhost:8080/login/oauth2/code/cognito"]
  logout_urls = ["http://localhost:8080"]

  allowed_oauth_flows_user_pool_client = true
  supported_identity_providers = ["COGNITO"]
}

