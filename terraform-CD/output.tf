output "ami_id" {
    value = "${data.aws_ami.packer_image.id}"
}
