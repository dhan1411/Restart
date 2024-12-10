output "ec2_private_ip" {
  value = module.ec2.instance_private_ip
}

output "ec2_public_ip" {
  value = module.ec2.instance_public_ip
}

output "db_endpoint" {
  value = module.db.db_endpoint
}