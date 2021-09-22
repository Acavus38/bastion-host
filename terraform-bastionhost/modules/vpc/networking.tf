provider "aws" {
    region = "eu-central-1"
}

#VPC
resource "aws_vpc" "vpc" { 
  cidr_block = var.vpc_cidr
  
  tags = {
      Name = "VPC-BH"
  }
}
    output "vpc_id" {
        value = aws_vpc.vpc.id
    }

#Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  depends_on = [aws_vpc.vpc]

    tags = {
      Name = "IGW-BH"
  }
}

###Subnet###

#Public Subnet 1
resource "aws_subnet" "publicsubnet1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_cidr_1
    availability_zone = "eu-central-1a"

    depends_on = [aws_vpc.vpc]

    tags = {
      Name = "PublicSubnet1-BH"
  }
}

    output "public_subnet_id" {
        value = aws_subnet.publicsubnet1.id
    }

#Public Subnet 2
resource "aws_subnet" "publicsubnet2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_cidr_2
    availability_zone = "eu-central-1b"

    depends_on = [aws_vpc.vpc]

    tags = {
      Name = "PublicSubnet2-BH"
  }    
}

#Private Subnet 1
resource "aws_subnet" "privatesubnet1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_cidr_1
    availability_zone = "eu-central-1a"

    depends_on = [aws_vpc.vpc]

    tags = {
      Name = "PrivateSubnet1-BH"
  }
}

    output "privatesubnet_id" {
        value = aws_subnet.privatesubnet1.id
    }


#Private Subnet 2
resource "aws_subnet" "privatesubnet2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_cidr_2
    availability_zone = "eu-central-1b"

    depends_on = [aws_vpc.vpc]

    tags = {
      Name = "PrivateSubnet2-BH"
  }
}

###RouteTables###

#Public Route Table
resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.vpc.id

  depends_on = [aws_subnet.publicsubnet1]

    tags = {
      Name = "PublicRT-BH"
  }  
}
    #Public Subnet Association
    resource "aws_route_table_association" "subnet_association_1" {
        subnet_id      = aws_subnet.publicsubnet1.id
        route_table_id = aws_route_table.publicRT.id
    }

    resource "aws_route_table_association" "subnet_association_2" {
        subnet_id      = aws_subnet.publicsubnet2.id
        route_table_id = aws_route_table.publicRT.id
    }

        #Routes/Rules, (Just for public RT)
        resource "aws_route" "target_igw" {
            route_table_id            = aws_route_table.publicRT.id
            destination_cidr_block    = "0.0.0.0/0"
            gateway_id = aws_internet_gateway.igw.id

            depends_on                = [aws_route_table.publicRT]
}


#Private Route Table
resource "aws_route_table" "privateRT" {
  vpc_id = aws_vpc.vpc.id

  depends_on = [aws_subnet.privatesubnet1]

    tags = {
      Name = "PrivateRT-BH"
  }    
}
    resource "aws_route_table_association" "subnet_association_3" {
        subnet_id      = aws_subnet.privatesubnet1.id
        route_table_id = aws_route_table.privateRT.id
    }

    resource "aws_route_table_association" "subnet_association_4" {
        subnet_id      = aws_subnet.privatesubnet2.id
        route_table_id = aws_route_table.privateRT.id
    }

        # No aws_route because private Instance is not available through web

# resource "aws_instance" "publicInstance" {
#     ami = var.windows_ami
#     instance_type = var.instance_type
#     subnet_id = aws_subnet.publicsubnet1.id
#     associate_public_ip_address = "true"
#     key_name = "bastionHost"
#     security_groups = [aws_security_group.sg_allow_rdp.id] 
#     get_password_data = "true"

#     depends_on = [aws_route_table.publicRT]

#     tags = {
#       Name = "PublicInstance-BH"
#   }  
# }

#     output "public_ip" {
#         value = aws_instance.publicInstance.public_ip
#     }

#     output "public_dns" {
#         value = aws_instance.publicInstance.public_dns
#     }

#     output "admin_password" {
#         value = rsadecrypt(aws_instance.publicInstance.password_data,file("bastionHost.pem"))
#     }

# resource "aws_instance" "privateInstance" {
#     ami = var.windows_ami
#     instance_type = var.instance_type
#     subnet_id = aws_subnet.privatesubnet1.id
#     associate_public_ip_address = "false"
#     key_name = "bastionHost"
#     security_groups = [aws_security_group.sg_allow_rdp.id] 

#     depends_on = [aws_route_table.privateRT]

#     tags = {
#       Name = "PrivateInstance-BH"
#   }  
# }

# resource "aws_security_group" "sg_allow_rdp" {
#   name        = "allow_rdp"
#   description = "Allow RDP inbound traffic"
#   vpc_id      = aws_vpc.vpc.id

#   ingress {
#     from_port   = 3389
#     to_port     = 3389
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#    egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1" #-1 equal to all
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#     tags = {
#       Name = "SG-Allow_RDP-BH"
#   }  
# }

