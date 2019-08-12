
#  *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *

# machines

# ec2 machines



# k8s-master

resource "aws_instance" "machine_k8s_master" {
  
  ami = "ami-024a64a6685d05041"
  instance_type="t2.medium" 
  
  subnet_id     = aws_subnet.subnet-pub-1.id

  # private_ip    = var.k8s_master_private_ip_address  # "192.168.10.40"
  key_name = aws_key_pair.k8s_linuxacademy_tf_project_key.key_name

  security_groups = [
    aws_security_group.k8s-linuxacademy-terraform-project-sg.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "k8s-linuxacademy-terraform-master"
  }

  # user_data = file("provisions/install-k8s-master.sh")
}


# minion 1
resource "aws_instance" "machine_minion_1" {
  ami           = "ami-0a313d6098716f372"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet-pub-1.id

  # private_ip = var.k8s_minion_1_private_ip_address   # "192.168.10.51"

  source_dest_check = false 

  key_name = aws_key_pair.k8s_linuxacademy_tf_project_key.key_name

  # iam_instance_profile   = "${aws_iam_instance_profile.consul-join.name}"

  security_groups = [
    aws_security_group.k8s-linuxacademy-terraform-project-sg.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "k8s-linuxacademy-terraform-minion-1"
  }

  # user_data = file("provisions/install-consul-client.sh")
}


# minion 2
resource "aws_instance" "machine_minion_2" {
  ami = "ami-0a313d6098716f372"

  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet-pub-1.id

  # private_ip = var.k8s_minion_2_private_ip_address   # "192.168.10.52"
  
  source_dest_check = false
  
  key_name = aws_key_pair.k8s_linuxacademy_tf_project_key.key_name

  # iam_instance_profile   = "${aws_iam_instance_profile.consul-join.name}"

  security_groups = [
    aws_security_group.k8s-linuxacademy-terraform-project-sg.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "k8s-linuxacademy-terraform-minion-2"
  }

  # user_data = file("provisions/install-consul-client2.sh")
}








