variable "instance_type" {
  description = "The type of instance to start."
  default     = "t2.micro"
}

variable "ami_id" {
  default = "ami-05ced23e7b71d428c"
}
 
variable "subnet_id" {}

variable "instance_name"{}

variable "public_or_private" {}

variable "security_groups" {}
#aws_security_group.sg_allow_rdp.id

variable "key_name" {}