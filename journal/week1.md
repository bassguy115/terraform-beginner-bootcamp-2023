# Terraform Beginner Bootcamp 2023 - week1

## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform Cloud Variables

In terraform we can set two kind of variables:
- Environmental variables - those you would set in  your bash terminal eg. AWS credentials
-Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"`

### var-file flag

- To call a file filled with lots of varsA set of lots of variables in a .tfvars or .tfvars.json file. eg. ```terraform apply -var-file="testing.tfvars"```

A variable definitions file uses the same basic syntax as Terraform language files, but consists only of variable name assignments:
```hcl
image_id = "ami-abc123"
availability_zone_names = [
  "us-east-1a",
  "us-west-1c",
]
```


- Here's an example of a .tfvars file in HashiCorp Terraform.

```hcl
# Example tfvars file: dev.tfvars

# AWS Access Key and Secret Key
aws_access_key = "your_aws_access_key"
aws_secret_key = "your_aws_secret_key"

# AWS Region
region = "us-west-2"

# Number of EC2 instances to launch
instance_count = 2

# EC2 instance type
instance_type = "t2.micro"

# Name for the EC2 instances
instance_name = "my-instance"

# SSH Key Pair for EC2 instances
key_name = "my-keypair"

# Example tfvars file: dev.tfvars

# AWS Access Key and Secret Key
aws_access_key = "your_aws_access_key"
aws_secret_key = "your_aws_secret_key"

##### AWS Region
region = "us-west-2"

##### Number of EC2 instances to launch
instance_count = 2

##### EC2 instance type
instance_type = "t2.micro"

#### Name for the EC2 instances
instance_name = "my-instance"

# SSH Key Pair for EC2 instances
key_name = "my-keypair"
```

In this dev.tfvars file:

We define various variables and assign values to them. These variables represent the configuration settings for your Terraform deployment.

The comments (lines starting with #) are for documentation purposes and provide information about what each variable is used for.

You would replace "your_aws_access_key" and "your_aws_secret_key" with your actual AWS credentials.

You can customize the values of the other variables according to your specific infrastructure requirements.

Once you have created your .tfvars file, you can use it when running terraform apply or terraform plan to apply or plan your infrastructure changes. For example:

bash
Copy code
terraform apply -var-file=dev.tfvars
### terraform.tvfars

This is the default file to load in terraform variables in blunk

### auto.tfvars

- TODO: document this functionality for terraform cloud

-Variables in the Terraform Cloud workspace and variables provided through the command line always overwrite variables with the same key from files ending in .auto.tfvars.

### order of terraform variables

- TODO: document which terraform variables takes presendence.

- Terraform uses the last value it finds, overriding any previous values. Note that the same variable cannot be assigned multiple values within a single source.

- Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

Environment variables
The terraform.tfvars file, if present.
The terraform.tfvars.json file, if present.
Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.

## Dealing with Configuration Drift

## What happens if we lose our state file?

If you loose your statefile, you most likely will have to tear down all of your cloud infrastructure manually.

You can use terraform import but it wont work for all cloud resources. You will need to check the terraform providers documentation for which resouces support import.

### Fix missing resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)

[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/s3_bucket#argument-reference)

### Fix Manual Configuration

If someone deletes or modifies cloud recources manually throuch ClickOps.

IF we run Terraform plan it will attempt to put our infrastructer back into the expected state fixing Configuration Drift.

## Fix using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules



## Passing Input Variables

We can pass input variables to our module.
The module has to declare the terraform variables in its own variables.tf
### Module Sources

using the source we can import the module from various places eg:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrhouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
} 
```


[GitHub module source](https://developer.hashicorp.com/terraform/language/modules/sources#github)