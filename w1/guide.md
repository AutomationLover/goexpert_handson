# Manual Deploy Frontend - S3
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

#### Step 4: Setting up IAM user for AWS CLI
1. Navigate to the IAM dashboard.
2. Click "Users" and then "Add user".
3. Specify a user name and select "Programmatic access".
4. Click "Next" to set permissions. You can either attach existing policies directly, or set up permissions boundaries.
5. Review the user details and click "Create user".
6. Note down the Access key ID and Secret access key.

### Demo: Using AWS CLI with IAM user
1. Install AWS CLI on your local machine.
2. Configure it using the command `aws configure`, and input your Access key ID, Secret access key, and preferred region.
3. Now you can interact with your AWS resources using the command line.

## Level 2 (Junior)
### Task: Create an S3 bucket and upload a simple HTML file. 

#### Step 1: Create an S3 Bucket
1. Go to the S3 service in AWS Console.
2. Click "Create Bucket", give it a unique name and select your preferred region.
3. Leave the rest as default and click "Create".

#### Step 2: Upload a HTML file
Here's a simple "Hello World" HTML file: 
```html
<!DOCTYPE html>
<html>
<body>

<h1>Hello World</h1>

</body>
</html>
```
1. Save this as `index.html`.
2. Go to your S3 bucket and click "Upload".
3. Choose the `index.html` file and click "Upload".

#### Step 3: Set permissions to allow public view
1. Click on your `index.html` file in the S3 bucket.
2. Go to the "Permissions" tab.
3. Click "Edit", uncheck "Block all public access", and save.

#### Step 4: Set up Route53 A record to point to S3
1. Go to Route53 service in AWS Console.
2. Create a new Hosted Zone with your domain.
3. Create a new record set, choose type "A - IPV4 address".
4. Set the Alias target to your S3 bucket's website endpoint.

## Level 3 (Mid-level)
### Task: Configure permissions and versioning for the S3 bucket.

#### Step 1: Set up versioning
1. Go to your S3 bucket.
2. Click on the "Properties" tab.
3. Scroll down to the "Versioning" section and click "Edit".
4. Check "Enable versioning" and save.

#### Step 2: Update S3 bucket file content
1. Create a new `index.html` file with different content.
2. Upload this new file to the S3 bucket. It should have the same name as the previous file.
3. The new file becomes the current version.

#### Step 3: Restore from a previous version in S3
1. Click on the file in the S3 bucket.
2. Click on the "Versioning" tab.
3. You will see multiple versions of the file.
4. Choose the version you want to restore and click "Actions".
5. Click "Make this the current version".
6. The selected version is now restored and becomes the current version.