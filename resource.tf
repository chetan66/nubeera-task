#creation of VPC
resource "aws_vpc" "New_Project" {
  cidr_block = "10.0.0.0/16"
  tags = "New-vpc"
}

#creation of public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.New_Project.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "public_subnet"
  }
}

#creation of internet gateway
resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.New_Project.id
  tags = {
    Name = "IG"
}
}
#Routetable
resource "aws_route_table" "new_route" {
  vpc_id = aws_vpc.New_Project.id
  tags = {
  Name = "new_route"
}
}
#route to internet
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.new_route.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.IG.id
}

#associate subnet with route table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.new_route.id
}

#create a new security group
resource "aws_security_group" "new-security-gp" {
  name_prefix = "new-security-gp"
  description = "Security group for web server"
  vpc_id      = aws_vpc.New_Project.id
}

# Rules for security group
resource "aws_security_group_rule" "new_ingress1" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.new-security-gp.id
}

resource "aws_security_group_rule" "new_ingress2" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.new-security-gp.id
}

resource "aws_security_group_rule" "new_ingress3" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.new-security-gp.id
}

resource "aws_security_group_rule" "all_outbound" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "all"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.new-security-gp.id
}

resource "aws_instance" "ubuntu-instance11"{ 
    ami= "ami-0aa2b7722dc1b5612"  
    instance_type = "t2.micro"
    key_name = "mujahed"   
    #user_data = <<-EOF 
    tags = {
        Name="VPC_Server1121"
    }
connection {
    type        = "ssh"
    user        = "ubuntu"
    #private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apache2"
    ]
  }


}
    
    # #!/bin/sh
    # inline = [
    # sudo apt-get update,
    # sudo apt-get install -y apache2
    # ]

#
#     tags= {
#     Name = "httpd_server"
# }


# output "web_domain" {
#   value = aws_instance.ubuntu-instance.public_dns
# }


