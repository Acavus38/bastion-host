module "vpc_bh" {
  source   = "../modules/vpc"
    vpc_id   = module.vpc_bh.vpc_id
}

module "security_group" {
  source = "../modules/security"
  vpc_id = module.vpc_bh.vpc_id
}

module "public_instance"{
  source = "../modules/ec2"
  ami_id = "ami-05ced23e7b71d428c"
  instance_type = "t2.micro"
  subnet_id = module.vpc_bh.public_subnet_id
  public_or_private = "true"
  key_name = "bastionHost"
  security_groups = [module.security_group.security_group_id] 

  instance_name = "Public Instance"

}

module "private_instance"{
  source = "../modules/ec2"
  ami_id = "ami-05ced23e7b71d428c"
  instance_type = "t2.micro"
  subnet_id = module.vpc_bh.privatesubnet_id
  public_or_private = "false"
  key_name = "bastionHost"
  security_groups = [module.security_group.security_group_id] 

  instance_name = "Private Instance"
}
