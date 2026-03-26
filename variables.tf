# terraform apply -var="name_prefix=your-name" -var="vpc_name=your-vpc-name"

variable "name_prefix" {
  description = "Your name prefix to label all resources"
  type        = string
}

variable "vpc_name" {
  description = "An existing VPC with a public subnet"
  type        = string
}

variable "aws_profile" {
  description = "AWS CLI profile to use for Terraform configuration"
  type        = string
  default     = "default"
}

variable "aws_region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "ap-southeast-1"
}

variable "file_content" {
  description = "Content passed to the instance user data script."
  type        = string
  default     = "<h1>Welcome to My Web App</h1>"
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t3.micro"
}