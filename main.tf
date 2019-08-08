
#  *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *

# machines

# bastion key

# ec2 machines



# k8s-master

resource "aws_instance" "machine_k8s_master" {
  
  ami = "ami-024a64a6685d05041"
  instance_type="t2.medium" 
  
  subnet_id     = aws_subnet.subnet-pub-1.id

  # private_ip    = var.k8s_master_private_ip_address  # "192.168.10.40"
  # key_name = aws_key_pair.opsschool_project_key.key_name

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

  private_ip = var.k8s_minion_1_private_ip_address   # "192.168.10.51"

  source_dest_check = false 

  key_name = aws_key_pair.opsschool_project_key.key_name

  iam_instance_profile   = "${aws_iam_instance_profile.consul-join.name}"

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

  private_ip = var.k8s_minion_2_private_ip_address   # "192.168.10.52"
  
  source_dest_check = false
  
  key_name = aws_key_pair.opsschool_project_key.key_name

  iam_instance_profile   = "${aws_iam_instance_profile.consul-join.name}"

  security_groups = [
    aws_security_group.k8s-linuxacademy-terraform-project-sg.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "k8s-linuxacademy-terraform-minion-2"
  }

  # user_data = file("provisions/install-consul-client2.sh")
}










# resource "aws_instance" "machine_bastion_host" {
#   ami           = "ami-0a313d6098716f372"
#   instance_type = "t2.micro"
#   subnet_id     = aws_subnet.subnet-pub-1.id
#   private_ip    = var.bastion_host_private_ip_address

#   key_name = aws_key_pair.opsschool_project_key.key_name

#   iam_instance_profile   = "${aws_iam_instance_profile.consul-join.name}"

#   security_groups = [
#     aws_security_group."k8s-linuxacademy-terraform-project-sg.id
#   ]

#   associate_public_ip_address = true

#   tags = {
#     Name = "terraform-bastion-host"
#   }

#   depends_on=["aws_instance.machine_ansible_server"]

#   connection {
#     host        = coalesce(self.public_ip, self.private_ip)
#     user        = "ubuntu" # todo use var
#     type        = "ssh"
#     private_key = file("${path.module}/${local_file.private_key.filename}")
#   }

#   provisioner "file" {
#     source      = "./${local_file.private_key.filename}"
#     destination = ".ssh/${local_file.private_key.filename}"
#   }

#   user_data = file("provisions/install-bastion.sh")
 
  
#   provisioner "local-exec" {
#     command    = "./arts/start-art.sh"
#     on_failure = "continue"
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "set -ex",
#       "chmod 700 .ssh/${local_file.private_key.filename}",
#       "cat .ssh/${local_file.private_key.filename} >> .ssh/id_rsa",
#       "chmod 400 .ssh/id_rsa",
   
# #  ansible
#      "ssh -o stricthostkeychecking=no ubuntu@192.168.15.20  \"while [ ! -f /tmp/userdata-init-done ]; do sleep 2; echo wait for ansible. retrying ...; done; echo ansible is ready\"",
#      "ssh -o stricthostkeychecking=no ubuntu@192.168.15.20 ./opsschool-project-ansible/run-ansible-playbooks.sh",

# # public jenkins
#      "ssh -o stricthostkeychecking=no ubuntu@192.168.10.31  \"while [ ! -f /tmp/userdata-init-done ]; do sleep 2; echo wait for jenkins. retrying ...; done; echo jenkins is ready\"",
#      "ssh -o stricthostkeychecking=no ubuntu@192.168.10.31 sudo java -jar ~ubuntu/jenkins-cli.jar -s http://localhost:8080/ -auth yishai:JenkinsOps1234! build jenkins-job-template",

# # web server
#      "ssh -o stricthostkeychecking=no ubuntu@192.168.15.30  \"while [ ! -f /tmp/userdata-init-done ]; do sleep 2; echo wait for jenkins. retrying ...; done; echo web server is ready\"",
#      "ssh -o stricthostkeychecking=no ubuntu@192.168.15.30 sudo java -jar ~ubuntu/jenkins-cli.jar -s http://localhost:8080/ -auth yishai:JenkinsOps1234! build jenkins-job-template"

#     ]
 
#   }

#   provisioner "local-exec" {
#     command    = "./arts/end-art.sh"
#     on_failure = "continue"
#   }

# }


# # ansible-server
# resource "aws_instance" "machine_ansible_server" {
#   ami           = "ami-0a313d6098716f372"
#   instance_type = "t2.micro"
#   subnet_id     = aws_subnet.subnet-prv-1.id
#   private_ip    = var.ansible_server_private_ip_address  # "192.168.15.20"

