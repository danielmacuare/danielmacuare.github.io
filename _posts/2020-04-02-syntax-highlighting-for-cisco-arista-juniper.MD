---
author: dmac
title: Syntax Highlighting for Cisco/Arista/Juniper CLI
date: 2020-04-02 10:00:00 +0100
categories: [networking]
tags: []
---

## Syntax Highlighting for Cisco/Arista/Juniper CLI

If you have ever used the CLI on network devices, you probably have ended up frustrated trying to make sense of the long lines of configuration. Although nowadays the use of editors like vim/Sublime/Vscode/Atom can provide some really useful syntax highlighting, you still can find yourself struggling to read the config files or outputs while you are on live devices.

In this post, I would like to share a config that has helped me to work more efficiently in the CLI by providing some very useful syntax highlighting.

## Examples

Next, you can see examples of the syntax highlighting:

### Reading JunOS Firewall Rules

![JunOS Security Policies](../../assets/img/posts/2020-04-02/fig1-junos-sec-policies.png){: w="900" h="600" }
_Figure 1 - JunOS Firewall Rules_

### Reading Show ip bgp summary (Arista/Cisco)

![EOS Show ip bgp summary](../../assets/img/posts/2020-04-02/fig2-eos-show-ip-bgp-summary.png){: w="900" h="600" }
_Figure 2 - (EOS/IOS) show ip bgp summary_

### Show interfaces (Arista/Cisco/Juniper)

![show interfaces](../../assets/img/posts/2020-04-02/fig3-ios-show-interfaces.png){: w="900" h="600" }
_Figure 3 - (EOS/IOS) show interfaces_

### Reading route-maps (EOS/IOS)

![show route-maps](../../assets/img/posts/2020-04-02/fig4-ios-show-route-maps.png){: w="900" h="600" }
_Figure 4 - (EOS/IOS) show route-maps_

### Reading Prefix Lists

![show prefix list](../../assets/img/posts/2020-04-02/fig5-ios-prefix-lists.png){: w="900" h="600" }
_Figure 5 - (EOS/IOS) Prefix Lists_

## How can I try this?

This setup uses a tool called [chromaterm](https://github.com/hSaria/ChromaTerm) that basically matches some Regular Expressions and allows you to apply a style (Foreground/Background color) to the matched expression. It is super easy to use and read.

If you are interested in getting this config and information on how to use it, visit the following repository:

> Repo: [danielmacuare/netcli-highlight](https://github.com/danielmacuare/netcli-highlight)
{: .prompt-warning }

Hope you find it as useful as I do.

Have a great day and stay safe during this COVID-19 madness.