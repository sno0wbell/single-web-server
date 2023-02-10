resource "aws_instance" "web8080" {
    ami = var.AMI
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.teste8080.id]

    user_data = <<-EOF
                #!/bin/bash
                echo "Porta acessível." > index.html
                nohup busybox httpd -f -p 8080 &
                EOF

    user_data_replace_on_change = true

    tags = {
        Name = "server-brandon"
    }
}

resource "aws_security_group" "teste8080" {
    name ="Testando 8080"

    ingress {
        from_port = var.port8080
        to_port = var.port8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}