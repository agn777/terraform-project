resource "aws_ami_from_instance" "status" {
  name               = "status_ami"
  source_instance_id = "i-0d0856edc6032fa39"
}