provider "aws" {
  region = "ap-south-1"
  access_key = "var.access_key"
  secret_key = "var.secret_key"
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
    cidr_block = "0.0.0.0/16"
    gateway_id = aws_internet_gateway.IGW.id
}
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main1.id
  route_table_id = aws_route_table.Public_RT.id
}

resource "aws_instance" "Machine1" {
  ami           = ami-0e0e417dfa2028266
  instance_type = "t2.micro"
  key_name = "key"
  subnet_id = aws_subnet.main1.id

  tags = {
    Name = "Machine1"
  }
}

resource "local_file" "Key" {

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
  name        = "new_sg"
  description = "Allow http and ssh inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.test.id

  tags = {
    Name = "new_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.new_sg.id
  cidr_ipv6         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.new_sg.id
  cidr_ipv6         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.allow_new_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

resource "aws_ebs_volume" "volume" {
  availability_zone = "ap-south-1a"
  size              = 8

  tags = {
    Name = "volume"
  }
}

resource "aws_volume_attachment" "attachment" {
  device_name = "/dev/xvda"
  volume_id   = aws_ebs_volume.volume.id
  instance_id = aws_instance.Machine1.id
}

user_data = << EOF
#!/bin/bash
sudo yum install httpd -y
sudo service httpd start
EOF
