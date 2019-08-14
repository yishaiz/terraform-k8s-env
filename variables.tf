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
  default     = "k8s_linuxacademy_tf_project_keypair"
}

variable "pem_key_name" {
  description = "name of ssh key to attach to hosts genereted during apply"
  default     = "k8s_linuxacademy_tf_project_keypair.pem"
}

