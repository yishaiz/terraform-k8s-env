#! /bin/bash

# k8s master

set -ex

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -


cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

#  cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
#  deb https://apt.kubernetes.io/ kubernetes-xenial main
#  EOF

 sudo apt-get update
 sudo apt-get install -y docker-ce=18.06.1~ce~3-0~ubuntu kubelet=1.13.5-00 kubeadm=1.13.5-00 kubectl=1.13.5-00


 sudo kubeadm init --pod-network-cidr=10.244.0.0/16

 mkdir -p $HOME/.kube

 sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

 sudo chown $(id -u):$(id -g) $HOME/.kube/config


 kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml


# xxxxxxxxxx
 


# sudo sed -i 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/g' /etc/ssh/ssh_config
# sudo chown ubuntu /etc/ssh/ssh_config
# sudo echo "UserKnownHostsFile=/dev/null" >> /etc/ssh/ssh_config

# sudo service ssh restart

# cd /home/ubuntu

# git clone https://github.com/yishaiz/opsschool-project-k8s-master.git


