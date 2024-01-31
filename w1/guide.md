# Setup AWS account, user and AWS CLI

## Level 1 (Intern)
### Task: Set up an AWS account, understand the AWS Management Console layout and set up an IAM user.

#### Step 1: Set up an AWS account
1. Go to the AWS homepage.
2. Click "Create an AWS Account".
3. Fill out the necessary details and click "Continue".
4. Choose "Personal" or "Professional" account type, fill out the rest of the form, and click "Create Account and Continue".

#### Step 2: Understand the AWS Management Console layout
1. Sign in to the AWS Management Console.
2. The navigation bar is at the top, and it contains a list of services and resources.
3. The main panel contains the dashboard which provides an overview of the services and resources.

#### Step 3: Set up an IAM user for yourself
1. Navigate to the IAM dashboard.
2. Click "Users" and then "Add user".
3. Specify a user name and select "AWS Management Console access".
4. Click "Next" to set permissions, add to a group or copy permissions from an existing user.
5. Review the user details and click "Create user".
6. You should now be able to log in with this IAM user instead of the root user.

## Level 2 (Junior)

#### Step 1: Setting up IAM user for AWS CLI
1. Navigate to the IAM dashboard.
2. Click "Users" and then "Add user".
3. Specify a user name and select "Programmatic access".
4. Click "Next" to set permissions. You can either attach existing policies directly, or set up permissions boundaries.
5. Review the user details and click "Create user".
6. Note down the Access key ID and Secret access key.

#### Step 2: Using AWS CLI with IAM user
1. Install AWS CLI on your local machine.
2. Configure it using the command `aws configure`, and input your Access key ID, Secret access key, and preferred region.
3. Now you can interact with your AWS resources using the command line.

## Level 3 (Mid-level)

### Task: Practice Basic AWS CLI Commands

#### Step 1: Configure AWS CLI
1. Open your terminal or command prompt.
2. Type `aws configure` and press Enter.
3. Enter your AWS Access Key ID when prompted.
4. Enter your AWS Secret Access Key when prompted.
5. Specify your preferred AWS Region (e.g., us-west-2).
6. Choose your default output format (e.g., json, text, or table).

#### Step 2: List S3 Buckets
1. In the terminal, type `aws s3 ls` and press Enter.
2. You should see a list of all S3 buckets in your account.

#### Step 3: Create a New S3 Bucket
1. Type `aws s3 mb s3://<bucket-name>` replacing `<bucket-name>` with a unique bucket name.
2. Press Enter. You should receive a confirmation message that the bucket has been created.

#### Step 4: Upload a File to S3 Bucket
1. Type `aws s3 cp <file-path> s3://<bucket-name>` replacing `<file-path>` with the local path to the file you're uploading and `<bucket-name>` with the name of your bucket.
2. Press Enter. You should see a message indicating successful file upload.

#### Step 5: Describe EC2 Instances
1. Type `aws ec2 describe-instances` and press Enter.
2. You'll receive a JSON response with details of all the EC2 instances in your AWS account.

#### Step 6: Launch a New EC2 Instance
1. Type `aws ec2 run-instances --image-id ami-XXXXX --count 1 --instance-type t2.micro --key-name <your-key-pair> --security-groups <your-security-group>` replacing `ami-XXXXX` with an appropriate AMI ID, `<your-key-pair>` with your SSH key pair, and `<your-security-group>` with your security group name.
2. Press Enter. You'll receive details of the instance being launched.

#### Step 7: List IAM Users
1. Type `aws iam list-users` and press Enter.
2. You'll get a list of IAM users in your AWS account.

#### Step 8: Create a New IAM User
1. Type `aws iam create-user --user-name <new-user-name>` replacing `<new-user-name>` with the desired username for the new IAM user.
2. Press Enter. You will see the details of the newly created IAM user in the output.

#### Step 9: Attach a Policy to an IAM User
1. Type `aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/<PolicyName> --user-name <new-user-name>` replacing `<PolicyName>` with the name of the policy you want to attach and `<new-user-name>` with the username of the IAM user.
2. Press Enter. You will receive confirmation that the policy has been attached to the user.

#### Step 10: Delete an IAM User
1. Type `aws iam delete-user --user-name <existing-user-name>` replacing `<existing-user-name>` with the name of the user you wish to delete.
2. Press Enter. You will receive confirmation that the user has been deleted.

#### Step 11: Stop an EC2 Instance
1. Type `aws ec2 stop-instances --instance-ids i-XXXXX` replacing `i-XXXXX` with the Instance ID of the EC2 instance you want to stop.
2. Press Enter. You'll receive confirmation that the instance is stopping.

#### Step 12: Delete an S3 Bucket
1. First, ensure the bucket is empty by typing `aws s3 rm s3://<bucket-name> --recursive` to delete all objects in the bucket.
2. Then, type `aws s3 rb s3://<bucket-name>` to remove the bucket itself.
3. Press Enter. You will receive confirmation that the bucket has been deleted.

Practice these AWS CLI commands to get comfortable with managing AWS services via the command line. Remember to replace placeholder values like `<bucket-name>`, `<file-path>`, `<new-user-name>`, `<existing-user-name>`, `<PolicyName>`, and `i-XXXXX` with actual values from your AWS environment.

**Note:** Always exercise caution when performing delete operations and ensure that you are deleting the correct resources to avoid unintentional loss of data or service interruption.