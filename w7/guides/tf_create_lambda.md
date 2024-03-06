Here is some answer to https://github.com/JiangRenDevOps/DevOpsNotes/blob/master/WK6_Terraform/hands_on/4%20-%20Homework.md

Same code saved in repo https://github.com/AutomationLover/tflambda

First, let's begin with the folder structure:
```
terraform_lambda/
│
├── lambda_function/
│   └── helloword.py
│
├── main.tf
├── variables.tf
└── outputs.tf
```

Now let's go through each file:

1. `lambda_function/helloword.py`: This is a simple Python lambda function.
    ```python
    def lambda_handler(event, context):
        print("Hello, World!")
    ```



2. `main.tf`: Use the variable in your S3 bucket and policy definition.

Here is the updated `main.tf`:

```markdown
provider "aws" {
  region  = "us-west-2"
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}


resource "aws_lambda_function" "example" {
  function_name    = "lambda_function_name"
  s3_bucket        = aws_s3_bucket.bucket.bucket
  s3_key           = "lambda_function_payload.zip"
  handler          = "helloworld.lambda_handler"
  runtime          = "python3.12"
  role             = aws_iam_role.role.arn

  depends_on = [
    aws_s3_bucket_object.object,
  ]
}

data "archive_file" "example_zip" {
  type        = "zip"
  source_dir  = "lambda_function"
  output_path = "lambda_function_payload.zip"
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.bucket.bucket
  key    = "lambda_function_payload.zip"
  source = "lambda_function_payload.zip" 

  depends_on = [
    data.archive_file.example_zip,
  ]
}

resource "aws_iam_role" "role" {
  name = "lambda_s3_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
```


3. `variables.tf`: This file will define any variables we are going to use.

    ```markdown
    variable "region" {
      description = "AWS region"
      default     = "us-west-2"
    }
    variable "bucket_name" {
      description = "S3 bucket name"
      default     = "my-unique-bucket-name"
    }
    ```

4. `outputs.tf`: This file will define any output we might require.

    ```markdown
    output "lambda_function_name" {
      description = "The name of the Lambda Function"
      value       = aws_lambda_function.example.function_name
    }

    output "s3_bucket_id" {
      description = "The ID of the S3 bucket"
      value       = aws_s3_bucket.bucket.id
    }
    ```
Make sure to replace `"my-unique-bucket-name"` in `variables.tf` with your desired unique bucket name and `"lambda_function_name"` in `main.tf` with your desired lambda function name. 

Once done,you can initialize Terraform with the following command:

```markdown
terraform init
```

This will set up the necessary providers for your project.

Next, you can apply your configuration with the following command:

```markdown
terraform apply
```

This will prompt you to confirm that you want to create the resources defined in your `.tf` files. Confirm by typing `yes`. 

When the command completes, you should see output similar to the following:

```markdown
Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

Outputs:

lambda_function_name = "lambda_function_name"
s3_bucket_id = "bucket_name"
```

This output indicates that your Lambda function and S3 bucket were created successfully.

One thing to remember, you need to upload your Python code to the S3 bucket before referencing it in your Lambda function. The Terraform configuration provided above takes care of that by creating a `.zip` file of your code and uploading it to the S3 bucket before creating the Lambda function.


