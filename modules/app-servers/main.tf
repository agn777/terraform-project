# Create a module that will create the EC2 servers required for your microservice architecture.

# Your module should;

# Create 4 EC2 Instances
# We recommend to do this without looping as they will be running different code and should be seen as different resources
# Label them as lighting, heating, status, and auth
# Be able to accept public subnet IDs
# The lighting, heating, status services should be placed into public subnets
# Be able to accept private subnet IDs
# The auth service should be placed into a private subnet
# Be able to accept multiple security group IDs
# You should use the argument vpc_security_group_ids in the aws_instance resource
# Once you are happy with this code it should be used and applied as a module, with the correct arguments passed, in your root level main.tf.

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
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  key_name = "MyWebServerKeyPair"

  tags = {
    Name = "Lighting"
  }
}

resource "aws_instance" "heating" {

  instance_type               = var.instance_type
  subnet_id                   = var.public_subnets[1]
  vpc_security_group_ids      = var.security_group_ids
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  key_name = "MyWebServerKeyPair"

  tags = {
    Name = "Heating"
  }
}

resource "aws_instance" "status" {

  instance_type               = var.instance_type
  subnet_id                   = var.public_subnets[2]
  vpc_security_group_ids      = var.security_group_ids
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  key_name = "MyWebServerKeyPair"

  tags = {
    Name = "Status"
  }
}

resource "aws_instance" "auth" {

  instance_type               = var.instance_type
  subnet_id                   = var.private_subnets[0]
  vpc_security_group_ids      = var.security_group_ids
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  key_name = "MyWebServerKeyPair"

  tags = {
    Name = "Auth"
  }
}



