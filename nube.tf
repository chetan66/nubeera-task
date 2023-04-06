provider "aws" {
  region     = "us-east-1"
  access_key = "****************"
  secret_key = "*********************************"
}

resource "aws_instance" "ubuntu-instance515" {
  ami           = "ami-0aa2b7722dc1b5612"
  instance_type = "t2.micro"
  key_name      = "mujahed"
  vpc_security_group_ids =["sg-080a4f8b835cdbbf4","sg-06b112fa6478a533e"]
  tags = {
    Name = "instance212"
  }

  user_data = <<EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install wget
                sudo amazon-linux-extras install java-openjdk11
                sudo amazon-linux-extras install epel -y
                sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
                sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
                sudo yum install jenkins -y
                sudo service jenkins start
              EOF
}
output "public_dns" {
  value = aws_instance.ubuntu-instance515.public_dns
}
