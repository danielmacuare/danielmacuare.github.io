---
author: dmac
title: Syntax Highlighting for Cisco/Arista/Juniper CLI
date: 2020-04-02 10:00:00 +0100
categories: [networking]
tags: [linux]
img_path: /assets/img/posts/
image: 
  path: "2020-04-02/img-preview.webp"
---

[netcli-highlight] Repo(https://github.com/danielmacuare/netcli-highlight)

## Syntax Highlighting for Cisco/Arista/Juniper CLI

If you have ever used the CLI on network devices, you probably have ended up frustrated trying to make sense of the long lines of configuration. Although nowadays the use of editors like vim/Sublime/Vscode/Atom can provide some really useful syntax highlighting, you still can find yourself struggling to read the config files or outputs while you are on live devices.

In this post, I would like to share a config that has helped me to work more efficiently in the CLI by providing some very useful syntax highlighting.

## Examples

Next, you can see examples of the syntax highlighting:

### Reading JunOS Firewall Rules

![JunOS Security Policies](2020-04-02/fig1-junos-sec-policies.webp)
_Figure 1 - JunOS Firewall Rules_

### Reading Show ip bgp summary (Arista/Cisco)

![EOS Show ip bgp summary](2020-04-02/fig2-eos-show-ip-bgp-summary.webp)
_Figure 2 - (EOS/IOS) show ip bgp summary_

### Show interfaces (Arista/Cisco/Juniper)

![show interfaces](2020-04-02/fig3-ios-show-interfaces.webp)
_Figure 3 - (EOS/IOS) show interfaces_

### Reading route-maps (EOS/IOS)

![show route-maps](2020-04-02/fig4-ios-show-route-maps.webp)
_Figure 4 - (EOS/IOS) show route-maps_

### Reading Prefix Lists

![show prefix list](2020-04-02/fig5-ios-prefix-lists.webp)
_Figure 5 - (EOS/IOS) Prefix Lists_

## How can I try this?

This setup uses a tool called [chromaterm](https://github.com/hSaria/ChromaTerm) that basically matches some Regular Expressions and allows you to apply a style (Foreground/Background color) to the matched expression. It is super easy to use and read.

If you are interested in getting this config and information on how to use it, visit the following repository:

> Repo: [danielmacuare/netcli-highlight](https://github.com/danielmacuare/netcli-highlight)
{: .prompt-warning }

Hope you find it as useful as I do.

Have a great day and stay safe during this COVID-19 madness.
