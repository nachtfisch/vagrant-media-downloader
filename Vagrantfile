# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "phusion/ubuntu-14.04-amd64" 

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.synced_folder "./", "/home/vagrant/home"

  config.vm.provider "virtualbox" do |vb|
     # vb.gui = true
 
     vb.memory = "1024"
     vb.cpus = "2"
  end

  config.vm.provision "docker" do |docker|
    docker.pull_images "ubuntu"
    docker.pull_images "jbogatay/piavpn"
  end  

  config.vm.provision "shell", path: "provision.sh"
end
