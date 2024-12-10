module "vpc" {

    source =  "./vpc"

}


module "ec2" {

    source = "./ec2_instance"
    subnet_id = module.vpc.public_subnet
    vpc_id = module.vpc.vpc_id
}

module "db" {

    source = "./db_instance"
    subnet_ids = [ module.vpc.private_subnet , module.vpc.public_subnet ]
    vpc_security_group_ids = [module.ec2.security_grp]

}
