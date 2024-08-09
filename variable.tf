# variable for creating vpc
variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
  description = "CIDR for vpc"
}
variable "instance_tenancy" {
  type = string
  default = "default"
  description = "tenancy for instances in VPC"
}
variable "vpc_name" {
  type = string
  default = "dev-vpc"
  description = "name of VPC"
}

# variable for creating internet-gateway
variable "igw_for_dev_vpc" {
  type = string
  default = "igw_for_dev_VPC"
  description = "interet gateway for dev-vpc"
}

# variable for cidr block of public subnet
variable "cidr_block_for_public_subnets" {
  type        = list(string)
  default     = ["10.0.6.0/24", "10.0.7.0/24"]
  description = "subnet CIDR for public subnet dev-vpc"
}
# variable for map-public-ip of subnet
variable "map_public_ip" {
 type= bool
 default = true
 description = "public Ip enable or not"
}

#variable for public/private subnet  
variable "subnet_name" {
  type = list(string)
  default = ["public_subnet","private_subnet"]
  description = "subnets for dev-vpc"
}

# variable for additional tags
variable "additional_tags" {
  type = map(any)
  default = {
    project_name = "test_123"
    purpose      = "dev_env"
    country      = "india"
  }
}
# variable for env
variable "env" {
  type        = list(string)
  default     = ["dev", "prod"]
  description = "name of env"
}
# variable for company-name
variable "company_name" {
  type        = string
  default     = "cloudblitz"
  description = "name of company"
}
# variable for region
variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "region of infra"
}
# variable for availability-zone
variable "az" {
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  description = "name of env"
}
variable "cidr_block_for_private_subnets" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
  description = "subnet CIDR for private subnet dev-vpc"
}

# variable for natgateway
variable "nat_gateway" {
  type = string
  default = "nat for dev vpc"  
}

# Variable for Elastic IP for nat-gateway
variable "eip_for_nat" {
  description = "elastic ip for the NAT Gateway (Elastic IP)"
  type        = string
  default     = "vpc"    #domain-name
}

# # Variable for subnet ID where NAT Gateway will be placed
# variable "nat_gateway_subnet_id" {
#   description = "The ID of the subnet where the NAT Gateway will be placed"
#   type        = string
# }

# # variable for route table
# variable "RT_for_dev_vpc" {
#   type = string
#   default = "RT_for_dev_VPC"
#   description = "Route_table for dev-vpc"

# }

# # Variable for private subnet IDs
# variable "private_subnet_ids_for_dev_vpc" {
#   description = "List of private subnet IDs"
#   type        = list(string)
# }

# # Variable for the route table ID
# variable "private_route_table_id_for_dev_vpc" {
#   description = "The ID of the private route table"
#   type        = string
# }