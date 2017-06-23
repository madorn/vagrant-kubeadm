#!/bin/bash -eux
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce kubelet kubeadm kubernetes-cni jq
kubeadm reset
kubeadm init --apiserver-advertise-address 192.168.56.60
chmod 777 /etc/kubernetes/admin.conf
echo "export TOKEN=`kubeadm token list | awk 'FNR == 2 {print $1}'`" >> /vagrant/token
