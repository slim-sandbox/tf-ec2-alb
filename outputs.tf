output "application_http_url" {
  value = "http://${module.alb.dns_name}"
}

output "instance_type" {
  value = "The instance type ${data.aws_ec2_instance_type.selected.instance_type} is ${data.aws_ec2_instance_type.selected.free_tier_eligible ? "" : "not "}free tier eligible."
}