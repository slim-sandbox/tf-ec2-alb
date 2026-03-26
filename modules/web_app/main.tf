resource "random_integer" "subnet_id_selection" {
  min = 0
  max = length(var.public_subnet_ids) - 1
  keepers = {
    subnet_ids = join(",", var.public_subnet_ids)
  }
}

resource "aws_instance" "webapp" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_ids[random_integer.subnet_id_selection.result]
  vpc_security_group_ids = [aws_security_group.webapp.id]
  user_data = templatefile("${path.module}/init-script.sh", {
    file_content = "webapp"
  })

  associate_public_ip_address = true
  tags = {
    Name = "${var.name_prefix}-webapp"
  }
}

resource "aws_security_group" "webapp" {
  name_prefix = "${var.name_prefix}-webapp"
  description = "Allow traffic to webapp"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "webapp" {
  name     = "${var.name_prefix}-webapp"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    port     = 80
    protocol = "HTTP"
    timeout  = 3
    interval = 5
  }
}

resource "aws_lb_target_group_attachment" "webapp" {
  target_group_arn = aws_lb_target_group.webapp.arn
  target_id        = aws_instance.webapp.id
  port             = 80
}
