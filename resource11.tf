provider "aws" {
  region     = "us-east-1"
  access_key = "*************************"
  secret_key = "*********************"
}

resource "aws_instance" "ubuntu-instance144" {
  ami           = "ami-0aa2b7722dc1b5612"
  instance_type = "t2.micro"
  key_name      = "mujahed"
  vpc_security_group_ids =["sg-080a4f8b835cdbbf4","sg-06b112fa6478a533e"]
  tags = {
    Name = "instance"
  }
  user_data = <<EOF
                 #!/bin/bash
                 cat > /tmp/logs.txt
                 sudo apt-get update -y
                 echo RepoUpdated >> /tmp/logs.txt
                 sudo apt-get install -y default-jdk
                 echo JavaInstalled >> /tmp/logs.txt
                 sudo apt-get install -y maven
                 echo MavenInstalled >> /tmp/logs.txt
                 sudo apt-get install -y tomcat8
                 echo TomcatInstalled >> /tmp/logs.txt
                 sudo apt-get install -y ansible
                 echo AnsibleInstalled >> /tmp/logs.txt
                 sudo wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
                 echo KeyAdded >> /tmp/logs.txt
                 sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
                 echo SourceAdded >> /tmp/logs.txt
                 sudo apt-get update -y
                 echo RepoUpdated >> /tmp/logs.txt
                 sudo apt-get install -y jenkins
                 echo JenkinsInstalled >> /tmp/logs.txt
                 sudo systemctl start jenkins
                 echo StartJenkinsService >> /tmp/logs.txt
                 sudo systemctl enable jenkins
              EOF
    # output "public_dns" {
    # value = aws_instance.ubuntu-instance131.public_dns
    # }
}


    
# sudo wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
# sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
# sudo apt-get update -y
# sudo apt-get install -y jenkins
# sudo systemctl start jenkins
# sudo systemctl enable jenkins
# EOF

