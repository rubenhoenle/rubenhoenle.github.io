---
layout: post
title: "NixOS Homeserver"
author: "Ruben Hönle"
categories: journal
tags: [documentation,sample]
image: nix-server.jpeg
---

I got myself new hardware for Christmas. It's a ThinkCentre M710q, which is 
running NixOS. After having used NixOS as the primary operating system on my 
desktop for quite some time, I also wanted to make the switch from Debian to 
NixOS on my server. Now, I'm finally able to reproduce my whole home server 
configuration using a single GitHub repository.

I always feared that I might build a great home server setup but encounter 
problems when, for example, switching to new hardware because I forgot to 
document how everything is set up. All these struggles are now gone thanks 
to the reproducibility of NixOS. Furthermore, you don't need any documentation 
on how your setup works; your NixOS dotfiles repository, combined with some 
markdown files, should be documentation enough.

