**Exercise 1: String Variable**

We will create a simple Terraform configuration that declares a String variable and outputs it. 

```hcl
variable "example_string" {
  description = "This is a string variable"
  type        = string
  default     = "Hello, World!"
}

resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "echo ${var.example_string}"
  }
}
```

**Exercise 2: Number Variable**

In this exercise, we'll declare a Number variable and use it to determine the number of null resources to create.

```hcl
variable "example_number" {
  description = "This is a number variable"
  type        = number
  default     = 3
}

resource "null_resource" "example" {
  count = var.example_number

  provisioner "local-exec" {
    command = "echo Creating resource number ${count.index+1}"
  }
}
```

**Exercise 3: List Variable**

A List variable can be used to create multiple instances of a resource or to provide multiple arguments to a resource. Here's an example:

```hcl
variable "example_list" {
  description = "This is a list variable"
  type        = list(string)
  default     = ["one", "two", "three"]
}

resource "null_resource" "example" {
  count = length(var.example_list)

  provisioner "local-exec" {
    command = "echo Creating resource named ${var.example_list[count.index]}"
  }
}
```

**Exercise 4: Map Variable**

A Map variable is useful for looking up values or passing complex data structures to a resource. For example:

```hcl
variable "example_map" {
  description = "This is a map variable"
  type        = map(string)
  default     = {
    "one"   = "first"
    "two"   = "second"
    "three" = "third"
  }
}

resource "null_resource" "example" {
  count = length(var.example_map)

  provisioner "local-exec" {
    command = "echo Creating resource named ${keys(var.example_map)[count.index]} with value ${values(var.example_map)[count.index]}"
  }
}
```


Remember to remind your students to run `terraform init` before `terraform apply` to initialize the working directory, download the necessary provider plugins, and create the initial state file. 

Please note that the use of `null_resource` is just for demonstration purposes in this lesson. In real-world applications, you'd be using actual cloud resources (like AWS instances, Google Cloud instances, etc.) instead.
