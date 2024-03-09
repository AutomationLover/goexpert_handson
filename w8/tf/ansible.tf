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

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.3.20240219.0-kernel-6.1-x86_64"]
  }
}

resource "aws_instance" "ansible_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install git -y
              git --version
              sudo yum install ansible -y
              ansible --version
              EOF

  tags = {
    Name = "ansible_server"
  }
}


data "aws_ami" "ubuntu22" {
    most_recent = true
    owners = ["099720109477"] # Canonical
    filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu*22.04*amd64*"]
    }    
}


resource "aws_instance" "ansible_client" {
    ami = data.aws_ami.ubuntu22.id
    vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  
    instance_type = "t2.micro"
    key_name      = aws_key_pair.deployer.key_name
  
    tags = {
        Name  = "ansible_client",
        Role = "node"       
      }
}


output "ssh_command_to_ansible_server" {
  value = <<EOF
  pls do
  1. scp key pair to ansible_server
  scp -i ./deployer-key.pem deployer-key.pem ec2-user@${aws_instance.ansible_server.public_ip}:~/.ssh

  2. create file ~/.ssh/config in ansible_server
  ssh to ansible server
  ssh -i ./deployer-key.pem ec2-user@${aws_instance.ansible_server.public_ip}

  vim ~/.ssh/config
  Copy below to config file:
  ```
    Host ${aws_instance.ansible_client.public_ip}
        User ubuntu
        IdentityFile ~/.ssh/deployer-key.pem
  ```

  3. check ssh connection to client
  ssh to ansible client
  ssh -i ${path.module}/deployer-key.pem ubuntu@${aws_instance.ansible_client.public_ip}
  EOF
  description = "output"
}