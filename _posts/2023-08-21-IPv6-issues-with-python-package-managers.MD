---
author: dmac
title: "IPv6 Issues with Python Package Managers"
date: 2023-08-21 00:00:00 +100
categories: [tools]
tags: [python, linux]
img_path: /assets/img/posts/
image: 
  path: "2023-08-21/img-preview.webp"
---

## TLDR

Installing a Python package was an extremely slow and painful process. I tried using Poetry at first and later switched to PIP. The problem was not related to the tooling as I initially thought. The workaround for this issue was to disable IPv6 only on the interface I was using to route traffic to the internet. I still let IPv6 be enabled on all other interfaces.

> IMPORTANT: Only attempt this if you are not using any IPv6 service on the interface. Otherwise, IPv6 connectivity will break.
{: .prompt-warning }

## Problem

For a while, I've had some issues while installing python packages on my lab server. Installing even 2 or 3 python packages would take at least 3+ minutes.

I was initially using Poetry and later switched to PIP. Although it got slightly better with PIP, the time required to install a package was still ridiculous.

After searching and trying many different things I found the solution to my problem. Note: This is just one of the possible solutions to the slowness in the installation of python packages using tools like PIP or Poetry.

Example from other [users on Github](https://github.com/python-poetry/poetry/issues/2094#issuecomment-616201046) (Unfortunately I couldn't save a screenshot of my issue and couldn't replicate it after applying the workaround):

![Python Poetry Issues](2023-08-21/poetry-slow-resolv-deps.webp)
_Figure 1 - Poetry: It took 131 Seconds to resolve dependencies (Similar to my issue)_

## Possible Root Cause

By default, most of the newer Linux OS distros come with IPV6 enabled by default. This means that in some cases when using PIP, Poetry, or some other tools, they will attempt to initiate connections via IPv6 first and then via IPv4 (After a small delay). This is due to an algorithm called Happy Eyeballs, but we will look into that in a sec.

 In some cases, the IPv6 connections will timeout, as even Link-local IPv6 addresses will be preferred over IPv4 Private (but Natted) addresses to reach addresses on the internet.

This is particularly painful when dealing with package managers as they will recursively try to download all the dependencies and sub-dependencies of a package. The problem with this approach is that the IPv6 connection will timeout at every step and that will considerably slow down the process to download the package via the IPv4 connection. I eventually was able to download the packages but it took way more time than necessary.

In my case, I was not actively using IPv6 on my `ens18` interface but my system was trying to create IPv6 connections (which would timeout) to PyPi before attempting to use IPv4.

### Happy Eyeballs

To efficiently manage both connections (IPv4 and IPv6), an algorithm called "Happy Eyeballs 2" has been defined in [RFC 8305](https://www.rfcreader.com/#rfc8305) which deprecated the original [RFC 6555](https://www.rfcreader.com/#rfc6555). The idea is that the server will initiate a connection, usually via IPv6 first, and then after a small delay (typically between 150 - 250 ms. 250 ms is recommended in the RFC), it should then attempt a 2nd connection via IPv4.

**Quotes from the RFC:**

- In order to avoid unreasonable network load, connection attempts SHOULD NOT be made simultaneously. Instead, one connection attempt to a single address is started first.
- Starting a new connection attempt does not affect previous attempts, as multiple connection attempts may occur in parallel.
- Once one of the connection attempts succeeds (generally when the TCP handshake completes), all other connection attempts that have not yet succeeded SHOULD be canceled. Any address that was not yet attempted as a connection SHOULD be ignored. At that time, the asynchronous DNS query MAY be canceled as new addresses will not be used for this connection. However, the DNS client resolver SHOULD still process DNS replies from the network for a short period of time (recommended to be 1 second), as they will populate the DNS cache and can be used for subsequent connections.

**That is the theory at least**. In practice, I couldn't find much information on how Ubuntu 22.04 implements this technique but I suspect that for every python package and every one of its dependencies, an initial connection via IPv6 was attempted and timing out to then fall back to IPv4 (Hopefully concurrently instead of serially).

For this post, I'm going to use Ubuntu 22.04 for the explanation of how to confirm if this is your problem and then to offer a workaround. Below, you can see info on my distro:

![Ubuntu 22.04](2023-08-21/ubuntu2204.webp)
_Figure 2 - Distro Info_

### How to check if IPv6 is enabled in your system

Use the command below to check if IPv6 is enabled. If the output returns:

```bash
sysctl -a 2>/dev/null | grep disable_ipv6
```

![IPv6 status Linux](2023-08-21/ipv6-status-linux.webp)
_Figure 3 - IPv6 Enabled (0) on all the interfaces_

- 0 - Means that IPv6 is **Enabled**
- 1 - Means that IPv6 is **Disabled**

### Bonus Point (Create an alias for it)

Since I'm really bad at remembering these kinds of useful commands, I had to create an alias for it.

**Note:** ZSH By default uses the `~/.aliases` file to source your custom aliases every time you open a new shell.

```bash
echo "alias ipv6-status='sysctl -a 2>/dev/null | grep disable_ipv6'" >> ~/.aliases
cat ~/.aliases
source ~/.aliases
alias | grep ipv6
```

If you use `bash` you might want to add your aliases to `~/.bashrc` or `~/.bash_aliases` instead.

## Workaround

To workaround this issue I simply disabled IPv6 **(only)** on the interface I used to reach the PyPI (Python Package Index) repos that PIP and Poetry use to fetch python packages.

> IMPORTANT: Only attempt this if you are not using any IPv6 service on the interface. Otherwise, IPv6 connectivity will break.
{: .prompt-warning }

### Temporarily Disable IPv6 (Only on the interface used to get to PyPI)

```bash
ip route # With this command you will identify what is the exit interface you use to get to the internet (Or to a Local repository if that's your case)

ipv6-status # Alias defined to get the status of all your ipv6 interfaces

sudo sysctl -w net.ipv6.conf.ens18.disable_ipv6=1 # Disable IPv6 on the ens18 interface as it is used to route traffic to the internet and fetch packages from PyPI
```

### Test if that fixed your problem by installing some python packages

```bash
poetry add rich nornir nornir_napalm
pip install rich nornir nornir_napalm
```

At this stage, I managed to reduce the installation of 3 packages **from 3+ minutes to less than 1 minute.**

If that has worked for you, congratulations!!

**Optionally:** You can permanently change how your system interacts with IPv6 addresses in 2 ways:

### Option 1: Adjust your system to use IPv4 over IPv6 (Globally Applied)

> IMPORTANT: I did not try this solution as it affects your global settings but it might be another way to solve this problem.
{: .prompt-warning }

[Source to the original article in Stackoverflow](https://askubuntu.com/questions/32298/prefer-a-ipv4-dns-lookups-before-aaaaipv6-lookups/38468#38468)

- Open the following file to set how your system deals with IPv6 connections:  `sudo vim /etc/gai.conf`

- Add the following lines to the file. It is important to note the increase of `precedence ::ffff:0:0/96` from `10 by default` ---> `100`. This will make IPv4 source IPs to be preferred over IPv6 sources addresses:

```bash
precedence ::ffff:0:0/96  100
precedence  ::1/128       50
precedence  ::/0          40
precedence  2002::/16     30
precedence ::/96          20
```

`::ffff:0:0/96` is an IPv4-mapped IPV6 address. This is a way used to represent IPv4 addresses over an IPv6 format. `::ffff:<IPv4_address>` on which the first 96 bits will be 00...FFFF and the last 32 bits will be used to represent an IPv4 address.

This way of representing an IPv4 address in an IPv6 style was defined in [RFC 4291](https://www.rfcreader.com/#rfc4291_line441)

The way this works is that your system will prefer to initially use a source IPv4 address over an IPv6 address to reach your destination.

For more information on how this works you can check [RFC 6724](https://www.rfcreader.com/#rfc6724) which obsoletes [RFC 3484](https://www.rfcreader.com/#rfc3484).

### Option 2: Permanently Disable IPv6 via Sysctl (Per interface if necessary)

1 - `vim /etc/sysctl.conf`

```bash
net.ipv6.conf.ens18.disable_ipv6=1      # Make sure you modify the name of the interface (ens18 in my case)
```

2 - Apply the changes by issuing the following command in your shell: `sysctl -p`

3 - Make sure that the intended interface has been disabled (After setting it to 1). Use any of the 2 alternatives next but don't forget to modify the name of the interface (if necessary):

```bash
ipv6-status | grep ens18
cat /proc/sys/net/ipv6/conf/ens18/disable_ipv6
```

4 - Reboot the system if possible to test 

```bash
shutdown -r 02:00 # Schedules a reboot at 2:00 AM
shutdown -c # (Optional) to cancel the scheduled shutdown
```

If you have faced this issue, I would love to hear how you solved it

## References
- [RFC 6724 - Default Address Selection for Internet Protocol Version 6 (IPv6)](https://www.rfcreader.com/#rfc6724)
- [Permanently Disable IPv6](https://linuxconfig.org/how-to-disable-ipv6-address-on-ubuntu-22-04-lts-jammy-jellyfish)
- [RFC 8305  - Happy Eyeballs Version 2: Better Connectivity Using Concurrency](https://www.rfcreader.com/#rfc8305)
- [RFC 6555 - Happy Eyeballs: Success with Dual-Stack Hosts](https://www.rfcreader.com/#rfc6555)
- [Wikipedia Happy Eyeballs](https://en.wikipedia.org/wiki/Happy_Eyeballs)
