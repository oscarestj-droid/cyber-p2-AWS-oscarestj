resource "aws_instance" "my_first_server" {
  ami           = "ami-0d28727121d5d4a3c"
  instance_type = "t3.micro"
  
  tags = {
    Name = "TKH-Phase2-Instance"
  }
}