variable "name_prefix" {
  description = "Name prefix of application"
  type        = string
}

variable "instance_type" {
  description = "Instance type of ec2"
  type        = string
  default     = "t3.micro"
}

variable "vpc_id" {
  description = "Virtual private cloud id"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet ids"
  type        = list(string)
}

variable "file_content" {
  description = "File content of user data"
  type        = string
  default = "webapp"
}
