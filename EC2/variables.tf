variable "env" {
  default = "dev"
}
variable "default_region" {
  default = "us-east-2"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "ssh_key" {
  default = "password-generator"
}

variable "sg_port_cidr" {
  description = "Allowed EC2 ports"
  type        = map(any)
  default = {
    "22"   = ["X.X.X.X/32", "172.31.0.0/16"] 
    "80"   = ["0.0.0.0/0"]
    "8080" = ["0.0.0.0/0"]
  }
}

variable "cidr_vpc" {
  description = "CIDR of VPC"
  type        = string
  default     = "172.31.0.0/16"
}

variable "public_subnet" {
  type = list(string)
  default = [
    "172.31.1.0/24",
    "172.31.2.0/24"
  ]
}
