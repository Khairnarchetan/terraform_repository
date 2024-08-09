# creating a vpc using variable
resource "aws_vpc" "vpc_for_dev" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.instance_tenancy

  tags = merge(var.additional_tags,
    {
      Name = "${var.company_name}-${var.region}-${var.env.0}-vpc"
    }
  )
}
# creating a internet-gateway using variable
resource "aws_internet_gateway" "igw-for-dev-vpc" {
  vpc_id = aws_vpc.vpc_for_dev.id

  tags = merge(var.additional_tags,
    {
      #Name = "${var.company_name}-${var.region}-${var.env.0}-IGW"
      Name = format("%s-%s-%s-IGW", var.company_name, var.region, var.env.0)
    }
  )
}

# creating public-subnet using variable 
resource "aws_subnet" "public_subnet" {
  vpc_id              = aws_vpc.vpc_for_dev.id
  count               = length(var.cidr_block_for_public_subnets)
  cidr_block          = var.cidr_block_for_public_subnets[count.index]
  availability_zone   = element(var.az, count.index)
  map_public_ip_on_launch = var.map_public_ip

   tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}
# creating private-subnet using variable
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc_for_dev.id
  count             = length(var.cidr_block_for_private_subnets)
  cidr_block        = var.cidr_block_for_private_subnets[count.index]
  availability_zone = element(var.az, count.index)
  tags = merge(
    { Name = "private-subnet-test-${count.index + 1}" },
    var.additional_tags
  )
}

# An Elastic IP for the NAT Gateway
resource "aws_eip" "eip_for_nat" {
  domain = var.eip_for_nat
}

# Create a NAT Gateway
resource "aws_nat_gateway" "nat_gateway_for_dev_vpc" {
  allocation_id = aws_eip.eip_for_nat.id   # Use the id attribute here
  subnet_id     = aws_subnet.public_subnet.0.id

  tags = merge (
    {
      Name = format("%s-%s-%s-NAT", var.company_name, var.region, var.env.0)
    },
    var.additional_tags
  )
}
# Create a route table for public subnets with internet-Gateway
resource "aws_route_table" "default_rt" {
  vpc_id = aws_vpc.vpc_for_dev.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-for-dev-vpc.id
  }
  tags = merge(
    { 
      Name = format("%s-%s-%s-default-RT", var.company_name, var.region, var.env.0)
    },
    var.additional_tags
  )
}
# route-table  association for public-subnet-association-1 
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.0.id
  route_table_id = aws_route_table.default_rt.id
}
# route-table  association for public-subnet-association-2 
resource "aws_route_table_association" "public_subnet_association1" {
  subnet_id      = aws_subnet.public_subnet.1.id
  route_table_id = aws_route_table.default_rt.id
}
# route-table for private-subnet with nat-gateway
resource "aws_route_table" "private_rt_for_dev_vpc" {
  vpc_id = aws_vpc.vpc_for_dev.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_for_dev_vpc.id
  }
  tags = merge(
    { 
      Name = format("%s-%s-%s-private-RT", var.company_name, var.region, var.env.0)
    },
    var.additional_tags
  )
}
#  route-table  association for private-subnet-association-1
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.0.id
  route_table_id = aws_route_table.private_rt_for_dev_vpc.id
}
# route-table  association for private-subnet-association-2 
resource "aws_route_table_association" "private_subnet_association1" {
  subnet_id      = aws_subnet.private_subnet.1.id
  route_table_id = aws_route_table.private_rt_for_dev_vpc.id
}
#  route-table  association for private-subnet-association-3
resource "aws_route_table_association" "private_subnet_association2" {
  subnet_id      = aws_subnet.private_subnet.2.id
  route_table_id = aws_route_table.private_rt_for_dev_vpc.id
}
#  route-table  association for private-subnet-association-4
resource "aws_route_table_association" "private_subnet_association3" {
  subnet_id      = aws_subnet.private_subnet.3.id
  route_table_id = aws_route_table.private_rt_for_dev_vpc.id
}
#  route-table  association for private-subnet-association-5
resource "aws_route_table_association" "private_subnet_association4" {
  subnet_id      = aws_subnet.private_subnet.4.id
  route_table_id = aws_route_table.private_rt_for_dev_vpc.id
}


# Associate the route table with private subnets
# resource "aws_route_table_association" "private_route_table_association" {
#   for_each = toset(var.private_subnet_ids_for_dev_vpc)

#   subnet_id      = each.value
#   route_table_id = var.private_route_table_id_for_dev_vpc
# }