# AWS용 프로바이더 구성
provider "aws" {
    region = "ap-northeast-2"
}

# AWS용 리소스 구성
resource "aws_instance" "myserver" {
    ami                             = "ami-04e8dfc09b22389ad"
    instance_type                   = "t2.micro"
    key_name                        = "scent2d"
    vpc_security_group_ids          = ["sg-0d5655db38b5c1d1c"]
    tags = {
        Name                        = "helloworld"
    }

    provisioner "remote_exec" {
        connection {
            user                    = "ec2-user"
            host                    = aws_instance.myserver.public_ip
            private_key             = "${file("/Users/scent2d/Cloud/AWS/IAM/scent2d.cer")}"
        }
        inline = [
            "sudo amazon-linux-extras install -y epel",
            "sudo yum install --enablerepo=epel -y ansible git",
            "sudo ansible-pull -U https://github.com/yogeshraheja/ansible/helloworld.yml -i localhost",
        ]
    }
}

# EC2 IP Address
output "myserver" {
    value = "${aws_instance.myserver.public_ip}"
}