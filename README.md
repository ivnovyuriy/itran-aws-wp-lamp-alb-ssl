# Wordpress / LAMP / NodeJS / SSL / Private Domain / ALB + AutoScaling / Terraform 

## Prerequisites:

   - AWS account
   - Terraform installed version 0.14
   - SSL Certificate
   - Existing SSH key
   - Domain Name

## Usage
```
git clone https://github.com/nazy67/wordpress_with_terraform.git

# run the next command on vpc directory, webserver and rds directories without `-var-file=tfvars/dev.tf`

terraform init
terraform plan  -var-file=tfvars/dev.tf
terraform apply -var-file=tfvars/dev.tf
```

## Description

#### VPC


#### Security groups:

  - Bastion host security group, with open ports 22(SSH) to anywhere and Webserver security group.
  - Application Load balancer security group with ports 443(HTTPS) and 80(HTTP) open to 0.0.0.0/0.
  - RDS security group with ports 3306(MySQL) open to Webserver security group and local machine. 
  - Webserver Security group with ports 3306(MySQL) open to RDS's Security Group, and HTTP port 80 open to ALB Security Group and 22(SSH) open to Bastion security group.

#### Application Load Balancer.


#### Auto Scaling group. Launch template.

Before we create ASG we need to create Launch Template, for an image_id I passed a data_source since it's an existing resource and will filter out from a given criteria’s and chooses the correct AMI. 

```
data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter { # dictionary or map
    name   = "name"
    values = ["amzn2-ami-hvm-2.0*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
```

For this, Amazon LINUX 2 machine (AMI) and t2.micro instance type were used and bash script was added in the user data section. This bash script will download php, httpd, mysql-agent and Wordpress package and unzips it.  

### UserData



## RDS database    

RDS db will be created with an engine MariaDB and version 10.4.8, database instance class, storage type , allocated storage will be chosen from the RDS database parameters. 

Enter RDS db master _```username```_ and _```password```_.

RDS Security group public access will be false for security reason. For learning purposes no backing up ,storage isn't encrypted because db.t2.micro is too small.  


## Route 53



## Notes 

The following  plugins are required to be installed and activated in the WordPress:
```
- JSM force ssl. (JSM's Force HTTP to HTTPS (SSL) – Simple, Safe, Reliable, and Fast!)

- Simple 301 redirect. (Redirection)
```
These plugins helps you to make your application secure , without redirecting  your HTTP/80 listener to HTTPS/443.