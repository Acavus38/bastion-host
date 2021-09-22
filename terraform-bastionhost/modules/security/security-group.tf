provider "aws" {
    region = "eu-central-1"
}

resource "aws_security_group" "sg_allow_rdp" {
  name        = "allow_rdp"
  description = "Allow RDP inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #-1 equal to all
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
      Name = "SG-Allow_RDP-BH"
  }  
}

output "security_group_id" {
    value = aws_security_group.sg_allow_rdp.id
}