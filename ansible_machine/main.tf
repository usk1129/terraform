provider "aws" {
    region = "us-east-1"
}

resource "aws_security_group" "ansible-newSG" {
    name = "ansible-newSG"
    vpc_id = "vpc-a50ccfd8"
    description = "New Sec Group"
    ingress {
    description = ""
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    ipv6_cidr_blocks = ["::/0"]
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    description = ""
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    ipv6_cidr_blocks = ["::/0"]
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = ""
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["188.151.197.25/32"]
  }
    egress {
    description = ""
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self = false
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "ec2" {
    ami = "ami-0947d2ba12ee1ff75"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    security_groups = [aws_security_group.ansible-newSG.name]
    tags = {
        Name = "Database Server"
    }
    key_name = "ansible_newsec"

}

