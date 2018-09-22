---
id: 1
title: Kubernetes single node setup.
date: '2016-04-24 12:00:00'
layout: post
tags:
- kubernetes
- container
category:
- tech
---

This post is intend for setup for single master node kubernetes setup. It is written keeping _ubuntu_ as base OS in mind.

Single master setup is single point for while kubernetes setup, but we have it for dev environment to test our things or just trying about kuberntes.


* Setup instance.
    * If you are using digitalocean : `doctl compute droplet create sumit-master-1 --size 512mb --image ubuntu-16-04-x64 --region blr1 --ssh-keys 22432270 --tag-name sumit`
* Setup docker.
* Setup up kubeadm, kubectl, kubelet.

* Get all control pane components by: `kubeadm init --pod-network-cidr=192.168.0.0/16`
* Using the control pane components:  `export KUBECONFIG=/etc/kubernetes/admin.conf`
* View all components running : `kubectl get pods --all-namespaces`
* All component other than `kube-dns` should be working for that we need to setup pod-networking 
* Setup pod-networking : Using calico here
    * ```kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/rbac-kdd.yaml```
    * ```kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/kubernetes-datastore/calico-networking/1.7/calico.yaml```


<br/>
---
References: [Tutorials Point](http://www.tutorialspoint.com/eisomewk/): http://www.tutorialspoint.com/some/
