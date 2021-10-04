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

    connection {
        user                        = "ec2-user"
        host                        = aws_instance.myserver.public_ip
        private_key                 = "${file("/Users/scent2d/Cloud/AWS/IAM/scent2d.cer")}"
    } 
   
    
    provisioner "local-exec" {
        command = "echo '${self.public_ip}' > ./myinventory"
    }

    provisioner "local-exec" {
        command = "ansible-playbook -i myinventory --private-key=/Users/scent2d/Cloud/AWS/IAM/scent2d.cer helloworld.yml"
    } 
}

# EC2 IP Address
output "myserver" {
    value = "${aws_instance.myserver.public_ip}"
}