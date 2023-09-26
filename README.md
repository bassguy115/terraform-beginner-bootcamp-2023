# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going to utilize versioning for its tagging.
[semver.org](https://semver.org/)


The general format:

**MAJOR.MINOR.PATCH**, eg. 1.0.1

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

The Terraform CLI installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instrucions via Terraform Documentation and change the scripting for install.

[Install Terraform CLI]https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

## Considerations for Linux Distribution

This project is build again Ubuntu.
Please consider checking your Linux Distribution and change accordingly to distributions

[How To Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of Checking OS Version:

```

$ cat /etc/os-release 
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy

```

## Refactoring into Bash Scripts

While fixing the Terriform CLI gpg deprication issues we notice that bash script steps were a considerable amount of more code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./install_terraform_cli)


-This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
-This allows us an easier time to debug and execute manually Terriform CLI install.
-This will allow better portability for other projects that need to install Terraform CLI.

## Shebang
A Shebang (prounounced she-bang) tells the bash script what program interprit the script.

https://en.wikipedia.org/wiki/Shebang_(Unix)

#!/bin/bash


https://en.wikipedia.org/wiki/Chmod
