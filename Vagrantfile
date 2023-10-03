# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "starboard/ubuntu-arm64-20.04.5"
  config.vm.box_version = "20221120.20.40.0"
  config.vm.box_download_insecure = true
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.provider "vmware_desktop" do |v|
      v.ssh_info_public = true
      v.gui = false
      v.linked_clone = false
      v.vmx["ethernet0.virtualdev"] = "vmxnet3"
  end
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y apache2
  SHELL
end
