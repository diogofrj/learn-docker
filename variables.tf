variable "awsprops" {
    type = map(string)
    default = {
    region = "us-east-2"
    vpc = "vpc-5e127f35"
    itype = "t2.micro"
    subnet = "subnet-e808cb95"
    publicip = true
    keyname = "iackey"
    secgroupname = "IAC-Sec-Group"
  }
}
