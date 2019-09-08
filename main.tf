

# k8s-master

resource "aws_instance" "machine_k8s_master" {
  
  ami = "ami-024a64a6685d05041"
  instance_type="t2.medium" 
  
  subnet_id = aws_subnet.subnet-pub-1.id

  key_name = aws_key_pair.k8s_linuxacademy_tf_project_key.key_name

  security_groups = [
    aws_security_group.k8s-linuxacademy-terraform-project-sg.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "k8s-linuxacademy-terraform-master"
  }

  user_data = file("provisions/install-k8s-master.sh")
}


# minion 1
resource "aws_instance" "machine_minion_1" {
  ami           = "ami-0a313d6098716f372"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet-pub-1.id

  source_dest_check = false 

  key_name = aws_key_pair.k8s_linuxacademy_tf_project_key.key_name

  security_groups = [
    aws_security_group.k8s-linuxacademy-terraform-project-sg.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "k8s-linuxacademy-terraform-minion-1"
  }

  user_data = file("provisions/install-k8s-minion.sh")
}


# minion 2
resource "aws_instance" "machine_minion_2" {
  ami = "ami-0a313d6098716f372"

  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet-pub-1.id

  source_dest_check = false
  
  key_name = aws_key_pair.k8s_linuxacademy_tf_project_key.key_name

  security_groups = [
    aws_security_group.k8s-linuxacademy-terraform-project-sg.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "k8s-linuxacademy-terraform-minion-2"
  }

  user_data = file("provisions/install-k8s-minion.sh")
}
