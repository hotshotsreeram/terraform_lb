resource "aws_instance" "lb-web-server" {
  ami             = var.ami
  instance_type   = var.type
  key_name        = var.key
  count           = 2
  security_groups = [aws_security_group.lb-web-server.name]
  user_data       = <<-EOF
  #!/bin/bash -ex
  
  sudo apt-get update
  sudo apt install nginx -y
  echo "<h1>$(curl https://api.prod.rest/?format=text)</h1>" >  /usr/share/nginx/html/index.html 
  systemctl enable nginx
  systemctl start nginx
  EOF

  tags = {
    Name = "instance-${count.index}"
  }
}