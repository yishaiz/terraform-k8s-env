# vpc

variable "vpc_name" {
  default = "tf-k8s-linuxacademy-vpc"
}

#region
variable "region" {
  default = "us-east-1"
}

# cidr

variable "vpc_network_address" {
  default = "192.168.0.0/16"
}

# subnets
variable "subnet_pub_1_address" {
  default = "192.168.10.0/24"
}

# variable "subnet_prv_1_address" {
#   default = "192.168.15.0/24"
# }

variable "ingressCIDRblock" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "egressCIDRblock" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "ig-route" {
  default = "0.0.0.0/0"
}

# keys

variable "keypair_name" {
  description = "name of ssh key to attach to hosts genereted during apply"
  default     = "k8s_linuxacademy_project_keypair"
}

variable "pem_key_name" {
  description = "name of ssh key to attach to hosts genereted during apply"
  default     = "k8s_linuxacademy_project_keypair.pem"
}

# variable "bastion_host_private_ip_address" {
#   default = "192.168.10.10"
# }

# variable "ansible_server_private_ip_address" {
#   default = "192.168.15.20"
# }

# variable "jenkins_private_ip_address" {
#   default = "192.168.15.30"
# }

# variable "k8s_master_private_ip_address" {
#   default = "192.168.10.40"
# }

# variable "k8s_minion_1_private_ip_address" {
#   default = "192.168.10.51"
# }

# variable "k8s_minion_2_private_ip_address" {
#   default = "192.168.10.52"
# }

# variable "db_private_ip_address" {
#   default = "192.168.15.60"
# }

# variable "sql_client_private_ip_address" {
#   default = "192.168.15.70"
# }

# variable "jenkins_public_private_ip_address" {
#   default = "192.168.10.31"
# }


 
# bastion - 192.168.10.10
# ansible - 192.168.15.20
# jenkins - 192.168.15.30
# k8s_Master - 192.168.10.40
# minion_1 - 192.168.10.51
# minion_2 - 192.168.10.52

# sql_db - 192.168.15.60
# sql_client - 192.168.15.70