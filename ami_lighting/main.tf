resource "aws_ami_from_instance" "lighting" {
  name               = "lighting_ami"
  source_instance_id = "i-09ea0bb1fd3f177d1"
}