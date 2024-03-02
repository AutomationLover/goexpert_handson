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

resource "local_file" "key_pair" {
  filename = "${path.module}/deployer-key.pem"
  provisioner "local-exec" {
    command = <<EOF
      ssh-keygen -t rsa -f ${self.filename} -q -N ""
    EOF
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("${local_file.key_pair.filename}.pub")
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.3.20240219.0-kernel-6.1-x86_64"]
  }
}

resource "aws_instance" "app" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  
  user_data = <<-EOF
              #!/bin/bash
              sudo curl -Lo /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest
              sudo chmod +x /usr/local/bin/ecs-cli
              ecs-cli --version
              sudo yum update -y
              sudo yum install git -y
              git --version
              sudo yum install docker -y
              docker --version
              EOF

  tags = {
    Name = "app-instance"
  }
}

output "ssh_command" {
  value = "ssh -i ${local_file.key_pair.filename} ec2-user@${aws_instance.app.public_ip}"
}