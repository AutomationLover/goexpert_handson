provider "aws" {
  region = "us-west-2"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
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
  key_name      = aws_key_pair.deployer.key_name

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
  value = "ssh -i ${aws_key_pair.deployer.key_name}.pem ec2-user@${aws_instance.app.public_ip}"
}