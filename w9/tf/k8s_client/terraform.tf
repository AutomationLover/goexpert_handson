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


resource "aws_instance" "k8s_client" {
    ami = data.aws_ami.ubuntu22.id
    vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  
    instance_type = "t2.small"
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
              EOF
    tags = {
        Name  = "k8s_client",
        Role = "node"       
      }
}



output "ssh_command_to_k8s_client" {
  value = <<EOF
  pls do
  1. . check ssh connection to client
  ssh to terraform
  ssh -i ${path.module}/deployer-key.pem ubuntu@${aws_instance.k8s_client.public_ip}
  EOF
  description = "output"
}