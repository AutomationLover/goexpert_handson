# Week 5 Jumphost, ECS and CICD: 
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
run aws configure, get credential from you administrator user, and set region to us-west-2

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
**Task**: Deploy in app in ECS with AWS CLI and AWS console

**Objective**: Create ECR, and push image; create ECS cluster, and run a task

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


**Step 4**: Create ECS cluster AWS console
Create cluster
Cluster name: myfargate
Create



**Step 5**: Create task-definition
Task definition family: web
Tick Amazon EC2 instances
CPU: 0.25; Memory: 0.5GB

Container 1:
name:  web
Image: URL, copy from ECR, format like 839775502365.dkr.ecr.us-west-2.amazonaws.com/web:latest
Container port: 8000

Click Add Container
Container 2:
name:  redis
Image: redislabs/redismod
Add Port Mappings
Container port: 6379

**Step 6**: Deploy task to ECS cluster
Deploy -> Run task


## Level 2 
**Task**: Create pipeline


