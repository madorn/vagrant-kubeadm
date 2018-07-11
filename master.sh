#!/bin/bash -eux

swapoff -a

modprobe -a ip_vs ip_vs_rr ip_vs_wrr ip_vs_sh nf_conntrack_ipv4

cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sysctl --system

sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum -y install docker-ce

systemctl enable docker && systemctl start docker

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

setenforce 0

yum install -y kubelet kubeadm kubectl vim

systemctl enable kubelet && systemctl start kubelet

systemctl stop NetworkManager

ip route del default
ip route add default via 192.168.56.1 dev enp0s8


cat <<EOF > config.yaml
kind: MasterConfiguration
apiVersion: kubeadm.k8s.io/v1alpha2
api:
  advertiseAddress: "192.168.56.60"
  bindPort: 443
networking:
  podSubnet: "10.2.0.0/16"
kubernetesVersion: "v1.11.0"
EOF

kubeadm init --config config.yaml

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
echo "export TOKEN=`kubeadm token list | awk 'FNR == 2 {print $1}'`" > /vagrant/token

sleep 60

kubectl apply -f https://raw.githubusercontent.com/madorn/vagrant-kubeadm/master/calico3.1.3.yaml
