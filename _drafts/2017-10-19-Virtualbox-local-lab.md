---
title: Virtualbox local lab 
date: '2016-04-24 12:00:00'
layout: post
tags:
- misc
---


* Setup the base box
    * Install virtualbox.
    * Install base OS with some default packages like git and with virtualbox-guest-additions.
        * Install virtualbox-guest-edition:
            * `sudo apt-get install virtualbox-guest-additions-iso`
            * `sudo mount /usr/share/virtualbox/VBoxGuestAdditions.iso /media/cdrom`
            * `cd /media/cdrom`
            * `./VBoxGuestAdditions.run`
    * After installing guest-additions, clone the hdd of the base vm and we will use it to spin other vms.
        * Set VIRTUALBOX_HOME for convinience, for *nix base system do : 
            * VIRTUALBOX_HOME=$HOME/VirtualBox\ VMs
        * `VBoxManage clonehd ~/VirtualBox\ VMs/base_ubuntu/base_ubuntu.vdi $VIRTUALBOX_HOME/base_box_nat.vdi`
    * Create a NAt network adapter in virtualbox.


 * Create the base box
    * You can do it manually, make the base box you want to have.
    * Create the base user and install some base packages like git.
    * Copy the base box vdi image
        * Clone a hard drive: `VBoxManage clonehd path_to_source_vdi path_for_cloned_vm`
        * It might be something like: `VBoxManage clonehd ~/VirtualBox\ VMs/base_ubuntu/base_ubuntu.vdi ~/base_ubuntu.vdi`
    * We'll using this **base hdd** we've created for spinning up further nodes in our cluster.

* Create a NAT network in virtualbox.
    
* Create a jumpbox.

* Create VM's connected in Nat network.
