# AWS용 프로바이더 구성
provider "aws" {
    region = "ap-northeast-2"
}

# AWS용 리소스 구성
resource "aws_instance" "myserver" {
    ami = "ami-04e8dfc09b22389ad"
    instance_type = "t2.micro"
    key_name = "scent2d"
    vpc_security_group_ids = ["sg-0d5655db38b5c1d1c"]
    tags = {
        Name = "helloworld"
    }
}