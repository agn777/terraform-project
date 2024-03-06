
data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "lighting" {

  instance_type               = var.instance_type
  subnet_id                   = var.public_subnets[0]
  vpc_security_group_ids      = var.security_group_ids
  ami                         = var.lighting_ami
  associate_public_ip_address = true
  key_name                    = var.key_name
  private_ip                  = "10.0.0.34" //Private IPs so that the .env file works after destroy/apply

  tags = {
    Name = "Lighting"
  }
}

resource "aws_instance" "heating" {

  instance_type               = var.instance_type
  subnet_id                   = var.public_subnets[1]
  vpc_security_group_ids      = var.security_group_ids
  ami                         = var.heating_ami
  associate_public_ip_address = true
  key_name                    = var.key_name
  private_ip                  = "10.0.1.194" //Private IPs so that the .env file works after destroy/apply

  tags = {
    Name = "Heating"
  }

}

resource "aws_instance" "status" {

  instance_type               = var.instance_type
  subnet_id                   = var.public_subnets[2]
  vpc_security_group_ids      = var.security_group_ids
  ami                         = var.status_ami
  associate_public_ip_address = true
  key_name                    = var.key_name
  private_ip                  = "10.0.2.111" //Private IPs so that the .env file works after destroy/apply

  tags = {
    Name = "Status"
  }
}

resource "aws_instance" "auth" {

  instance_type               = var.instance_type
  subnet_id                   = var.private_subnets[0]
  vpc_security_group_ids      = var.security_group_ids
  ami                         = var.auth_ami
  associate_public_ip_address = false
  key_name                    = var.key_name
  private_ip                  = "10.0.8.175" //Private IPs so that the .env file works after destroy/apply

  tags = {
    Name = "Auth"
  }
}



