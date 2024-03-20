provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow inbound SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 31000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow NodePort service access"
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow Minikube dashboard access"
  }

  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow Kubernetes API server access"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "deployer" {
  key_name    = "deployer-key"
  public_key  = file("${path.module}/deployer-key.pem.pub")
}



data "aws_ami" "ubuntu22" {
    most_recent = true
    owners = ["099720109477"] # Canonical
    filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu*22.04*amd64*"]
    }    
}


resource "aws_instance" "minikube" {
    ami = data.aws_ami.ubuntu22.id
    vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  
    instance_type = "t3.medium"
    key_name      = aws_key_pair.deployer.key_name
    user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install unzip -y
              curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
              unzip awscliv2.zip
              sudo ./aws/install 
              aws --version
              curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
              chmod +x ./kubectl
              sudo mv ./kubectl /usr/local/bin/kubectl
              kubectl version --client
              curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
              sudo mv /tmp/eksctl /usr/local/bin
              eksctl version
              sudo apt-get update -y &&  sudo apt-get install -y docker.io
              sudo docker version
              curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
              minikube version
              sudo apt install conntrack -y
              sudo minikube start --driver=none
              minikube status
              sudo usermod -aG docker ubuntu && newgrp docker
              EOF
    tags = {
        Name  = "minikube",
        Role = "node"       
      }
}



output "ssh_command_to_minikube" {
  value = <<EOF
  pls do
  1. . check ssh connection to client
  ssh to terraform
  ssh -i ${path.module}/deployer-key.pem ubuntu@${aws_instance.minikube.public_ip}
  EOF
  description = "output"
}