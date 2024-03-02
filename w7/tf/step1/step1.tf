provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "app" {
  ami           = "ami-052c9ea013e6e3567"
  instance_type = "t2.micro"

  tags = {
    Name = "app-instance"
  }
}
