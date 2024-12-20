resource "aws_db_subnet_group" "subnet_group" {
  subnet_ids = var.subnet_ids

  tags = {
    Name = "DB subnet group"
  }
}


resource "aws_db_instance" "server_db" {
  allocated_storage    = 5
  db_name              = var.db_name
  engine               = "mysql"
  engine_version       = "8.0"
  availability_zone    = var.availability_zone
  instance_class       = var.instance_type
  storage_type         = var.storage_type 
  username             = var.username
  password             = var.password
  vpc_security_group_ids = var.vpc_security_group_ids
  skip_final_snapshot  = true
}
