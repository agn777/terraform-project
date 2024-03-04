
resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/20"
  enable_dns_hostnames = true

  tags = {
    Name = "CE Project VPC"
  }

}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets)

  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = var.public_subnets[count.index]

  tags = {
    Name = "Public subnet ${count.index +1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = var.private_subnets[count.index]

  tags = {
    Name = "Private subnet ${count.index +1}"
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_eip" "nat_eips" {
  count = length(var.public_subnets)
}

resource "aws_nat_gateway" "nat" {
  count         = length(var.public_subnets)

  allocation_id = aws_eip.nat_eips[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id

  tags = {
    Name = "NAT Gateway ${count.index + 1}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main_vpc.id
  count = length(aws_subnet.private_subnets[*])

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat[count.index].id
  }

  tags = {
    Name = "Private route table ${count.index + 1}"
  }
}

resource "aws_route_table_association" "private_routes" {
  count          = length(aws_subnet.private_subnets[*])
  route_table_id = aws_route_table.private[count.index].id
  subnet_id      = aws_subnet.private_subnets[count.index].id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public route table"
  }
}

resource "aws_route_table_association" "public_routes" {
  count          = length(aws_subnet.public_subnets[*])
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_subnets[count.index].id
}
