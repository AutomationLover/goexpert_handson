# Week 4: 
## Level 0 (prerequisites)
**Task**: Create a Key Pair and an EC2 Instance

**Objective**: To create a key pair for SSH access and then create an EC2 instance using this key pair.

### Step by Step Guide:

**Step 1**: Create the key pair
- To create a key pair, use the following command:
```bash
aws ec2 create-key-pair --key-name MyKeyPair --query 'KeyMaterial' --output text > MyKeyPair.pem
```
- This command will create a key pair named `MyKeyPair` and save the private key in a file named `MyKeyPair.pem`.

**Step 2**: Create the EC2 instance
- To create an EC2 instance
   Select "Amazon Linux", and MyKeyPair

**Step 3**: Connect to the EC2 instance
- To connect to the EC2 instance, you will need its public DNS name. You can get this using the following command:
```bash
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[PublicDnsName]'
```
- Then, you can connect using the following command:
```bash
ssh -i MyKeyPair.pem ec2-user@ec2-198-51-100-1.compute-1.amazonaws.com
```
- Replace `ec2-198-51-100-1.compute-1.amazonaws.com` with the public DNS name of your EC2 instance.

**Note**: Remember to change the permissions of your `MyKeyPair.pem` file so it is not publicly viewable for SSH to work:
```bash
chmod 400 MyKeyPair.pem
```
