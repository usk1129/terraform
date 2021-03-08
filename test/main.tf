provider "aws" {
    region = "us-east-1"
}

resource "aws_security_group" "launch-wizard-1" {
    name =  "launch-wizard-1"
    description = "launch-wizard-1 created 2021-01-17T01:16:58.031+01:00"
    ingress {
    description = ""
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

