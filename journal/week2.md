# Terraform Beginner Bootcamp 2023 - week2

## Working with Ruby

### Bundler

Bundler is a package manager for runy.
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


## TF Provider Golang "go" 

Go is an open-source programming language developed by Google.

it uses packages as in binaries to 

### main.go is the main directory to make a go package

#### Example from ChatGPT
Certainly! Here's an example of a simple "Hello, World!" Go package:

Create a directory for your Go package. Let's call it hello.

Inside the hello directory, create a file named hello.go. This will be your Go source code file.

Open hello.go in a text editor and add the following code:

```go
Copy code
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
Copy code
package main

import "hello" // Import the "hello" package

func main() {
    // Call the HelloWorld function from the "hello" package
    hello.HelloWorld()
}
```
To build and run your program, open a terminal, navigate to the directory containing main.go, and run the following commands:
```bash
Copy code
go mod init hello_world_app # Initialize a Go module
go run main.go             # Run the Go program
```
The go mod init command initializes a Go module, which is necessary if you're using Go modules (introduced in Go 1.11) to manage dependencies. If you're not using modules, you can skip the go mod init step and directly run go run main.go.

When you run the program, it will import the hello package and call the HelloWorld function, which will print "Hello, World!" to the console.

This is a basic example of creating and using a Go package. You can expand on this foundation to build more complex Go programs and packages as needed.

### Commands to initilize terraform provider in GO
```go
go mod init ""path""
```
#### Example from ChatGPT

Here's a simple example of a Go project for a custom Terraform provider that uses Go Modules:

Assuming you have a directory structure like this:

```go
Copy code
my-terraform-provider/
    ├── main.go
    └── go.mod
```
main.go: This is your provider's Go code. It will contain the implementation of your provider.

go.mod: This is the Go Modules configuration file.

go.mod should include information about your module and its dependencies. Here's an example:

```go
Copy code
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
Copy code
go mod init github.com/yourusername/my-terraform-provider
```
This will create or update the go.mod file with your module's path.

To fetch and manage dependencies, you can use go get or simply run:

```bash
Copy code
go mod tidy
```
This will ensure that the dependencies listed in your go.mod file are downloaded and available for your project.



