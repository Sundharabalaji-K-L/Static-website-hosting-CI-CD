# Static Website Hosting Using CI/CD

 This project is aimed to automate the process of deploying a static website by using Jenkins CI/CD pipelines. The provisioning of required infrastructure will also be automated through terraform.

 Jenkins is a leading open-source automation server widely used for continuous integration and continuous delivery (CI/CD) pipelines. With its extensive plugin ecosystem, Jenkins offers unparalleled flexibility and customization options for automating various stages of the software development lifecycle. This plugin support enables seamless integration with a plethora of tools and technologies, empowering developers to streamline their workflows and improve productivity. Whether it's integrating with version control systems, building and testing applications, or deploying to various environments, Jenkins provides the necessary infrastructure to automate tasks efficiently. Additionally, Jenkins' user-friendly interface and robust community support make it a top choice for organizations seeking to optimize their software delivery processes.

### Table of Contents
  * [Project Description](#project-description)
  * [Pre-requisites](#pre-requisites)
      - [Configure terraform S3 Backend](#configure-terraform-s3-backend)
      - [Configure state lock](#configure-state-lock)
 * [Project Structure](#project-structure)
 * [Github Actions](#github-actions)
      - [Plan workflow](#mongodb-cluster-setup-on-k8s-cluster-nodes)
 * [Deploying Prometheus](#deploying-prometheus)
      - [Prometheus setup for kubernets cluster and mongoDB](#prometheus-setup-for-kubernets-cluster-and-mongodb)
 * [Configuration](#Configuration)
 * [Reference Blogs and Links](#reference-blogs-and-links)

## Project Description
This project focuses on implementing a CI/CD pipeline for hosting a static website using Amazon S3 for storage and CloudFront for content delivery.along with configuring origin failover for enhanced reliability by handling error conditions like 403 (Forbidden), 404 (Not Found), 500 (Internal Server Error), and 502 (Bad Gateway). CloudFront's caching capabilities significantly improves website performance by reducing latency and offloading traffic from origin servers. In addition it also reduces the loading time of images and other animations, thus optimizing overall user experience.With S3 bucket acting as the origin for CloudFront, and failover configurations in place, the project ensures high availability and fault tolerance, making it a reliable solution for hosting static websites on AWS infrastructure.

## Pre-requisites
- ### Configure terraform S3 Backend
	 Utilizing Terraform's remote state feature with an S3 bucket offers several advantages for managing infrastructure as code. Storing the state file in S3 enables securing sensitive information such as passwords, secret key, secret key etc. Provides centralized storage, ensuring consistent deployment across environments. This approach enhances collaboration and simplifies version control, as changes to infrastructure can be tracked and managed effectively. With teraform's remote state the risk of state file loss or corruption is minimized.
   #### Step-1: Nagivate to the S3 Bucket tab on aws console
   ![Example Image](https://drive.google.com/uc?id=1vTrIaotoeGFcLMoN9Y6FBuYUaQa-B5SO)

   #### Step-2: Click on create Bucket
   ![Example Image](https://drive.google.com/uc?id=18eZxvEZTs2ga1uxAJVVZz3LOjrMtLXdJ)
   
   #### Step-3: Choose an unique name for your bucket and Create bucket with default configurations
   1. By enable versioning Terraform's S3 backend provides a historical snapshot of state changes, offering a safety net for reverting to previous versions in case of accidental modifications. This rollback capability ensures quick restoration to stable states without risking 
   the loss of critical configurations or resources.

   2. By default, the S3 bucket used as a backend for Terraform state storage comes with server-side encryption, ensuring the security of the state file. This encryption adds an extra layer of protection to sensitive infrastructure configurations, safeguarding them from unauthorized access or tampering.

    ![Example Image](https://drive.google.com/uc?id=14atStkFwgaoUutbeE7ajSR7EfQgVlIHG)

   3. Similarly, the S3 bucket used for Terraform state storage has block public access enabled by default. This feature enhances security by preventing inadvertent exposure of the state file to unauthorized users or public access. It ensures that the state file remains private and accessible only to authorized individuals, mitigating the risk of data breaches or unauthorized modifications.

  ![Example Image](https://drive.google.com/uc?id=1PL1eRTDMH8my11axSIT2IkpYzoAMTo5Z)

  #### Step-4: Modify backend.tfvars file
  The backend.tfvars file  is used to pass the values to the backend.tf where we define our backend configurations.

```hcl
# backend.tf

terraform {
  backend "s3" {
    bucket = var.bucket
    key    = var.key
    region = var.region
  }
}
```
- Replace bucket with your bucket name
- replace region with your region

```hcl
# backend.tfvars

bucket         = "your-bucket-name"
key            = "terraform.tfstate"
region         = "your-region"

```
- ### Configure state lock
	Using Terraform's state locking feature provides a safeguard for managing infrastructure as code. It ensures that only one person can make changes at a time, preventing any accidental conflicts or issues. This makes it easier for teams to work together on projects and keeps everything organized. With state locking, you can trust that your infrastructure changes are secure and won't be accidentally overwritten.
   #### Step-1: Nagivate to the DynamoDB tab on aws console
   ![Example Image](https://drive.google.com/uc?id=17q8uTlzkjmwIeHSGToQh0cQqkESjHCtl)
   #### Step-2: Click on Create table
  ![Example Image](https://drive.google.com/uc?id=1H1gMOQDU8FONEAny-ptB1hLIdY4vzLbh)
  #### Step-3: Choose a name for your table and create with the default configuration
  ![Example Image](https://drive.google.com/uc?id=11977wiqMmqWvpippDwYbkuGjFoqI6BXa)
  ![Example Image](https://drive.google.com/uc?id=1YkhF5nCELTsw6cJgWOXr-xNgB6DxF-oP)
  #### Step-4: Modify the backend.tfvars
  The backend.tfvars file  is used to pass the values to the backend.tf where we define our backend configurations.
```hcl
# backend.tf

# modify the backend configuration to add a state lock
terraform {
  backend "s3" {
    bucket = var.bucket
    key    = var.key
    region = var.region
    dynamodb_table = var.dynamodb_table
    encrypt        = true
  }
}

```
- Replace dynamo_table with your table name

```hcl
# backend.tfvars

bucket         = "your-bucket-name"
key            = "terraform.tfstate"
region         = "your-region"
dynamodb_table = "your table name"
```

## Project Structure
```Directory Structure
.
├── backend.tf
├── backend.tfvars
├── main.tf
├── modules
│   ├── EC2
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── acm
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── cloudfront
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── iam-role
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── iam-role-policy
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── key-pair
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   ├── kms-key
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── kms-policy
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── network-components
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── route53
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── s3-bucket
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── s3-bucket-policy
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── secret-manager
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── security-groups
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── providers.tf
├── script.sh
├── terraform.tfvars
└── variables.tf
└── .tfint.hcl
```
## Github Actions
### Enviromnent variables
As the sensitive informations like pat-token and gmail app-password are passsed as enviroment variable to add it to aws secret manager and for storing output.json to the repository after provising resources to use it on pipeline script, you need to add your secrets as enviroment variable by navigating to secrets and select actions from drop-down.
- add tf_pass for storing pat-token
- add tf_app_pass for storing gmail app-password

```hcl
# main.tf
resource "github_repository_file" "output_json" {
  repository = "your repo"  // repositoy name 
  branch     = "branch"        // branch name
  file       = "output.json" // name for the file  that has to be created in the repository
  content    = <<-EOT
    {
      "bucket_names": ${jsonencode(module.s3-bucket.bucket_names)},
      "cloudfront_id": "${module.cloudfront.cloudfront_id}"
    }
  EOT

  commit_message      = "Update output.json"           // commit message for the commit
  commit_author       = "Terraform User"               // commit author of the commit
  commit_email        = "your email" // commit email of the commit
  overwrite_on_create = true

  depends_on = [
    module.cloudfront,
    module.s3-bucket
  ]
}
```
```hcl
################################################# Secret Manager Resources #################################################
module "secrets-manager-pat-token" {
  source        = "./modules/secret-manager"
  secret_name   = "your secret name" // name for secret
  description   = "github pat-token" // description about the secret value
  secret_string = var.tf_token       // secret value need to be stored
  tags = {
    "jenkins:credentials:type"     = "usernamePassword"
    "jenkins:credentials:username" = "your github username"
  }
}

module "secrets-manager-gmail" {
  source        = "./modules/secret-manager"
  secret_name   = "your secret name"     // name for secret
  description   = "gmail app-password" // description about the secret value
  secret_string = var.tf_app_pass      // secret value need to be stored
  tags = {
    "jenkins:credentials:type"     = "your app-password"
    "jenkins:credentials:username" = "your gmail address"
  }
}
```

   ![Example Image](https://drive.google.com/uc?id=1I6EKSpB7YhaxyTxS8L9ux0TdXx_XHV97)
### Plan workflow
- The github workflow is triggered manually and prepares the Terraform plan, which shows the proposed changes to the infrastructure without applying them. This step helps to review the changes before deployment. Use terraform plan to plan the resources.
### Apply workflow
- This workflow is triggered manually and applies the Terraform changes to the AWS infrastructure based on the approved plan. This step deploys the changes to the live environment. Use terraform apply -auto-approve to apply the resources. 
### Destroy workflow
- This workflow is triggered manually and destroys all the Terraform-managed resources, effectively removing the infrastructure from AWS. Use terraform destroy -auto-approve to destroy the resources.

