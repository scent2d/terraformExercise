# AWS용 프로바이더 구성
provider "aws" {
    region = "ap-northeast-2"
}

# AWS용 리소스 구성
resource "aws_instance" "myserver" {
    ami                             = "ami-0e4a9ad2eb120e054"
    instance_type                   = "t2.micro"
    key_name                        = "scent2d"
    vpc_security_group_ids          = ["sg-0d5655db38b5c1d1c"]
    tags = {
        Name                        = "helloworld"
    }

    # helloworld 애플리케이션 코드
    provisioner "remote-exec" {
        connection {
            user                    = "ec2-user"
            host                    = aws_instance.myserver.public_ip
            private_key             = "${file("/Users/scent2d/Cloud/AWS/IAM/scent2d.cer")}"
        }

        inline = [
            "sudo amazon-linux-extras install -y epel",
            "sudo yum install --enablerepo=epel -y nodejs",
            "sudo wget https://raw.githubusercontent.com/scent2d/Effective-DevOps-with-AWS-Second-Edition/master/Chapter02/helloworld.js -O /home/ec2-user/helloworld.js",
            "sudo node /home/ec2-user/helloworld.js",
        ]
    }
}