variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "vpc_id" {}

variable "public_subnet_cidr_1" {
    default = "10.0.0.0/24"
}

variable "public_subnet_cidr_2" {
    default = "10.0.1.0/24"
}

variable "private_subnet_cidr_1" {
    default = "10.0.2.0/24"
}

variable "private_subnet_cidr_2" {
    default = "10.0.3.0/24"
}

variable "instance_type" {
  description = "The type of instance to start."
  default     = "t2.micro"
}

variable "windows_ami" {
    default = "ami-051bdd1b48a1fe0e7"
}
