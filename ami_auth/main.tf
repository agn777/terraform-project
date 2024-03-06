resource "aws_ami_from_instance" "auth" {
  name               = "auth_ami"
  source_instance_id = "i-0c8b8644cabb87b6a"
}