provider "aws" {
  region = "ap-south-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_vpc" "test" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "test"
  }
}
resource "aws_subnet" "main1" {
  vpc_id     = aws_vpc.test.id
  cidr_block = "10.0.1.0/24"
  availability_zone ="ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Main1"
  }
}
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.test.id

  tags = {
    Name = "IGW"
  }
}
resource "aws_route_table" "Public_RT" {
    vpc_id = aws_vpc.test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
}
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main1.id
  route_table_id = aws_route_table.Public_RT.id
}

resource "aws_instance" "Machine1" {
  ami           = "ami-0e0e417dfa2028266"
  instance_type = "t2.micro"
  key_name = aws_key_pair.key.key_name
  subnet_id = aws_subnet.main1.id
  vpc_security_group_ids = [aws_security_group.new_sg.id]

  tags = {
    Name = "Machine1"
  }

  root_block_device {
    volume_type = "gp2"
     volume_size = 8
  }

  user_data = <<EOF
   #!/bin/bash
   sudo yum install httpd -y
   sudo service httpd start
  EOF
}

resource "local_file" "key" {

  content = tls_private_key.rsa.private_key_pem
  filename = "key"

}

resource "aws_key_pair" "key" {
  key_name = "key"
  public_key = tls_private_key.rsa.public_key_openssh

}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_security_group" "new_sg" {
  name        = "new"
  description = "Allow http and ssh inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.test.id

  tags = {
    Name = "new"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.new_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.new_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.new_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}






