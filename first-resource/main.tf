provider "aws" {
  region = "us-east-1"
}

#export AWS_ACCESS_KEY_ID in linux
# setx AWS_SECRET_KEY_IiD
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"    
}