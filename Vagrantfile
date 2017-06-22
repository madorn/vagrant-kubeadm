# -*- mode: ruby -*-

# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/xenial64"

# Begin node1
  config.vm.define "kubeadm-master1" do |node1|
    node1.vm.hostname = "kubeadm-master1"

    node1.vm.provider "vmware_fusion" do |vf, override|
	override.vm.network "private_network", ip: "172.16.99.100"
        vf.vmx["numvcpus"] = "1"
        vf.vmx["memsize"] = "2048"
        vf.vmx["vhv.enable"] = "TRUE"
	vf.vmx["ethernet1.present"] = "TRUE"
    	vf.vmx["ethernet1.connectionType"] = "hostonly"
    	vf.vmx["ethernet1.virtualDev"] = "e1000"
    	vf.vmx["ethernet1.wakeOnPcktRcv"] = "FALSE"
    	vf.vmx["ethernet1.addressType"] = "generated"
	vf.vmx["ethernet1.vnet"]  = "vmnet1"
        end

   node1.vm.provider "virtualbox" do |vb, override|
	override.vm.network "private_network", ip: "192.168.56.60"
        vb.customize [ "modifyvm", :id, "--cpus", "1" ]
        vb.customize [ "modifyvm", :id, "--memory", "4000" ]
	vb.customize [ "modifyvm", :id, "--hostonlyadapter2", "vboxnet0"]
   end
   node1.vm.provision :shell, path: "master.sh"
end
# End node1

# Begin node2
  config.vm.define "kubeadm-worker1" do |node2|
    node2.vm.hostname = "kubeadm-worker1"

    node2.vm.provider "vmware_fusion" do |vf, override|
        override.vm.network "private_network", ip: "172.16.99.100"
        vf.vmx["numvcpus"] = "1"
        vf.vmx["memsize"] = "2048"
        vf.vmx["vhv.enable"] = "TRUE"
        vf.vmx["ethernet1.present"] = "TRUE"
        vf.vmx["ethernet1.connectionType"] = "hostonly"
        vf.vmx["ethernet1.virtualDev"] = "e1000"
        vf.vmx["ethernet1.wakeOnPcktRcv"] = "FALSE"
        vf.vmx["ethernet1.addressType"] = "generated"
        vf.vmx["ethernet1.vnet"]  = "vmnet1"
        end

   node2.vm.provider "virtualbox" do |vb, override|
        override.vm.network "private_network", ip: "192.168.56.61"
        vb.customize [ "modifyvm", :id, "--cpus", "1" ]
        vb.customize [ "modifyvm", :id, "--memory", "2000" ]
        vb.customize [ "modifyvm", :id, "--hostonlyadapter2", "vboxnet0"]
   end
   node2.vm.provision :shell, path: "worker.sh"
end
# End node2


# Begin node3
  config.vm.define "kubeadm-worker2" do |node3|
    node3.vm.hostname = "kubeadm-worker2"

    node3.vm.provider "vmware_fusion" do |vf, override|
        override.vm.network "private_network", ip: "172.16.99.100"
        vf.vmx["numvcpus"] = "1"
        vf.vmx["memsize"] = "2048"
        vf.vmx["vhv.enable"] = "TRUE"
        vf.vmx["ethernet1.present"] = "TRUE"
        vf.vmx["ethernet1.connectionType"] = "hostonly"
        vf.vmx["ethernet1.virtualDev"] = "e1000"
        vf.vmx["ethernet1.wakeOnPcktRcv"] = "FALSE"
        vf.vmx["ethernet1.addressType"] = "generated"
        vf.vmx["ethernet1.vnet"]  = "vmnet1"
        end

   node3.vm.provider "virtualbox" do |vb, override|
        override.vm.network "private_network", ip: "192.168.56.62"
        vb.customize [ "modifyvm", :id, "--cpus", "1" ]
        vb.customize [ "modifyvm", :id, "--memory", "2000" ]
        vb.customize [ "modifyvm", :id, "--hostonlyadapter2", "vboxnet0"]
   end
   node3.vm.provision :shell, path: "worker.sh"
end
# End node3
end
