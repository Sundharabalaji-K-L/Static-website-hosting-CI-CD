prefix                 = "static-website-hosting"
vpc_cidr               = "172.32.0.0/16"
azs                    = ["us-east-1a", "us-east-1b"]
public_subnets_cidrs  = ["172.32.1.0/24", "172.32.2.0/24"]
private_subnets_cidrs = ["172.32.3.0/24", "172.32.4.0/24"]

ami           = "ami-06aa3f7caf3a30282"
volume        = "8Gib"
instance_type = "t2.medium"

s3_names = ["my-blog.live-primary", "my-blog.live-failover"]

domain_name = "my-blog.1cloudhub.com"


aws_region = "us-east-1"

