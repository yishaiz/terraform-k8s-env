
# security group

# global

resource "aws_security_group" "k8s-linuxacademy-terraform-project-sg" {
  vpc_id      = aws_vpc.main_vpc.id
  name        = "k8s-linuxacademy-terraform-project-sg"
  description = "k8s linuxacademy terraform vpc security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
  }
 
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "https"
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "TCP"
    self        = true
    description = "kubectl"
  }

 

  # ingress {
  #   from_port   = 3306
  #   to_port     = 3306
  #   protocol    = "TCP"
  #   cidr_blocks = ["0.0.0.0/0"]
  #   description = "DB"
  # }


  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ICMP"
  }

  ingress {
    from_port   = 30036
    to_port     = 30036
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
  }

  # ingress {
  #   from_port   = 9090
  #   to_port     = 9090
  #   protocol    = "TCP"
  #   cidr_blocks = ["0.0.0.0/0"]
  #   description = "prometheus UI"
  # }

  # ingress {
  #     from_port   = 9100
  #     to_port     = 9100
  #     protocol    = "TCP"
  #     cidr_blocks = ["0.0.0.0/0"]
  #     description = "prometheus Node exporter"
  # }


  # ingress {
  #   from_port   = 3000
  #   to_port     = 3000
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  #   description = "grafana"
  # }

  # ingress {
  #   from_port   = 179
  #   to_port     = 179
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  #   description = "tcp-179"
  # }


  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "4"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ip-np-4"
  }

 

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all"
  }


  # ingress {
  #   from_port   = 8500
  #   to_port     = 8500
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  #   description = "consul"
  # }


  # ingress {
  #   from_port   = 8300
  #   to_port     = 8300
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  #   description = "consul"
  # }

  # ingress {
  #   from_port   = 8301
  #   to_port     = 8301
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  #   description = "consul"
  # }

  tags = {
    Name = "k8s-linuxacademy-terraform-Security-Group"
  }
}


