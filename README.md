Vagrant Ubuntu Server LAMP
==========================


Setup the Local Development Environment (LDE)
---------------------------------------------


### Install and run Vagrant

To have a local dev environment, you must do the following steps.

First of all you need to [install vagrant](http://vagrantup.com/v1/docs/getting-started/index.html).

Download the [Vagrant box's configuration files](https://github.com/zehnergroup/vagrant-lamp/archive/master.zip)
and uncompress the downloaded zip file.

> In the extracted directory, edit the `data_bags/sites/local.json` file and
> insert the domain name that you would like to use as your LDE.

Run the following command to start the VM.

> Take in mind that the first time Vagrant will download the box, unpack it,
> start it and then setup it based on the provisions (chef recipes).

    host-machine$ vagrant up

> If you don't want to run the provisions on each boot, you'll need to add the
> `--no-provision` argument to the `vagrant up` command.

Login into the VM with the following command.

    host-machine$ vagrant ssh

### Update the system time zone

Update the system timezone to the one that you are located.

    vagrant-machine$ sudo dpkg-reconfigure tzdata
    vagrant-machine$ sudo service cron restart

### Configure git

Generate the private and public keys.

    vagrant-machine$ ssh-keygen -t rsa -C COMMENT

> Change COMMENT with your name, email or something that identify you.

Use the generated key on every place that you need [SSH Public-Key authentication](https://hkn.eecs.berkeley.edu/~dhsu/ssh_public_key_howto.html).
Check [github:help](https://help.github.com/articles/generating-ssh-keys) for
more information.

Update you git's name and email, editing the .gitconfig file or by git commands.

    vagrant-machine$ vim ~/.gitconfig

    # or

    vagrant-machine$ git config --global user.name "Firstname Lastname"
    vagrant-machine$ git config --global user.email "your_email@youremail.com"

### Update the "hosts" file in the HOST machine

Edit the [hosts](http://en.wikipedia.org/wiki/Hosts_%28file%29%23Location_in_the_file_system)
file and add the following line. If you want to use a different development domain, edit the `data_bags/sites/local.json`

    192.168.50.20    CHOSEN_DOMAIN_NAME

> `192.168.50.20` is the Guest IP that is configured in the Vagrantfile, under
> the `config.vm.network` directive.
> `CHOSEN_DOMAIN_NAME` is the domain name that appear in the `data_bags/sites/local.json`
> file.

Open your browser and go to the `CHOSEN_DOMAIN_NAME` (by default [local.dev](http://local.dev))
