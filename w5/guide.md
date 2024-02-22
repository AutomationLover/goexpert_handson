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
- To connect to the EC2 instance from AWS console

**Step 4**: set up AWS configure

```bash
aws configure
```
**Step 5**: set up ecs-cli

```bash
sudo curl -Lo /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest
```

```bash
sudo chmod +x /usr/local/bin/ecs-cli
```

```bash
ecs-cli --version
```
**Step 5**: set up git and docker

```bash
sudo yum update -y
```

```bash
sudo yum install git -y
```

```bash
git --version
```

```bash
sudo yum install docker -y
```

```bash
docker --version
```


## Level 1 
**Task**: Create ECR, and push image 

**Objective**: Create ECR, and push image 

### Step by Step Guide:

**Step 1**: Create ECR

```bash
aws ecr create-repository --repository-name web --region us-west-2
```
check this ECR from AWS console, and "view push commands"

**Step 2**: Clone repo

```bash
git clone https://github.com/AutomationLover/goexpert_handson.git
```

```bash
cd goexpert_handson/w5/repo/
```

**Step 3**: Push code to ECR
follow the cli in "view push commands" in previous Step

if some docker issue, please try restart

```bash
sudo service docker restart
```

If some permission issue for docker command, pls add sudo before docker.
If you do not want to add sudo, run 
```bash
sudo service docker restart
```
logout and then login

Check ECR repo and you should find image there.

**Step 4**: Create ECS cluster

```bash
sudo service docker restart
```


## Level 2 
**Task**: Create ECS, and push image 


