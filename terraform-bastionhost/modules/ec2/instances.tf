provider "aws" {
    region = "eu-central-1"
}

resource "aws_instance" "Instance" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    associate_public_ip_address = var.public_or_private
    key_name = var.key_name
    vpc_security_group_ids = var.security_groups
    get_password_data = "true"

    tags = {
      Name = var.instance_name
  }  
}

    # output "public_ip" {
    #     value = aws_instance.publicInstance.public_ip
    # }

    # output "public_dns" {
    #     value = aws_instance.publicInstance.public_dns
    # }

    # output "admin_password" {
    #     value = rsadecrypt(aws_instance.publicInstance.password_data,file("bastionHost.pem"))
    # }

# resource "aws_instance" "privateInstance" {
#     ami = var.windows_ami
#     instance_type = var.instance_type
#     subnet_id = var.publicsubnet1_id
#     associate_public_ip_address = "false"
#     key_name = "bastionHost"
#     security_groups = [aws_security_group.sg_allow_rdp.id] 

#     depends_on = [aws_route_table.privateRT]

#     tags = {
#       Name = "PrivateInstance-BH"
#   }  
# }
