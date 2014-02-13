# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

BOX_NAME = "CentOS-6.4-x86_64-minimal"
BOX_URL  = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130731.box"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  ## Box Configuration
  config.vm.box = BOX_NAME
  config.vm.box_url = BOX_URL

  ## Network Configuration
  config.vm.network :forwarded_port, guest: 3306, host: 3306
  config.vm.network :private_network, ip: "192.168.33.200"

  ## VirtualHox Configuration
  config.vm.provider :virtualbox do |vb|
    vb.name = "Development DB Server"
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.provision :chef_solo do |chef|
    chef.run_list = [
      "recipe[mysql::default]"
    ]
  end
end
