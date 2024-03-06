In Terraform, the `for_each` loop is a powerful construct that allows you to create multiple instances of a resource, based on a set of given values. It is often combined with variables to iterate over complex data structures, and can be used in several ways.

Here are a few examples of how you can use `for_each` with multiple variables:

1. Using `for_each` with a map of objects:
   
   Here, `for_each` iterates over a map of objects, where each object contains multiple properties.

   ```terraform
   variable "user_map" {
     default = {
       alice = { age = 24, city = "New York" }
       bob   = { age = 27, city = "San Francisco" }
     }
   }

   resource "aws_instance" "example" {
     for_each = var.user_map

     ami           = "ami-0c55b159cbfafe1f0"
     instance_type = "t2.micro"

     tags = {
       Name = each.key
       Age  = each.value.age
       City = each.value.city
     }
   }
   ```

   In this example, the `for_each` loop creates an AWS instance for each user in `user_map` with tags that include each user's name, age, and city.

2. Combining `for_each` with `setproduct`:

   The `setproduct` function is used in combination with `for_each` to generate a cartesian product of multiple sets, which can be useful when you need to create resources for every combination of certain values.

   ```terraform
   variable "regions" {
     default = ["us-west-1", "us-west-2", "us-east-1"]
   }

   variable "instances" {
     default = ["t2.micro", "t2.small", "t2.medium"]
   }

   locals {
     region_instance_pairs = { for pair in setproduct(var.regions, var.instances) :
       "${pair[0]}-${pair[1]}" => {
         region  = pair[0]
         instance_type = pair[1]
       }
     }
   }

   resource "aws_instance" "example" {
     for_each = local.region_instance_pairs

     ami           = "ami-0c55b159cbfafe1f0"
     instance_type = each.value.instance_type
     availability_zone = each.value.region

     tags = {
       Name = each.key}
   }
   ```

In this example, an AWS instance is created for every combination of regions and instance types.

3. Using `for_each` with a list of maps:

   If you have a list of maps and you want to create a resource for each map in the list, you can use `for_each` with `toset` and `element`.

   ```terraform
   variable "users" {
     default = [
       {
         name = "Alice"
         age  = 24
         city = "New York"
       },
       {
         name = "Bob"
         age  = 27
         city = "San Francisco"
       },
     ]
   }

   resource "aws_instance" "example" {
     for_each = { for user in var.users : user.name => user }

     ami           = "ami-0c55b159cbfafe1f0"
     instance_type = "t2.micro"

     tags = {
       Name = each.key
       Age  = each.value.age
       City = each.value.city
     }
   }
   ```

In this example, an AWS instance is created for each user specified in the `users` variable.

Each of these examples demonstrates different ways to utilize the `for_each` loop in Terraform with multiple variables. This construct can significantly simplify your code when you need to create multiple similar resources, but with different parameters. Remember that the `for_each` argument expects a map or a set of strings, so you need to structure your variables accordingly.
