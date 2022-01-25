variable "env" {
  default = "dev"
}
variable "default_region" {
  default = "us-east-2"
}
variable "ssh_key" {
  default = "passwrd"
}

variable "sg_port_cidr" {
  description = "Allowed EC2 ports"
  type        = map(any)
  default = {
    "22"   = ["X.X.X.X/32", "10.1.0.0/16"] 
    "80"   = ["0.0.0.0/0"]
    "8080" = ["0.0.0.0/0"]
  }
}
variable "instance_type" {
  default = "t2.micro"
}
# VPC
variable "cidr_vpc" {
  description = "CIDR of VPC"
  type        = string
  default     = "10.1.0.0/16"
}
# Public Subnet
variable "public_subnet" {
  type = list(string)
  default = [
    "10.1.1.0/24",
    "10.1.2.0/24"
  ]
}
