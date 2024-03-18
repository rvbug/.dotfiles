# <p align="center"> <bold>•</bold> dotfiles <p> 


![macOS](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=macos&logoColor=F0F0F0)
![Fedora](https://img.shields.io/badge/Fedora-294172?style=for-the-badge&logo=fedora&logoColor=white)
![Arch](https://img.shields.io/badge/Arch%20Linux-1793D1?logo=arch-linux&logoColor=fff&style=for-the-badge)
![Pop!\_OS](https://img.shields.io/badge/Pop!_OS-48B9C7?style=for-the-badge&logo=Pop!_OS&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)

# Introduction

This repository helps to restore or configure a new machine with one single shell script

# Script Files 

List of files under this repository

| File | Type |  Description |
| --- | --- | --- |
| `install.sh` | Shell Script  | starter script  |
| `macos.sh` | Shell Script | Script to run on mac os| 
| `linux.sh` | Shell Script | To run on Linux machine (Fedora) | 

# Configuration files
| File | Type |  Description |
| --- | --- | --- |
| `software.yaml`  | YAML file | List of softwares to be installed | 
| `config/.tmux.conf`|  Tmux  | tmux configuration file| 
| `config/.wezterm.lua`| Terminal | wezterm lua config file | 
| `config/.zshrc`| profile | shell profile| 
| `config/starship.toml`| Shell Prompt | shell prompt | 


# Versions Tested on
| OS | Version |  Details |
| --- | --- | --- |
| | | | 
| | | | 
| | | | 
| | | | 
| | | | 



# Setup Process
The main script `install.sh` will guide through the setup processes. The workflow is as follows

- 



# Docker
I wanted to test this on another machine apart so better option was to install docker and try on various "throw away" machine.
Next step is to automate this as part of my shellscript.

The list of things I did was 

- Install docker desktop on mac (.dmg file)
- Pull docker ubuntu image and view them
```bash
  $> docker pull ubuntu
  $> docker images
```
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

