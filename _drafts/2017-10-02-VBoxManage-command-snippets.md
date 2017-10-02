---
title: Virtualbox VBoxManage command snippets 
date: '2017-09-16 00:00:00 +0000'
tags:
- misc.
layout: post
---

---


* **Creating a jumpbox**
    * Create the base box
        * You can do it manually, make the base box you want to have.
    * Copy the base box vdi image
        * Clone a hard drive: `VBoxManage clonehd path_to_source_vdi path_for_cloned_vm`
        * It might be something like: `VBoxManage clonehd ~/VirtualBox\ VMs/base_ubuntu/base_ubuntu.vdi ~/base_ubuntu.vdi`

    * Create a new machine using that vdi
        * `VBoxManage createvm --name "jumpbox" --ostype Debian_64 --register`
        * `VBoxManage modifyvm "jumpbox" --nic1 hostonly --hostonlyadapter1 "vboxnet0"`
        * `VBoxManage storagectl "jumpbox" --name "sata1" --add sata`
        * `VBoxManage storageattach "jumpbox" --storagectl "sata1" --port 0 --device 0 --type hdd --medium ~/base_ubuntu.vdi --mtype multiattach`
        * Above steps will not clone the entire vdi, but will do copy-on-write<sup>[Reference](https://www.electricmonk.nl/log/2011/09/24/multiple-virtualbox-vms-using-one-base-image-copy-on-write/){:target="_blank"}</sup>
        * `VBoxManage startvm "clone1"`

* **Create the nat-networked node**
    * Create the vm:
        * `VBoxManage createvm --name "kubemaster" --ostype Ubuntu_64 --register`
    * Add the network adapter to the vm
        * `VBoxManage modifyvm "kubemaster" --nic1 natnetwork --nat-network1 "nat_network_name"`
    * Adding the base image to the new virtual machine. 
        * `VBoxManage storageattach "kubemaster" --storagectl "sata1" --port 0 --device 0 --type hdd --medium base_ubuntu.vdi --mtype multiattach`



* List all the vms: `VBoxManage list vms`
* Clone a hard drive: `VBoxManage clonehd path_to_source_vdi path_for_cloned_vm`
* Take a snaphost: `VBoxManage snapshot base_ubuntu take base_ubuntu`


---
**Reference**:
* [https://www.electricmonk.nl/log/2011/09/24/multiple-virtualbox-vms-using-one-base-image-copy-on-write/](https://www.electricmonk.nl/log/2011/09/24/multiple-virtualbox-vms-using-one-base-image-copy-on-write/)

