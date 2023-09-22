provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "myec2" {
  ami                    = "ami-0ded8326293d3201b"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0595c55da7ffa2ac4"]
  subnet_id              = "subnet-05d38866ebb130080"

  tags = {
    Name = "Linux-machine"
  }
}

/** Create and attach EIP to instance **/
resource "aws_eip" "elastic-ip" {
  domain = "vpc"
  tags = {
    Name = "Linux-machine-EIP"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.myec2.id
  allocation_id = aws_eip.elastic-ip.id
}

/** Display Output Values **/
output "public-ip" {
  value = aws_instance.myec2
}