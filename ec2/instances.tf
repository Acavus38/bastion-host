provider "aws" {
    region = "eu-central-1"
}

resource "aws_instance" "publicInstance" {
    ami = var.windows_ami
    instance_type = var.instance_type
}

resource "aws_instance" "privateInstance" {
    ami = var.windows_ami
    instance_type = var.instance_type
}
 