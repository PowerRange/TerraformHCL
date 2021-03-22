terraform {
  required_version = ">= 0.12.0"
}

provider "random" {
  version = ">= 1.2, < 3.0.0"
}

resource "aws_subnet" "public" {
  count = length(var.subnet_availability_zones)

  availability_zone       = element(var.subnet_availability_zones, count.index)
  cidr_block              = cidrsubnet(var.vpc_cidr_block, "4", count.index)
  map_public_ip_on_launch = "true"
  vpc_id                  = aws_vpc.this.id



resource "aws_autoscaling_group" "example" {
  availability_zones     = ["us-east-1a"]
  desired_capacity       = 3
  max_size               = 5
  min_size               = 2
  healtcheck_check_type  = "EC2"

  launch_template {
    id      = aws_launch_template.example.id
    version = aws_launch_template.example.latest_version
  }

  tag {
    key                 = "Key"
    value               = "Value"
    propagate_at_launch = true
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 45
    }
    triggers = ["tag"]
  }
}
