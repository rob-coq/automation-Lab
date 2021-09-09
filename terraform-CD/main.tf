resource "aws_ami_copy" "dev_to_prod" {
  name              = "PROD_${var.stack}-ami"
  description       = "PROD AMI for Growler App"
  source_ami_id     = "${data.aws_ami.packer_image.id}"
  source_ami_region = "${var.region}"

  tags = {
    "OS_Version": "Ubuntu",
    "Release": "16.04",
    "Env": "{{user `environment`}}"
  }
}

data "aws_ami" "packer_image" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.stack}-ami"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["${var.owner}"]
}
