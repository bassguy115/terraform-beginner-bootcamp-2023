# Terraform Beginner Bootcamp 2023 - week2

- [Working with Ruby](#working-with-ruby)
  * [Bundler](#bundler)
    + [Install Gems](#install-gems)
    + [Executing ruby scripts in the context of bundler](#executing-ruby-scripts-in-the-context-of-bundler)
  * [Sinatra](#sinatra)
- [Terratowns Mock Server](#terratowns-mock-server)
  * [Running the web server](#running-the-web-server)
- [CRUD](#crud)
- [TF Provider in Go "Golang"](#tf-provider-in-go--golang-)
  * [Basics for Go in TF](#basics-for-go-in-tf)
  * [main.go is the main directory to make a go package](#maingo-is-the-main-directory-to-make-a-go-package)
    + [Example from ChatGPT](#example-from-chatgpt)
  * [Commands to initialize terraform provider in GO](#commands-to-initialize-terraform-provider-in-go)
    + [Example from ChatGPT of TF Provider that uses Go Modules](#example-from-chatgpt-of-tf-provider-that-uses-go-modules)
    + [terraform.rc file](#terraformrc-file)
  * [Required provider](#required-provider)
    + [Troubleshooting TF Providers](#troubleshooting-tf-providers)
- [Starting steps to launch your provider locally](#starting-steps-to-launch-your-provider-locally)



## Working with Ruby

### Bundler

Bundler is a package manager for ruby.
It is the primary way to install ruby packages (known as gems) for ruby.

#### Install Gems

You need to create a Gemfile and define your gems in that file.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install` command

This will install the gems on the system globally (unlike nodejs which install packages in place in a folder called node_modules)

A Gemfile.lock will be created to lock down the gem versions used in this project.

#### Executing ruby scripts in the context of bundler

We have to use `bundle exec` to tell future ruby scripts to use the gems we installed. This is the way we set context.

### Sinatra

Sinatra is a micro web-framework for ruby to build web-apps.

Its great for mock or development servers or for very simple projects.

You can create a web-server in a single file.

https://sinatrarb.com/

## Terratowns Mock Server

### Running the web server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the `server.rb` file.

## CRUD

Terraform Provider resources utilize CRUD.

CRUD stands for Create, Read Update, and Delete

https://en.wikipedia.org/wiki/Create,_read,_update_and_delete

## TF Provider in Go "Golang"

Go, often referred to as Golang, is an open-source programming language developed by Google.

Go uses packages as in binaries to be nimble and non dependent on installer or package manager

A package is a directory of .go files

A module is a collection of packages with built-in dependencies and versioning. A module comes with two additional files go.mod and go.sum.

[How to Write Go Code](https://go.dev/doc/code#:~:text=packages%2C%20and%20commands.-,Code%20organization,files%20within%20the%20same%20package.)

[How to use go modules](https://www.workfall.com/learning/blog/how-to-use-go-modules-for-package-management/#:~:text=for%20Go%20beginners.-,Package%20vs%20Module,with%20two%20additional%20files%20go.)

### Basics for Go in TF

Package main: Declares the package name.
The main package is special in Go, it's where the execution of the program starts.
```go
package main
```

### main.go is the main directory to make a go package

my-terraform-provider/
    ├── main.go
    └── go.mod


#### Example from ChatGPT
Certainly! Here's an example of a simple "Hello, World!" Go package:

Create a directory for your Go package. Let's call it hello.

Inside the hello directory, create a file named hello.go. This will be your Go source code file.

Open hello.go in a text editor and add the following code:

```go
```package hello

import "fmt"

// HelloWorld prints a simple "Hello, World!" message.
func HelloWorld() {
    fmt.Println("Hello, World!")
}
```
This code defines a Go package named hello with a single function HelloWorld that prints "Hello, World!" to the console.

To use this package in another Go program, create a separate Go file (e.g., main.go) and import the hello package:
```go
package main

import "hello" // Import the "hello" package

func main() {
    // Call the HelloWorld function from the "hello" package
    hello.HelloWorld()
}
```
To build and run your program, open a terminal, navigate to the directory containing main.go, and run the following commands:
```bash
go mod init hello_world_app # Initialize a Go module
go run main.go             # Run the Go program
```
The go mod init command initializes a Go module, which is necessary if you're using Go modules (introduced in Go 1.11) to manage dependencies. If you're not using modules, you can skip the go mod init step and directly run go run main.go.

When you run the program, it will import the hello package and call the HelloWorld function, which will print "Hello, World!" to the console.

### Commands to initialize terraform provider in GO
```go
go mod init ""path""
```
#### Example from ChatGPT of TF Provider that uses Go Modules

Here's a simple example of a Go project for a custom Terraform provider that uses Go Modules:

Assuming you have a directory structure like this:

```go
my-terraform-provider/
    ├── main.go
    └── go.mod
```
main.go: This is your provider's Go code. It will contain the implementation of your provider.

go.mod: This is the Go Modules configuration file.

go.mod should include information about your module and its dependencies. Here's an example:

```go
module github.com/yourusername/my-terraform-provider

go 1.16

require (
    github.com/hashicorp/terraform-plugin-sdk v2.6.0
    // Other dependencies go here
)
```
module specifies the name and version of your module.
require lists your module's dependencies. The github.com/hashicorp/terraform-plugin-sdk line is an example of a dependency on the Terraform Plugin SDK, which is used to build Terraform providers.
To initialize your project as a Go Module, you can run the following command in your project's root directory:

```bash
go mod init github.com/yourusername/my-terraform-provider
```
This will create or update the go.mod file with your module's path.

To fetch and manage dependencies, you can use go get or simply run:

```bash
go mod tidy
```
This will ensure that the dependencies listed in your go.mod file are downloaded and available for your project.

#### terraform.rc file

The purpose of the terraform.c file is to override the default setting and specify where to look for custom providers.

### Required provider

In main.tf you must define the required provider

```hcl
terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
```
```hcl
provider "terratowns" {
  endpoint = "http://localhost:4567"
  user_uuid = "e123456b99f-421c-84c9-4ccea042c7d1"
  token = "9b12345-b8e9-483c-b703-97ba88123456"
}
```
#### Troubleshooting TF Providers

Turning on log levels to help get details for troubleshooting your provider

input in gitpod.yml
```hcl
tasks:
  - name: terraform
    env:
      TF_LOG: DEBUG
```

In terminal to set log level on for debugging.
```sh
export TF_LOG=DEBUG
```
## Starting steps to launch your provider locally

Starting your provider you first must build it by running
```sh
./bin/build_provider
```
This should create a file under
"terraform-provider-terratowns/terraform-provider-terratowns_v1.0.0"

You will then run 
```
terraform init
```
```
terraform apply
```
