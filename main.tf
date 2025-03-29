provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name   = var.vpc_name
    Source = "terraform"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name   = var.subnet_name
    Source = "terraform"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name   = var.igw_name
    Source = "terraform"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = var.rt_cidr
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name   = var.route_table_name
    Source = "terraform"
  }
}


resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "allow_all" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    description = "Allow all inbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = var.security_group_name
    Service = "Terraform"
  }
}


resource "aws_instance" "instance" {
  ami                         = "ami-071226ecf16aa7d96"
  availability_zone           = var.ec2_az
  instance_type               = var.ec2_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.my_subnet.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "AWS-Server"
    Env        = "Prod"
    Owner      = "Akansha"
    CostCenter = "ABCD"
  }
}

