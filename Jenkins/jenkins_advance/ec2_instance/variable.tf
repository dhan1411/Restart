variable "ami" {

    default = "ami-0327f51db613d7bd2"
  
}

variable "instance_type" {

    default = "t2.micro"
  
}

variable "server_name" {

    default = "Webserver"
  
}

variable "key" {

    default = "Lab1_LinuxOS_KP"
  
}
variable "volume_type" {

    default = "gp2"
  
}

variable "volume_size" {

    default = 8
  
}

variable "subnet_id" {

}

variable "vpc_id" {

}