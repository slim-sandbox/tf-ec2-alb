# tf-ec2-alb

Initialize Terraform.

```sh
terraform init
```

Apply the configuration. You will be prompted to add the values for the variables.

```sh
terrafrom apply
```

Alternatively, you may pass in the values directly by adding the `-var` flag.

```sh
terraform apply -var="name_prefix=your-name" -var="vpc_name=your-vpc-name -var="aws_region=ap-southeast-1"
```

Another way is to include a `values.tfvars` and then use the `-var-file` flag.

```hcl
name_prefix = "your-name"
vpc_name = "your-vpc"
aws_region = "ap-southeast-1"
```

```sh
terrafrom apply -var-file="values.tfvars"
```
