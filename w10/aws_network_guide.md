# AWS Networking Guide

## Level 1 - Intern
**Objective:** Get hands-on experience with AWS networking components.

### Task: Create a VPC and a Subnet within AWS Console

1. **Login to AWS Management Console**
    - Navigate to the AWS Management Console and enter your login credentials.

2. **Create a VPC**
    - Go to the VPC Dashboard by selecting "VPC" from the "Services" drop-down menu.
    - Click on "Your VPCs" in the left sidebar, then click the "Create VPC" button.
    - Fill in the "Name tag", "IPv4 CIDR block" and leave the remaining settings as default.
    - Click "Create VPC".

3. **Create a Subnet**
    - Go back to the VPC Dashboard and select "Subnets" from the left sidebar.
    - Click "Create subnet" button. 
    - Fill in the name, select the VPC you created earlier, define the "IPv4 CIDR block", and leave the remaining settings as default.
    - Click "Create subnet".

## Level 2 - Junior
**Objective:** Understand VPC design and EC2 instance management.

### Task: Extend the VPC to include both a public and private subnet, and launch an EC2 instance in the public subnet.

1. **Create a Public Subnet**
    - Repeat the previous subnet creation steps to create an additional subnet in the same VPC. This will be your public subnet.

2. **Create an Internet Gateway and Attach it to the VPC**
    - Go back to the VPC Dashboard and select "Internet Gateways" from the left sidebar.
    - Click "Create internet gateway", give it a name, and click "Create".
    - Select the created gateway, click "Actions", then "Attach to VPC". Select your VPC and click "Attach".

3. **Configure Route Table for Public Subnet**
    - Go back to the VPC Dashboard and select "Route Tables" from the left sidebar.
    - Click "Create route table", give it a name, select your VPC, and click "Create".
    - Select the created route table, go to the "Routes" tab, click "Edit routes", then "Add route". For "Destination", enter "0.0.0.0/0" and for "Target", select the internet gateway you created. Click "Save routes".
    - Go to the "Subnet Associations " tab, click "Edit subnet associations", select your public subnet, and click "Save".

4. **Launch an EC2 Instance**
    - Navigate to the EC2 Dashboard by selecting "EC2" from the "Services" drop-down menu.
    - Click "Launch instances", select your preferred AMI, instance type, and click "Next: Configure Instance Details".
    - For "Network", select your VPC and for "Subnet", select the public subnet. Leave the remaining settings as default and follow the remaining prompts to launch the instance.

## Level 3 - Mid-level
**Objective:** Master complex, real-world AWS networking setups.

### Task: Add NAT Gateway, Route Tables, and set up a basic security group.

1. **Create a NAT Gateway**
    - Go back to the VPC Dashboard and select "NAT Gateways" from the left sidebar.
    - Click "Create NAT gateway", select your public subnet, create a new Elastic IP by clicking "Allocate Elastic IP", and click "Create a NAT gateway".

2. **Configure Route Table for Private Subnet**
    - Go back to the VPC Dashboard and select "Route Tables" from the left sidebar.
    - Click "Create route table", give it a name, select your VPC, and click "Create".
    - Select the created route table, go to the "Routes" tab, click "Edit routes", then "Add route". For "Destination", enter "0.0.0.0/0" and for "Target", select the NAT Gateway you created. Click "Save routes".
    - Go to the "Subnet Associations" tab, click "Edit subnet associations", select your private subnet, and click "Save".

3. **Create a Security Group**
    - Navigate to the EC2 Dashboard by selecting "EC2" from the "Services" drop-down menu.
    - Under "Network & Security", click "Security Groups".
    - Click "Create security group", give it a name, description, select your VPC, and click "Create".
    - Select the created security group, go to the "Inbound rules" tab, click "Edit inbound rules", then "Add rule". Set up the desired rules (e.g., allow SSH from your IP) and click "Save rules".

This completes the setup of your VPC with a public and private subnet, an EC2 instance, NAT Gateway, Route Tables, and a basic security group.