
# Terraform: Introduction, Demo and Exercise

Terraform, developed by HashiCorp, is an open-source infrastructure as code software tool that allows you to safely and predictably create, change, and improve infrastructure. This guide provides a quick introduction to Terraform, focusing on resources, locals, variables, and loops using null_resource.

## Introduction

### Resources

In Terraform, a Resource represents an item that can be created, updated, or destroyed, such as a physical server or a database. 

```terraform
resource "null_resource" "example" {
  # Configuration details go here
}
```

### Local Values

Local values assign a name to an expression so that it can be used multiple times within a module. 

```terraform
locals {
  # Configuration details go here
  common_tags = {
    Owner = "DevOps Team"
  }
}
```

### Variables

Variables in Terraform are a great way to define centrally controlled reusable values. The configuration looks like this:


```terraform
variable "image_id" {
  description = "The id of the machine image (AMI) to use for the server."
  type        = string
}
```

### Loops

Using `count`, `for_each`, and `for`, you can create multiple instances of resources and data sources, conditionally create or omit resources, and iterate over collections to generate multiple instances of resources and data sources.

```terraform
resource "null_resource" "cluster" {
  count = 5 # creates 5 null resources
}
```

## Demo

Let's see how we can use a null_resource with a local and a variable in a loop.

```terraform
variable "instance_count" {
  description = "The number of instances to create."
  type        = number
  default     = 5
}

locals {
  common_tags = {
    Owner = "DevOps Team"
  }
}

resource "null_resource" "example" {
  count = var.instance_count

  triggers = {
    tag_value = local.common_tags.Owner
  }
}
```

In this example, we create a number of null resources specified by the "instance_count" variable. Each null resource gets a tag from a local value.

## Exercise

1. Create a variable "student_name" with your name as the default value.
2. Define a local value "common_tags" with a tag "Student" set to the "student_name" variable.
3. Create a null_resource "student" with count 3, each having a trigger with the "Student" tag value.

Save your code in a ".tf" file and initialize Terraform by running `terraform init`. Then, apply the configuration using `terraform apply`.

## Solution

You can verify your solution with the code below:

```terraform
variable "student_name" {
  description = "The student's name."
  type        = string
  default     = "Your Name"
}

locals {
  common_tags = {
    Student = var.student_name
  }
}

resource "null_resource" "student" {
  count = 3

  triggers = {
    tag_value = local.common_tags.Student
  }
}
```

If you initialized and applied this configuration successfully, Terraform would create three null resources with a trigger tag "Student" set to your name.
