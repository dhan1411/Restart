locals {
  configuration1 = {
    dev     = { instance_type = "t2.micro", tags = { Name = "dev" , region = "ap-south-1", Environment = "Development" } }
    staging = { instance_type = "t2.micro", tags = { Name = "Staging" , region = "ap-south-1", Environment = "Staging" } }
    prod    = { instance_type = "t2.micro", tags = { Name = "Prod" ,region = "ap-south-1", Environment = "Production" } }
  }
}
locals{


   configuration2 = {
    dev     = { instance_type = "t2.micro", tags = { Name = "dev" , region = "ap-south-1", Environment = "Development" } }
    staging = { instance_type = "t2.micro", tags = { Name = "Staging" , region = "ap-south-1", Environment = "Staging" } }
    prod    = { instance_type = "t2.micro", tags = { Name = "Prod" , region = "ap-south-1", Environment = "Production" } }
  }
}



