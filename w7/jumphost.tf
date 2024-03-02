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

resource "null_resource" "key_pair" {
  provisioner "local-exec" {
    command = <<EOF
      aws ec2 create-key-pair --key-name deployer-key --query 'KeyMaterial' --output text > deployer-key.pem
      chmod 400 deployer-key.pem
    EOF
  }
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
  key_name      = "deployer-key"
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
  
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${path.module}/deployer-key.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "~/.aws/config"
    destination = "~/.aws/config"
  }

  provisioner "file" {
    source      = "~/.aws/credentials"
    destination = "~/.aws/credentials"
  }

  tags = {
    Name = "app-instance"
  }
}

output "ssh_command" {
  value = "ssh -i ${path.module}/deployer-key.pem ec2-user@${aws_instance.app.public_ip}"
}