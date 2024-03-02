provider "aws" {
  region = "us-west-2"
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
    values = ["amzn-ami-hvm-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_instance" "app" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  key_name      = "deployer-key"

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