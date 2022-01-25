resource "aws_instance" "web1" {
  count                  = length(var.public_subnet)
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type 
  subnet_id              = aws_subnet.public_subnet[count.index].id 
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name               = var.ssh_key 
  user_data              = file("./shell/apache.sh")

  tags = {
    Name        = "Webserver-${count.index + 1}"
    AZ          = "${data.aws_availability_zones.available.names[count.index]}"
    Owner       = "Student"
    Environment = var.env
  }

  depends_on = [aws_internet_gateway.igw]
}
