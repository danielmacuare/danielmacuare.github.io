---
author: dmac
title: "ctop: Managing docker containers via the CLI"
date: 2023-09-06 00:00:00 +100
categories: [tooling]
tags: [docker]
img_path: /assets/img/posts/
image: 
  path: "2023-09-11/img-preview.webp"
---

If you love to work with containers, keep reading, this article will be useful for you.

One of the features I like the most about containers is how easy they are to deploy. They are designed to run in many OSs with minimal effort.

However, they are yet another level of abstraction and to troubleshoot some of the most common issues you need to approach the situation from the container's perspective.

A few weeks back I was troubleshooting an issue where my AWX instance was not reaching one of the network devices. To troubleshoot this issue I decided to get into the AWX server and started checking connectivity, I started pinging the device and then I SSH into it without any problem.

Then I remembered, AWX was deployed as a container. This meant that those successful tests wouldn't necessarily mean my container could reach the network devices. Thus, my next test was to log in to my AWX container and check it out from the container's perspective. It was then that I found that my container was unable to resolve the address of the network device. By Simply adding a new entry in my SSH config file I managed to fix this issue.

Another problem I had was that my gitlab server was returning a 500 error code when trying to log in to it. To fix this issue I had to go through the container logs, tweak some env vars, and then restart the container.

All of these are very common situations that require you to manage the containers. Most of the time I find myself repeating the same tasks: getting logs, restarting the containers, getting into a shell inside the container, etc.

This got me thinking if there was a better way to manage these common tasks via the CLI. After browsing through some of the [Docker Container tools](https://collabnix.github.io/dockertools/) I found this brilliant tool called `ctop`.

## ctop

![ctop](2023-09-11/ctop-containers.webp)
_Figure 1 - Containers View using cTOP_

You can run ctop on your shell to perform all these simple tasks over your containers (Only Docker and runC container runtimes are supported at the moment):

With this tool, you can quickly perform the following tasks from one single place:

- Get container logs.
- Get into the container's shell (If the container exposes one). Headless or non-interactive containers don't expose any shell. This is particularly beneficial to reduce your surface attack and is usually a good practice to provide your container only with the tools you need for the application to run.
- Check how much CPU, memory, and storage they are consuming.
- Start, stop, and restart the containers.

## ctop in Action

![cTOP](2023-09-11/ctop-demo.gif)
_Figure 2 - cTOP - Getting Container Info, CPU, Memory, Env Vars and Logs_

## How to install ctop

- macOS: `brew install ctop` OR `sudo port install ctop`

- Windows: `scoop install ctop`

- Ubuntu:

```bash
sudo apt-get install ca-certificates curl gnupg lsb-release
curl -fsSL https://azlux.fr/repo.gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/azlux-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/azlux-archive-keyring.gpg] http://packages.azlux.fr/debian \
  $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/azlux.list >/dev/null
sudo apt-get update
sudo apt-get install docker-ctop
```

- Docker:

``` bash
docker run --rm -ti \
  --name=ctop \
  --volume /var/run/docker.sock:/var/run/docker.sock:ro \
  quay.io/vektorlab/ctop:latest
```

## ctop Options

Option | Description
--- | ---
`-a`	| show active containers only
`-f <string>` | set an initial filter string
`-h`	| display help dialog
`-i`  | invert default colors
`-r`	| reverse container sort order
`-s`  | select initial container sort field
`-v`	| output version information and exit

## ctop Keybindings

|           Key            | Action                                                     |
| :----------------------: | ---------------------------------------------------------- |
| <kbd>&lt;ENTER&gt;</kbd> | Open container menu                                        |
|       <kbd>a</kbd>       | Toggle display of all (running and non-running) containers |
|       <kbd>f</kbd>       | Filter displayed containers (`esc` to clear when open)     |
|       <kbd>H</kbd>       | Toggle ctop header                                         |
|       <kbd>h</kbd>       | Open help dialog                                           |
|       <kbd>s</kbd>       | Select container sort field                                |
|       <kbd>r</kbd>       | Reverse container sort order                               |
|       <kbd>o</kbd>       | Open single view                                           |
|       <kbd>l</kbd>       | View container logs (`t` to toggle timestamp when open)    |
|       <kbd>e</kbd>       | Exec Shell                                                 |
|       <kbd>c</kbd>       | Configure columns                                          |
|       <kbd>S</kbd>       | Save current configuration to file                         |
|       <kbd>q</kbd>       | Quit ctop                                                  |

## Benefits

I've been using this tool for a few weeks now and I'm enjoying the experience so far. The main advantage for me is that on one tab I can quickly get information and logs related to all the containers deployed on my VMs.

The keybindings are pretty convenient and allow you to quickly go through all your container's info without even having to reach out your mouse.

Note: While writing this post I found a similar alternative called [lazydocker](https://github.com/jesseduffield/lazydocker) which seems useful as well.

## Other Resources

- [ctop Github](https://github.com/bcicen/ctop)
- [Docker Awesome List](https://github.com/veggiemonk/awesome-docker/blob/master/README.md#terminal)
- [Docker Container Tools](https://collabnix.github.io/dockertools/)
