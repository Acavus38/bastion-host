provider "aws" {
    region = "eu-central-1"
}

###VPC###
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
}

    output "vpc_id" {
        value = aws_vpc.my_vpc.id
    }

#Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
}

###Subnet###

#Public Subnet 1
resource "aws_subnet" "publicsubnet1" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_subnet_cidr_1
    availability_zone = "eu-central-1a"
}

    output "publicsubnet_id_1" {
        value = aws_subnet.publicsubnet1.id
    }

#Public Subnet 2
resource "aws_subnet" "publicsubnet2" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_subnet_cidr_2
    availability_zone = "eu-central-1b"
}

#Private Subnet 1
resource "aws_subnet" "privatesubnet1" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_subnet_cidr_1
    availability_zone = "eu-central-1a"
}

    output "privatesubnet_id_1" {
        value = aws_subnet.privatesubnet1.id
    }

#Private Subnet 2
resource "aws_subnet" "privatesubnet2" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_subnet_cidr_2
    availability_zone = "eu-central-1b"
}

###RouteTables###

#Public Route Table
resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.my_vpc.id
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
            destination_cidr_block    = "0.0.0.0/24"
            gateway_id = aws_internet_gateway.igw.id
            depends_on                = [aws_route_table.publicRT]
}


#Private Route Table
resource "aws_route_table" "privateRT" {
  vpc_id = aws_vpc.my_vpc.id
}
    resource "aws_route_table_association" "subnet_association_3" {
        subnet_id      = aws_subnet.privatesubnet1.id
        route_table_id = aws_route_table.privateRT.id
    }

    resource "aws_route_table_association" "subnet_association_4" {
        subnet_id      = aws_subnet.privatesubnet2.id
        route_table_id = aws_route_table.privateRT.id
    }

