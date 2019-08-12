provider "aws" {
  region = "us-east-1"
}

# get availability zones
data "aws_availability_zones" "available" {
}

# vpc

resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_network_address

  tags = {
    Name = var.vpc_name
  }
}

# internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "k8s-linuxacademy-terraform-igw"
  }
}

# nat gateway

# resource "aws_nat_gateway" "nat_gw" {
#   subnet_id     = aws_subnet.subnet-pub-1.id
#   allocation_id = aws_eip.my_eip.id
#   depends_on    = [aws_internet_gateway.igw]

#   tags = {
#     Name = "k8s-linuxacademy-tf-nat-gw"
#   }
# }

# subnets

resource "aws_subnet" "subnet-pub-1" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.subnet_pub_1_address

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "tf-subnet-pub-1"
  }
}

# resource "aws_subnet" "subnet-prv-1" {
#   vpc_id     = aws_vpc.main_vpc.id
#   cidr_block = var.subnet_prv_1_address

#   availability_zone = data.aws_availability_zones.available.names[0]

#   tags = {
#     Name = "tf-subnet-prv-1"
#   }
# }

# Create the Route Table

# public
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name" = "public terraform vpc route table"
  }
}

# # private
# resource "aws_route_table" "private-route-table" {
#   vpc_id = aws_vpc.main_vpc.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_nat_gateway.nat_gw.id
#   }

#   tags = {
#     "Name" = "private terraform vpc route table"
#   }
# }

# # Create the Internet Access

# # public
# resource "aws_route" "Terraform_VPC_internet_access" {
#   route_table_id         = aws_route_table.public-route-table.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.igw.id
# }

# # Associate the Route Table with the Subnet
# resource "aws_route_table_association" "Terraform_VPC_association" {
#   subnet_id      = aws_subnet.subnet-pub-1.id
#   route_table_id = aws_route_table.public-route-table.id
# }
 
# # Associate the Route Table with the Subnet
# resource "aws_route_table_association" "prv_rtb_association" {
#   subnet_id      = aws_subnet.subnet-prv-1.id
#   route_table_id = aws_route_table.private-route-table.id
# }

# # elastic IP

# resource "aws_eip" "my_eip" {
#   vpc        = true
#   depends_on = [aws_internet_gateway.igw]

#   tags = {
#     Name = "k8s-linuxacademy-tf-nat-gw"
#   }
# }

