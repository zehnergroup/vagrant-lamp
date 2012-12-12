# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # Set box configuration for Ubuntu Server Quantal 32bit
  config.vm.box = "quantald32"
  config.vm.box_url = ""

  # Set box configuration for Ubuntu Server Quantal 64bit
  #config.vm.box = "quantald64"
  #config.vm.box_url = ""


  # Assign this VM to a host-only network IP, allowing you to access it via the
  # IP.
  config.vm.network :hostonly, "192.168.50.20"

  # Enable provisioning with chef solo, specifying a cookbooks path (relative
  # to this Vagrantfile), and adding some recipes and/or roles.
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.data_bags_path = "data_bags"
    chef.add_recipe "vagrant"

    chef.json.merge!({
      "mysql" => {
        "server_root_password" => "vagrant",
        "server_repl_password" => "vagrant",
        "server_debian_password" => "vagrant"
      }
    })
  end
end
