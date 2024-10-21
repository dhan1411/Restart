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
    cidr_block = "10.0.0.0/16"
    gateway_id = aws_internet_gateway.IGW.id
}
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main1.id
  route_table_id = aws_route_table.Public_RT.id
}