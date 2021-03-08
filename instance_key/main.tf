provider "aws" {
    region = "us-east-1"
}

#secure traffic in 
variable "ingress_rules" {
  type = list(number)
  default = [22,25,80,443,8080,8443]
}

#secure traffic out
variable "egress_rules" {
  type = list(number)
  default = [443,8443]
}

resource "aws_instance" "myec2db" {
    ami = "ami-0947d2ba12ee1ff75"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    security_groups = [aws_security_group.web_traffic.name]
    tags = {
        Name = "Database Server"
    }
    key_name = "ssh-key"
}

module "ssh-key" {
  source = "./ssh"
}

resource "aws_security_group" "web_traffic" {
    name = "Secure Server"
    dynamic "ingress" {
        iterator = port
        for_each = var.ingress_rules
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
    dynamic "egress" {
        iterator = port
        for_each = var.egress_rules
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

}

output "instance_ip" {
  description = "The public ip for ssh access"
  value       = "${aws_instance.myec2db.public_ip}"
}
