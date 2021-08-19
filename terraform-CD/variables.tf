
variable region {
    description = "AWS Region"
    default = "us-east-1"
}

variable access_key {
    description = "AWS access key"
}
variable secret_key {
    description = "AWS secret key"
}

variable "owner" {
    description = "Owner of the AMI"
    default = "self"
}
