# output for vpc
output "vpc_name" {
  description = "vpc name and details"
  value       = aws_vpc.vpc_for_dev
}

# output for internet-gateway
output "igw" {
  value = aws_internet_gateway.igw-for-dev-vpc
}

# output for public subnet
output "subnets_public" {
  value = aws_subnet.public_subnet
  
}

# output for private subnet
output "subnet_private" {
  value = aws_subnet.private_subnet
}

# output for natgateway
output "nat-gateway" {
    value = aws_nat_gateway.nat_gateway_for_dev_vpc
}

# output for route-table
output "route-table" {
    value = aws_route_table.default_rt
}


