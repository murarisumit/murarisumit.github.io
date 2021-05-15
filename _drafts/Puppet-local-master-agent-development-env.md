---
title: Puppet local development environment
date: 2017-10-10 05:30:00 +05:30
tags:
- puppet
layout: post
---

* We'll be using the following to make infrastructure
    * Virtualbox NAT networking.
    * Jumpbox with host only networking and connected to nat network.
    * Ubuntu nodes that we will be spinning up. 

* Virtualbo NAT networking: 
    * Create a NAT network in virtualbox. See [networking in virtualbox]({{ site.baseurl }}/basic-virtualbox-networking-concepts.html)
    * Nat network is networking mode in virtualbox, where all the nodes in nat-networking mode can communicate with each other and with internet.
    * Host machine can't directly connect with VM's in nat networked mode unlike host-only-networking mode.
    * ![Create NAT Network](static/img/puppet-local-dev-env/create-nat-network-2017-10-10-10.19.32.png){:height="400px" width="400px"}

* **Creating a jumpbox**
    * Creating the base box
        * We'll create a base image to launch our vms.
        * We'll manually install packages we need in our base box like git. 
        * Clone a hard drive: `VBoxManage clonehd path_to_source_vdi path_for_cloned_vm`
        * It might be something like: `VBoxManage clonehd ~/VirtualBox\ VMs/base_ubuntu/base_ubuntu.vdi ~/base_ubuntu.vdi`

    * Create a new machine using that vdi
        * `VBoxManage createvm --name "jumpbox" --ostype Debian_64 --register`
        * `VBoxManage modifyvm "jumpbox" --nic1 hostonly --hostonlyadapter1 "vboxnet0"`
        * `VBoxManage storagectl "jumpbox" --name "sata1" --add sata`
        * `VBoxManage storageattach "jumpbox" --storagectl "sata1" --port 0 --device 0 --type hdd --medium ~/base_ubuntu.vdi --mtype multiattach`
        * Above steps will not clone the entire vdi, but will do copy-on-write<sup>[Reference](https://www.electricmonk.nl/log/2011/09/24/multiple-virtualbox-vms-using-one-base-image-copy-on-write/){:target="_blank"}</sup>
        * `VBoxManage startvm "clone1"`
        * After this step we'll be able to see a multi-attach disk at virtualbox
        * ![multi-attach-disk](static/img/puppet-local-dev-env/multi-attach-disk.png){:height="400px" width="400px"}
        * Using this disk, create the machine and get the basic packages and users on the newly created systems.
    * Attach one more host-only adapter node to the jumpbox.
        * 

* **Create the nat-networked node**
    * Create the vm:
        * `VBoxManage createvm --name "kubemaster" --ostype Ubuntu_64 --register`
    * Add the network adapter to the vm
        * `VBoxManage modifyvm "kubemaster" --nic1 natnetwork --nat-network1 "nat_network_name"`
    * Adding the base hdd to the new virtual machine. 
        * `VBoxManage storagectl "kubemaster" --name "sata1" --add sata`
        * `VBoxManage storageattach "kubemaster" --storagectl "sata1" --port 0 --device 0 --type hdd --medium "path_to_base_hdd" --mtype multiattach`
        * Usually be like: `VBoxManage storageattach "kubemaster" --storagectl "sata1" --port 0 --device 0 --type hdd --medium "/Users/hme/VirtualBox VMs/base_hdd.vdi" --mtype multiattach`

* **Create the dns node in out nat-network**
    * Create the vm:
        * `VBoxManage createvm --name "dns-server" --ostype Ubuntu_64 --register`
    * Add the network adapter to the vm
        * Attach the networking-device : `VBoxManage modifyvm "dns-server" --nic1 natnetwork --nat-network1 "nat_network_name"`
    * Adding the base hdd to the new virtual machine. 
        * `VBoxManage storagectl "dns-server" --name "sata1" --add sata`
        * Attach hard-drive to new node: `VBoxManage storageattach "dns-server" --storagectl "sata1" --port 0 --device 0 --type hdd --medium "path_to_base_hdd" --mtype multiattach`
        * Usually be like: `VBoxManage storageattach "dns-server" --storagectl "sata1" --port 0 --device 0 --type hdd --medium "/Users/hme/VirtualBox VMs/base_hdd.vdi" --mtype multiattach`
        * Start the vm: `VBoxManage startvm "clone1"`


* List all the vms: `VBoxManage list vms`
* Clone a hard drive: `VBoxManage clonehd path_to_source_vdi path_for_cloned_vm`
* Take a snaphost: `VBoxManage snapshot base_ubuntu take base_ubuntu`


---
**Reference**:
* [https://www.electricmonk.nl/log/2011/09/24/multiple-virtualbox-vms-using-one-base-image-copy-on-write/](https://www.electricmonk.nl/log/2011/09/24/multiple-virtualbox-vms-using-one-base-image-copy-on-write/)