#   key_name = aws_key_pair.opsschool_project_key.key_name

#   security_groups = [
#     aws_security_group."k8s-linuxacademy-terraform-project-sg.id
#   ]

#   depends_on = [
#     aws_instance.machine_k8s_master,
#     aws_instance.machine_minion_1,
#     aws_instance.machine_minion_2,
#     local_file.private_key
#   ]

#   tags = {
#     Name = "terraform-ansible-server"
#   }
 
#   user_data = "${data.template_file.ansible_init.rendered}"
# }

# data "template_file" "ansible_init"{
#   template = "${file("provisions/install-ansible.tmpl")}"
#   vars = {
#     key_base64 = "${base64encode(tls_private_key.opsschool_project_rsa_key.private_key_pem)}"
#   }
# }

# output "private_key" {
#   value     = local_file.private_key.filename
#   sensitive = true
# }


# # # jenkins

# resource "aws_instance" "machine_jenkins" {
#   ami = "ami-053d6d4ef6a41c14b" 
#   instance_type = "t2.micro"
#   subnet_id = "${aws_subnet.subnet-prv-1.id}"
#   private_ip = "${var.jenkins_private_ip_address}"   # "192.168.15.30"

#   key_name = aws_key_pair.opsschool_project_key.key_name

#   security_groups = [
#     "${aws_security_group.terraform-project-jenkins-sg.id}"]

# depends_on = [
#     aws_instance.machine_k8s_master,
#     aws_instance.machine_minion_1,
#     aws_instance.machine_minion_2,
#     local_file.private_key
#   ]

#   tags = {
#     Name = "terraform-jenkins"
#   }
 

#   user_data = "${data.template_file.jenkins_init.rendered}"
# }

# data "template_file" "jenkins_init"{
#   template = "${file("provisions/install-jenkins.tmpl")}"
#   vars = {
#     key_base64 = "${base64encode(tls_private_key.opsschool_project_rsa_key.private_key_pem)}"
#   }
# }

# data "template_file" "jenkins_public_init"{
#   template = "${file("provisions/install-jenkins-public.tmpl")}"
#   vars = {
#     key_base64 = "${base64encode(tls_private_key.opsschool_project_rsa_key.private_key_pem)}"
#   }
# }

# # web server 


# resource "aws_instance" "machine_jenkins_public" {
#   ami = "ami-053d6d4ef6a41c14b" 
#   instance_type = "t2.micro"
#   subnet_id = "${aws_subnet.subnet-pub-1.id}"
#   private_ip = "${var.jenkins_public_private_ip_address}"

#   key_name = aws_key_pair.opsschool_project_key.key_name

#   security_groups = [
#     "${aws_security_group.terraform-project-jenkins-sg.id}"]

# depends_on = [
#     aws_instance.machine_k8s_master,
#     aws_instance.machine_minion_1,
#     aws_instance.machine_minion_2,
#     local_file.private_key
#   ]

#   associate_public_ip_address = true

#   tags = {
#     Name = "terraform-web-server"
#   }
 

#   user_data = "${data.template_file.jenkins_public_init.rendered}"
# }
# # mysql-server

# resource "aws_instance" "machine_db_mysql" {
#   ami           = "ami-0a313d6098716f372"
#   instance_type = "t2.micro"
#   subnet_id     = aws_subnet.subnet-prv-1.id
#   private_ip    = var.db_private_ip_address   # "192.168.15.60"

#   key_name = aws_key_pair.opsschool_project_key.key_name

#   security_groups = [
#     aws_security_group.terraform-project-db-sg.id,
#   ] 

#   tags = {
#     Name = "terraform-mysql-db"
#   }

#   user_data = file("provisions/install-db.sh")
# }

# # # mysql-server
# # resource "aws_instance" "machine_mysql_client" {
# #   ami           = "ami-0a313d6098716f372"
# #   instance_type = "t2.micro"
# #   subnet_id     = aws_subnet.subnet-prv-1.id
# #   private_ip    = var.sql_client_private_ip_address  # "192.168.15.70"

# #   key_name = aws_key_pair.opsschool_project_key.key_name

# #   security_groups = [
# #     aws_security_group.terraform-project-db-sg.id,
# #   ]


# #   tags = {
# #     Name = "terraform-mysql-client"
# #   }


# #   user_data = file("provisions/install-sql-client.sh")
# # }

