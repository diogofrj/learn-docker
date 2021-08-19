data "aws_ami" "latest-ubuntu" {
most_recent = true
owners = ["099720109477"] # Canonical

  filter {
      name   = "name"
      values = ["ubuntu-minimal/images/hvm-ssd/ubuntu-focal-20.04-amd64-minimal*"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}

