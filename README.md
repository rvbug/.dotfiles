# <p align="center"> <bold>•</bold> dotfiles <p> 


![macOS](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=macos&logoColor=F0F0F0)
![Fedora](https://img.shields.io/badge/Fedora-294172?style=for-the-badge&logo=fedora&logoColor=white)
![Arch](https://img.shields.io/badge/Arch%20Linux-1793D1?logo=arch-linux&logoColor=fff&style=for-the-badge)
![Pop!\_OS](https://img.shields.io/badge/Pop!_OS-48B9C7?style=for-the-badge&logo=Pop!_OS&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)

# Introduction

This repository helps to restore or configure a new machine with one single shell script

# Script Files 

| File | Type |  Description |
| --- | --- | --- |
| `install.sh` | shell Script  | starter script  |
| `macos.sh` | shell Script | Script to run on mac os| 
| `linux.sh` | shell Script | To run on Linux machine (Fedora) | 
| `ds_tools.sh` | shell script | To setup data science & ML tools |

# Configuration files
| File | Type |  Description |
| --- | --- | --- |
| `software.yaml`  | yaml file | List of softwares to be installed | 
| `config/.tmux.conf`|  tmux  | tmux configuration file| 
| `config/.wezterm.lua`| terminal | wezterm lua terminal config file | 
| `config/.zshrc`| profile | shell profile| 
| `config/starship.toml`| shell Prompt | shell prompt | 


# Versions Tested on
| OS | Version |  package manager |
| --- | --- | --- |
| mac | Ventura | homebrew | 
| mac  | Sonoma | homebrew | 
| linux | Fedora | dnf | 

**`Note`**: The script works on Ubuntu/Arch/Debian machines but the apt package manager keeps pointing to neovim 0.7x version. Current version of neovim as of today is 0.9x 


# Docker Images
If you want to install the script on a `throw away` machine then try on docker images. Here are the steps to be followed. Below example is on fedora, but the steps pretty much remain the same on any version

- Install docker on your host machine. 
- Pull the image from docker hub (requires sign-in)
  
```bash
$> docker pull fedora

# for arch linux
$> docker pull archlinux/archlinux


# to check if the image is downloaded on your system
$> docker images
```
- Setup the container using the following commands
```bash
  $> docker run --name test -d -i -t fedora /bin/bash

  # check the processes
  $> docker ps

```
- finally execute the following command to login to the container. Replace "container id" shown from the `docker ps` command above
  
```bash
  $> docker exec -it container-id /bin/bash
```

- You will dropped into this container as root. This script will work fine as a root user but on a real machine/virtual enviornment, never run any script as root.



# Docker
I wanted to test this on another machine apart so better option was to install docker and try on various "throw away" machine.
Next step is to automate this as part of my shellscript.

The list of things I did was 

- Install docker desktop on mac (.dmg file)
- Pull docker ubuntu image and view them

- Set the container and connect 
```bash
  # setup the container
  $> docker run --name test -d -i -t ubuntu /bin/sh
  # you can see the container active using
  $> docker ps
  # get into the container
  $> docker exec -it container-id /bin/sh

```
- Once inside the image then do the following (to be automated)
```bash
  # update the image
  $> apt update

  # install git to clone the repo
  # will have to make this repo public
  $> apt install git -y

  # create a folder for cloning the repo
  $> mkdir project; cd project

  # cloning the repo
  $> git clone https://github.com/rvbug/.dotfiles.git

  $> cd .dotfiles
  $> /bin/sh install.sh
 
```

# Installations

The main script `install.sh` will guide through the setup processes. If the OS version is "Darwin" it calls for `macos.sh`. If it is "Linux" then runs `linux.sh`.   
Once the machine is detected, check if following prerequisites are installed    

|  packages |  description |
| --- |  --- |
| brew| macos package manager|
| yq    | yaml processor (supports xml and json too) |
| dnf   | if Fedora then choose dnf package manager  |


Here are the list of softwares to be installed 
|  packages |  description |
| --- |  --- |
| wezterm | Terminal written in rust on Mac os| 
| neovim | An IDE supports mac and fedora   | 
| starship| customizable command prompt on Mac os | 
| curl | | 
| wget | | 
| tmux | | 
| fd | | 
| ripgrep | | 
| npm | |
| yarn | | 
| python3 | | 
| lua5.4 | | 
| rust-analyzer | | 
| lazygit | | 
| ocaml | |
| tree | | 
| tree-sitter | | 

List of packages installed for Data Science and ML

|  packages |  description |
| --- |  --- |
| numpy | | 
| pandas | | 
| scikit-learn| | 
| matplotlib | | 
| seaborn| | 
| tensorflow| | 
| notebook | | 
| jupyterlab | | 


(TODO) - 

# Mac OS
- If `macos.sh` is called then
   - check for homebrew installation, installs if it isn't available
   - check for `yq` 


# Future Support
- Option to choose Ocaml Installation
- Neovim 9.0 on Ubuntu OS, Arch distro
- Option to skip neovim if the version is < 0.9x
- Check for git is installed using `git -v > /dev/null' on mac

