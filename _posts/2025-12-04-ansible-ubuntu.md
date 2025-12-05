---
author: dmac
title: "Ansible roles to deploy Ubuntu servers"
date: 2025-12-04 00:00:00 +100
categories: [tools]
tags: [automation, ansible]
image: 
  path: "/assets/img/posts/2025-12-04/img-preview.webp"
---



If you've ever had to manually configure servers one by one, you know how painful it is to maintain consistency across users, groups, SSH keys, Docker, ZSH, editors, and all the other tools you rely on.

In this article, we'll use Ansible to automate the deployment of 6 Ubuntu servers with identical configurations and tooling.


## Use cases

This week I needed to build 10 Ubuntu VMs to deploy new services in my lab. 

My motivations to automate this deployment were:
- Keep a consistent environment between all my servers that will match the tools I use on my local machine.
- Save time by not having to manually configure all these VMs myself
- Have my code in version control to add more features in the future with minimal risk.
- Reduce the time it takes me to rebuild one of those VMs in the future.

Beyond my specific scenario, this approach is valuable for:

- **Homelab enthusiasts** who want to quickly rebuild or add new servers with preferred tooling already configured
- **Network engineers** testing automation tools like containerlab, infrahub, netbox, or nautobot who need fresh environments regularly
- **DevOps teams** managing development servers where everyone needs the same shell, editor, and CLI tools
- **Certification prep** (CCNA, CCNP, CKA, etc.) where you need consistent lab environments you can tear down and rebuild quickly
- **Training and workshops** where all participants need identical setups


## Project overview

