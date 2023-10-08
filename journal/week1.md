# Terraform Beginner Bootcamp 2023 - week1

## Fixing Tags

[How to Delete Local and Remote Tags on Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

Locall delete a tag
```sh
git tag -d <tag_name>
```

Remotely delete tag

```sh
git push --delete origin tagname
```

Checkout the commit that you want to retag. Grab the sha from your Github history.
![sha example](https://github.com/bassguy115/terraform-beginner-bootcamp-2023/assets/145221609/682551c8-51f8-4e1b-97a7-0db346c9a56d)

```sh
git checkout <SHA>
git tag M.M.P
git push --tags
git checkout main
```

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

## Considerations when using ChatGPT to write Terraform

Larg launguage Models (LLMs) such as ChatGPT may not be trained on the latest documentation or information about Terraform.

It may likely produce older examples that could be deprecated. Often affecting providers.

## Working with Files in Terraform


### Fileexists function

This is a built in terraform function to check the existance of a file.

```tf
condition = fileexists(var.error_html_filepath)
```

https://developer.hashicorp.com/terraform/language/functions/fileexists

### Filemd5

https://developer.hashicorp.com/terraform/language/functions/filemd5

### Path Variable

In terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module
[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

```tf
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"

  etag = filemd5("${path.root}/public/index.html")
}
```

## Terraform Locals

Locals allows us to define local variables.
It can be very useful when we need transform data into another format and have referenced a variable.

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

## Terraform Data Sources

This allows us to source data from cloud resources.

This is useful when we want to reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```
[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON

We use the jsonencode to create the json policy inline in the hcl.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### Changing the lifecycle resources

[Meta Arguments Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

https://developer.hashicorp.com/terraform/language/resources/terraform-data

## Provisioners

Provisioners allow you to execute commands on compute instances eg. a AWS SLI command.

They are not recommended for use by Hashicorp because Configuration Management tools such as Ansible are a better fit, but the functionality exists. 
### local-exec

This will execute command on the machine running the terraform commands eg. plan apply

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```
https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec

### Remote-exec

This will execute commands on a machine which you target. You will need to provide credentials such as ssh to get into the machine.

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```
https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec