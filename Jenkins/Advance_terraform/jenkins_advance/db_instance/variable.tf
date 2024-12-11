variable "subnet_ids" {
  type = list(string)
}


variable "vpc_security_group_ids" {

}

variable "username" {

default = "admin"

}
variable "password" {

default = "admin123"
}


variable "db_name" {
default = "server_db"
}
variable "instance_type" {
default = "db.t3.micro"    

}
variable "storage_type" {
default = "gp2"

}

variable "availability_zone" {
default = "ap-south-1a"

}