All the code shown in this example lives in the [dmac-ansible](https://github.com/danielmacuare/dmac-ansible) repo, where you'll find detailed documentation and additional guidance.

This repo currently provides 5 main roles:

![Ansible-Ubuntu Roles](/assets/img/posts/2025-12-04/fig1-roles-description.webp){: w="900" h="600" }
_Figure 1 - Ansible Project Roles_

- **[ubuntu](https://github.com/danielmacuare/dmac-ansible/tree/main/roles/ubuntu)** - The base role that creates users, groups, SSH keys, and installs APT and Snap packages.
- **[zerotier](https://github.com/danielmacuare/dmac-ansible/tree/main/roles/zerotier)** - Installs ZeroTier and joins your specified network.
- **[zsh](https://github.com/danielmacuare/dmac-ansible/tree/main/roles/zsh)** - Installs ZSH with Oh-My-Zsh and the Powerlevel10k theme, plus useful plugins like fzf-tab and zsh-autosuggestions.
- **[docker](https://github.com/geerlingguy/ansible-role-docker)** - Installs Docker CE, Docker Compose, and manages Docker users. Huge thanks to [Jeff Geerling](https://www.jeffgeerling.com/) for maintaining this excellent role.
- **[neovim](https://github.com/danielmacuare/dmac-ansible/tree/main/roles/neovim)** - Installs Neovim with Lazy as the plugin manager and Mason for LSP management, along with additional plugins for a great editing experience.

> Note: Only use the neovim role if you want to deploy a custom configuration. If you just need neovim installed, add it to the `apt_packages` list in the ubuntu role instead.
{: .prompt-tip } 

## Getting started

We'll use Ansible to configure the servers once they're created and reachable via SSH.

We will divide this goal in 3 main tasks:

1. Create 6 VMs to test our playbook.
2. Clone the repository and update the inventory, vars, playbook, and other necessary files.
3. Configure all 6 servers in a single Ansible run.

### 1 - Creating the VMs

For this step, I'm using Orbstack since I'm on MacOS. Check out the [Orbstack Installation Docs](https://docs.orbstack.dev/quick-start#installation) if you need to install it.

Alternative options:
- **Windows**: Use WSL2 or VirtualBox
- **Linux**: KVM or LXC work great

Once Orbstack is installed, create the 6 VMs:

![Orbstack VMs](/assets/img/posts/2025-12-04/fig2-orb-vms.webp){: w="900" h="600" }
_Figure 2 - 6 x Ubuntu VMs_

### 2 - Cloning the repo and updating files

#### 2.1 - Clone and install dependencies
```bash
git clone https://github.com/danielmacuare/dmac-ansible.git
cd dmac-ansible
uv sync
uv run ansible-galaxy install -r requirements.yml -p ./roles
```


#### 2.2 - Customize your deployment

> For a detailed step-by-step guide on updating all necessary files before running the playbook, check out the [Configuration Guide](https://github.com/danielmacuare/dmac-ansible/blob/main/docs/configuration.md#initial-setup)
{: .prompt-tip }

You'll need to modify these files:

- **[vars.yaml](https://github.com/danielmacuare/dmac-ansible/blob/main/inventories/group_vars/all/vars.yaml)** - Stores all variables used by each role. This controls how your servers are configured.
- **[vault.yaml](https://github.com/danielmacuare/dmac-ansible/blob/main/inventories/group_vars/all/example.vault.yaml)** - Stores the password for encrypting/decrypting sensitive Ansible files containing secrets.
- **[inventory.ini](https://github.com/danielmacuare/dmac-ansible/blob/main/inventories/inventory.ini)** - Defines which targets are available in each Ansible group.
- **[ubuntu.yml](https://github.com/danielmacuare/dmac-ansible/blob/main/playbooks/ubuntu.yml)** - Controls which roles get applied to target servers. Mix and match as needed. The ubuntu role (base) is recommended; all others are optional.
- **[dmac.pub](https://github.com/danielmacuare/dmac-ansible/blob/main/roles/ubuntu/files/dmac.pub)** - Your SSH public key. The filename should match the username configured in `vars.yaml`.

#### 2.2.1 - Example configuration

Here's what my configuration looks like:

```bash
---
# UBUNTU ROLE
auth_key_dir: "{{ vault_auth_dir_key }}"

users:
  - username: dmac
    sudo_access: true
    ssh_access: true
    ssh_pub_key: "{{ lookup('file', 'dmac.pub') }}"
    ssh_pass: "{{ vault_dmac_ssh_pass }}"
    custom_alias_file: "aliases_dmac.j2"
    custom_functions_file: "functions_dmac.j2"
  - username: svmt
    sudo_access: true
    ssh_access: true
    ssh_pub_key: "{{ lookup('file', 'svmt.pub') }}"
    ssh_pass: "{{ vault_svmt_ssh_pass }}"
    custom_alias_file: "aliases_svmt.j2"
    custom_functions_file: "functions_svmt.j2"

apt_packages:
  - whois
  - sshpass
  - nmap
  - bat
  - ripgrep
  - zoxide
  - jq
  - fzf
  - tldr
  - duf
  - btop
  - tree
  - tcpdump
  - openssh-server # ORB VMs won't install it by default

snap_packages:
  - name: rustscan # NMAP Faster Alternative
    classic: false
    version: "latest/stable"
  - name: termshark # Wireshark-like TUI
    classic: false
    version: "latest/stable"


# ZEROTIER ROLE
zerotier_api_accesstoken: "{{ vault_zerotier_api_accesstoken }}"
zerotier_api_url: "https://api.zerotier.com/api/v1"
zerotier_network_id: "83048a0632608eee"

# ZSH ROLE
zsh_users:
  - username: dmac
    oh_my_zsh:
      theme: "powerlevel10k/powerlevel10k"
      plugins:
        - git
      update_mode: auto
      update_frequency: 5
      write_zshrc: true

zsh_p10k_users:
  - dmac

zsh_plugins:
  - "zsh-autosuggestions"
  - "zsh-fast-syntax-highlighting"
  - "fzf-tab"
  - "zsh-completions"

zsh_plugins_path: "{{ item.username }}/.oh-my-zsh/custom/plugins"

# DOCKER ROLE
docker_edition: 'ce'
docker_packages:
  - "docker-{{ docker_edition }}"
  - "docker-{{ docker_edition }}-cli"
  - "docker-{{ docker_edition }}-rootless-extras"
  - "containerd.io"
  - docker-buildx-plugin
docker_packages_state: present
docker_obsolete_packages:
  - docker
  - docker.io
  - docker-engine
  - docker-doc
  - docker-compose
  - docker-compose-v2
  - podman-docker
  - containerd
  - runc

# Docker Compose Plugin options.
docker_install_compose_plugin: true
docker_compose_package: docker-compose-plugin
docker_compose_package_state: present

# Docker Compose options.
docker_install_compose: false # Prevents legacy binary
docker_compose_version: "v2.40.3" # Latest as of 11/2025
docker_compose_path: /usr/local/bin/docker-compose

# A list of users who will be added to the docker group.
docker_users:
  - dmac
  - svmt


# NEOVIM ROLE
neovim_set_default_editor: true
neovim_deploy_config: true
neovim_users:
  - username: dmac

```
{: file="group_vars/all/vars.yaml" }

```bash
[all:vars]
ansible_user=dmac
ansible_python_interpreter=/usr/bin/python3

[ubuntu_hosts]
ub01-2204 ansible_host=ub01-2204@orb ansible_user=ub01-2204 zerotier_hosted_on=orb-ub01-2204
ub02-2204 ansible_host=ub02-2204@orb ansible_user=ub02-2204 zerotier_hosted_on=orb-ub02-2204
ub03-2404 ansible_host=ub03-2404@orb ansible_user=ub03-2404 zerotier_hosted_on=orb-ub03-2404
ub04-2404 ansible_host=ub04-2404@orb ansible_user=ub04-2404 zerotier_hosted_on=orb-ub04-2404
ub05-2504 ansible_host=ub05-2504@orb ansible_user=ub05-2504 zerotier_hosted_on=orb-ub05-2504
ub06-2504 ansible_host=ub06-2504@orb ansible_user=ub06-2504 zerotier_hosted_on=orb-ub06-2504

[proxmox]
max ansible_host=max-01
```
{: file="inventories/inventory.ini" }

```bash
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILLLdt13LmYyZmOn4bwbgVctSuejlc7iPAE46s9KlePs

```
{: file="roles/ubuntu/files/dmac.pub" }

```bash
# Example File - FAKE CREDS
vault_auth_dir_key: "/etc/ssh/authorized_keys"
vault_zerotier_api_accesstoken: "Put your Zero Tier API Token HERE"
# See docs/password-generation.md for instructions on how to generate the password hashes below
vault_dmac_ssh_pass: "$6$Vqo2MXAAQt6z0KxG$2/XYsLfVbnLRhMveU9YV2lwzxnTRD8gk3jnjKWc894lApaFlJHhAo/m.FV/pqbD3EXV26Iia9otiiKBKTmXDCS"
vault_svmt_ssh_pass: "$6$U4CbBz7gOuK11hjd$YOtOM6s5ftzqRDr408qsXDnyRBJ4a/lQLFufb1LJM1Q7R9ATcG/CvkybfJhRpaSDb5Z1GdEwsJIvZhyCnnADEX"
```
{: file="group_vars/all/vault.yaml" }

**- Playbook**
```bash
---
- name: Configure Ubuntu Development Servers
  hosts: ubuntu_hosts
  gather_facts: true
  roles:
    - { role: ubuntu, tags: ["ubuntu"] }
    - { role: zsh, tags: ["zsh"] }
    - { role: geerlingguy.docker, tags: ["docker"], become: true }
    - { role: zerotier, tags: ["zerotier"] }
    - { role: neovim, tags: ["neovim"] }
```
{: file="playbooks/ubuntu.yaml" }


### 3 - Running the Playbook

Once you've updated all the variables and files, it's time to execute the playbook:

```bash
# Run all roles
uv run ansible-playbook playbooks/ubuntu.yml -K 

# Or run specific roles only
uv run ansible-playbook playbooks/ubuntu.yml -K --tags ubuntu
uv run ansible-playbook playbooks/ubuntu.yml -K --tags zerotier
uv run ansible-playbook playbooks/ubuntu.yml -K --tags zsh
uv run ansible-playbook playbooks/ubuntu.yml -K --tags docker
```

> I had to run the playbook twice since it froze halfway through on the first attempt. This was likely due to my machine (hosting Orbstack and all 6 VMs) only having 16GB of RAM.
{: .prompt-warning } 

#### 3.1 - Results

After running the playbook, all 6 servers were successfully configured. Here's what the deployment looks like:

![Ansible Playbook Execution](/assets/img/posts/2025-12-04/fig3-results.webp){: w="900" h="600" }
_Figure 3 - Ansible playbook completed successfully on the second attempt_

![Neovim](/assets/img/posts/2025-12-04/fig4-neovim.webp){: w="900" h="600" }
_Figure 4 - Neovim installed and configured with all plugins_

![ZSH](/assets/img/posts/2025-12-04/fig5-zsh.webp){: w="900" h="600" }
_Figure 5 - ZSH installed with useful plugins like fzf-tab_

![Zerotier](/assets/img/posts/2025-12-04/fig6-zerotier.webp){: w="900" h="600" }
_Figure 6 - ZeroTier installed and connected_

![Docker Verification](/assets/img/posts/2025-12-04/fig7-docker.webp){: w="900" h="600" }
_Figure 7 - Docker and Docker Compose installed_


## Closing thoughts

The modularity of these roles allows us to create different playbooks to target different sets of servers. For example:

1 - Ubuntu base playbook
  - Ubuntu role: To only apply the base ubuntu config (Users, groups, SSH Keys, etc)

2 - Ubuntu + Docker Playbook

3 - Ubuntu + Docker + Tools + Remote Access
  - Ubuntu role
  - Docker role
  - Tools
    - ZSH
    - Neovim
  - Zerotier role


After completing this automation we can now:
- Replace VMs effortlessly: If one VM dies or gets too annoying we can quickly create a new one and configure it with the playbook.
- Get a consistent set of tools and the same experience across all our servers.
- Save time when creating new servers.

If you're managing more than a couple of servers or frequently spinning up new VMs for testing, I highly recommend giving this approach a try. The initial setup takes some time, but once you have your vars and inventory configured, deploying new servers becomes almost effortless.

Feel free to fork the [dmac-ansible repo](https://github.com/danielmacuare/dmac-ansible) and adapt it to your needs. I'd love to hear if there are any improvements you'd suggest!
