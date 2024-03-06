resource "aws_ami_from_instance" "heating" {
  name               = "heating_ami"
  source_instance_id = "i-0c35f2a8c355a531f"
}