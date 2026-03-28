locals {
  name_prefix = var.name_prefix
}

module "web_app" {
  source = "./modules/web_app"

  name_prefix   = local.name_prefix
  instance_type = var.instance_type
  file_content  = var.file_content

  vpc_id            = data.aws_vpc.selected.id
  public_subnet_ids = data.aws_subnets.public.ids
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.12.0"

  name    = "${local.name_prefix}-webapp-alb"
  vpc_id  = data.aws_vpc.selected.id
  subnets = data.aws_subnets.public.ids

  enable_deletion_protection = false

  # Security Group
  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
    all_https = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "HTTPS web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
}

resource "aws_lb_listener" "web_app" {
  load_balancer_arn = module.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = module.web_app.target_group_arn
  }
}
