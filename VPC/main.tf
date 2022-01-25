resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr_vpc
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name  = "my-${var.env}-VPC"
    Owner = "Student"
  }
}

resource "aws_subnet" "public_subnet" {
  count  = length(var.public_subnet) 
  vpc_id = aws_vpc.vpc.id            
  cidr_block              = cidrsubnet(var.cidr_vpc, 4, count.index + 1)             
  availability_zone       = data.aws_availability_zones.available.names[count.index] 
  map_public_ip_on_launch = true                                                     

  tags = {
    Name              = "Subnet-${var.env}-${count.index + 1}"
    Availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  }

  depends_on = [aws_vpc.vpc] 
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "IGW-${var.env}"
    Description = "Internet Gateway for VPC"
    Environment = "${var.env}"
  }
}


resource "aws_route_table" "publicroute" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"                 
    gateway_id = aws_internet_gateway.igw.id 
  }

  tags = {
    Name = "PublicRouteTable-${var.env}"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table_association" "publicrouteAssociation" {
  count          = length(var.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.publicroute.id

  depends_on = [aws_subnet.public_subnet, aws_route_table.publicroute]
}
