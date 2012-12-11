Vagrant Ubuntu Server LAMP
==========================


Setup the Local Development Environment (LDE)
---------------------------------------------


### Install and run Vagrant

To have a local dev environment, you must do the following steps.

In the HOST machine [install vagrant](http://vagrantup.com/v1/docs/getting-started/index.html)

Download the Vagrant box's config files and, in the same directory, run

    host-machine$ vagrant up

Login into the VM with the following command.

    host-machine$ vagrant ssh

### Update the system time zone

Update the system timezone to the one that you are located.

    vagrant-machine$ sudo dpkg-reconfigure tzdata
    vagrant-machine$ sudo service cron restart

### Configure git

Generate the private and public keys. Change COMMENT with your name, email or
something that identify you.

    vagrant-machine$ ssh-keygen -t rsa -C COMMENT

Upload the public key where you need to login (at leas to the git user in jjdev)
and update the .ssh/config file.

Update you name and email on git editing the .gitconfig file or by git commands.

    vagrant-machine$ vim ~/.gitconfig

    # or

    vagrant-machine$ git config --global user.name "Firstname Lastname"
    vagrant-machine$ git config --global user.email "your_email@youremail.com"

### Update the "hosts" file in the HOST machine

Edit your "hosts" file and add the following lines.

    192.168.50.20    local.dev

In your browser go to [local.dev](http://local.dev).
