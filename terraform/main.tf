module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"
  name    = "particle41-vpc"
  cidr    = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true
}

module "ecs_cluster" {
  source  = "terraform-aws-modules/ecs/aws"
  name    = "particle41-ecs"
  cluster_name = "particle41-cluster"
}

module "ecs_service" {
  source = "terraform-aws-modules/ecs/aws//modules/service"
  name   = "simple-time-service"
  cluster_name = module.ecs_cluster.cluster_name
  launch_type  = "FARGATE"
  desired_count = 1

  container_definitions = jsonencode([
    {
      name      = "simpletimeservice"
      image     = var.image_url
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [{
        containerPort = 5000
        protocol      = "tcp"
      }]
    }
  ])

  subnet_ids = module.vpc.private_subnets
  security_group_ids = [aws_security_group.allow_http.id]
  assign_public_ip = false
  alb = {
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb" "main" {
  name               = "particle41-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
}

resource "aws_lb_target_group" "main" {
  name     = "particle41-tg"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}

resource "aws_security_group" "allow_http" {
  name   = "allow_http"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 5000
    to_port     = 5000
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
