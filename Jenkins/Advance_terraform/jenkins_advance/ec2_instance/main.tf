resource "aws_instance" "server" {

    ami = var.ami
    instance_type = var.instance_type
    tags = {
        Name = var.server_name
    }
    key_name = var.key
    vpc_security_group_ids = [aws_security_group.sg.id]
    subnet_id = var.subnet_id


   root_block_device {
   volume_type = var.volume_type
   volume_size = var.volume_size


   }

   user_data = "${file("ec2_instance/user-data-dbinstall.sh")}"


}

resource "aws_security_group" "sg" {

    vpc_id = var.vpc_id

    tags = {

        Name = "Security_Group"
    }
  
}


resource "aws_vpc_security_group_ingress_rule" "for_ssh" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "for_db" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "${aws_instance.server.private_ip}/32"
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}






