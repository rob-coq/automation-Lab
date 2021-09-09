
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

variable "stack" {
    description = "Name of the Stack"
    default = "User0"
}

variable "owner" {
    description = "Owner of the AMI"
    default = "self"
}
