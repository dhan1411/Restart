terraform {
 backend "s3" {
    bucket = "dhan1411"
    key    = "/root/Terraform/main.tf"
    region = "ap-south-1"
    dynamodb_table = "terraform_lock_id"
  }

}

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

resource "aws_subnet" "main2" {
  vpc_id     = aws_vpc.test.id
  cidr_block = "10.0.2.0/24"
  availability_zone ="ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Main2"
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

resource "aws_instance" "Machine2" {
  ami           = "ami-0e0e417dfa2028266"
  instance_type = "t2.micro"
  key_name = aws_key_pair.key.key_name
  subnet_id = aws_subnet.main1.id
  vpc_security_group_ids = [aws_security_group.new_sg.id]

  tags = {
    Name = "Machine2"
  }

  root_block_device {
    volume_type = "gp2"
     volume_size = 8
  }

  user_data = ${file("user_data_httpd.sh")}

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

resource "aws_vpc_security_group_ingress_rule" "rsa" {
  security_group_id = aws_security_group.new_sg.id
  cidr_ipv4         = "${aws_instance.Machine2.private_ip}/32"
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.new_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_db_subnet_group" "db_subnet" {
  name = "test"
  subnet_ids = [aws_subnet.main1.id ,aws_subnet.main2.id]
  
}


resource "aws_db_instance" "rds_test" {
  allocated_storage    = 5
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "admin123"
  skip_final_snapshot  = true
  identifier           =  "database1"
  vpc_security_group_ids = [aws_security_group.new_sg.id] 
  db_subnet_group_name =  aws_db_subnet_group.db_subnet.name
  storage_type         = "gp2"
  publicly_accessible = false
}


module "s3" {
  source = "./S3"
}
