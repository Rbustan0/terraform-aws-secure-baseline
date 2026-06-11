resource "aws_vpc" "main" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
        Name    = "secure-baseline-vpc"
        Project = "terraform-aws-secure-baseline"
    }
}

resource "aws_subnet" "public" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "eu-north-1a"
    map_public_ip_on_launch = false

    tags = {
        Name    = "secure-baseline-public"
        Project = "terraform-aws-secure-baseline"
    }
}

resource "aws_subnet" "private" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.2.0/24"
    availability_zone       = "eu-north-1a"
    map_public_ip_on_launch = false

    tags = {
        Name    = "secure-baseline-private"
        Project = "terraform-aws-secure-baseline"
    }
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name    = "secure-baseline-igw"
        Project = "terraform-aws-secure-baseline"
    }
}