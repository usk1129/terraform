
resource "aws_instance" "myec2db" {
    ami = "ami-0947d2ba12ee1ff75"
    instance_type = "t2.micro"
    tags = {
        Name = "DB Server"
    }
}