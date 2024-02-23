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
**Step 6**: set up git and docker

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


## Level 1 (Intern)
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

**Step 3**: Push image to ECR
follow the cli in "view push commands" in previous Step.

create image under folder "goexpert_handson/w5/repo/", and then push this docker image to ECR following step in "view push commands"

if some docker issue, please try restart

```bash
sudo service docker restart
```

If some permission issue for docker command, pls add sudo before docker.
If you do not want to add sudo, run 
```bash
sudo usermod -aG docker ec2-user
```
logout and then login

the sudo usermod -aG docker ec2-user command is used to add the user "ec2-user" to the "docker" group, allowing that user to run Docker commands without needing to use sudo or switch to the root user.
- `usermod`: This is the command used to modify a user account. It is typically followed by various options and arguments to specify the modifications to be made.
- `-aG docker`: These options are used to add the user to a specific group. In this case, the -a option indicates that the user should be added to the specified group, and the -G option is used to specify the group name, which is "docker" in this command.

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

codebuild-my-project-service-role role add permission AmazonEC2ContainerRegistryPowerUser

## Level 2 
**Task**: Create pipeline to build docker and push image to ECR
**Objective**: Learn pipeline to build docker and push image to ECR

**Step 1**: Create repo in CodeCommit


**Step 2**: Push code to CodeCommit
get the code from https://github.com/AutomationLover/goexpert_handson/tree/main/w5/repo

**Step 3**: Create pipeline
update the user id the https://github.com/AutomationLover/goexpert_handson/blob/main/w5/files/buildcommand.yaml

**Step 4**: Update app.py

Update app.py with version

**Step 5**: Run task and check

Run task in ECS cluster and check the version.

## Level 3 
**Task**: Create pipeline to deploy image in ECR to ECS
**Objective**: Learn pipeline to deploy image in ECR to ECS

Please refer to https://docs.aws.amazon.com/codepipeline/latest/userguide/ecs-cd-pipeline.html 

