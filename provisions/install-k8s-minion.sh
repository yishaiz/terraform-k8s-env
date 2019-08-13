#! /bin/bash

# k8s minion

set -ex

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

#  cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
#  deb https://apt.kubernetes.io/ kubernetes-xenial main
#  EOF

cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF


# sudo tee /etc/apt/sources.list.d/kubernetes.list deb https://apt.kubernetes.io/ kubernetes-xenial main


 sudo apt-get update
 sudo apt-get install -y docker-ce=18.06.1~ce~3-0~ubuntu kubelet=1.13.5-00 kubeadm=1.13.5-00 kubectl=1.13.5-00


# xxx

# sudo sed -i 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/g' /etc/ssh/ssh_config
# sudo chown ubuntu /etc/ssh/ssh_config
# sudo echo "UserKnownHostsFile=/dev/null" >> /etc/ssh/ssh_config

# sudo service ssh restart
