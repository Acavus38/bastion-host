variable "instance_type" {
  description = "The type of instance to start."
  default     = "t2.micro"
}

variable "windows_ami" {
    default = "ami-051bdd1b48a1fe0e7"
}
