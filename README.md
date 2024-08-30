# <p align="center"> <bold>•</bold>dotfiles </p> 

<p align="center"> <img height=18 src="https://img.shields.io/badge/License-GPLv3-blue.svg"> <img height=25  src="https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white"> </p>

<p align="center">
  <img src="https://img.shields.io/badge/mac%20os-000000?style=for-plastic&logo=macos&logoColor=F0F0F0">
  <img height=20px src="https://img.shields.io/badge/Arch%20Linux-1793D1?logo=arch-linux&logoColor=fff&style=for-the-badge">
   <img src="https://img.shields.io/badge/Fedora-294172?style=for-plastic&logo=fedora&logoColor=white">
  <img height=20px src="https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white">
   <img src="https://img.shields.io/badge/docker-%230db7ed.svg?style=for-plastic&logo=docker&logoColor=white">
   <img src="https://img.shields.io/badge/numpy-%23013243.svg?style=for-plastic&logo=numpy&logoColor=white">
   <img src="https://img.shields.io/badge/pandas-%23150458.svg?style=for-plastic&logo=pandas&logoColor=white">
   <img src="https://img.shields.io/badge/scikit--learn-%23F7931E.svg?style=for-plastic&logo=scikit-learn&logoColor=white">
   <img src="https://img.shields.io/badge/Matplotlib-%23ffffff.svg?style=for-plastic&logo=Matplotlib&logoColor=black">
   <img src="https://img.shields.io/badge/TensorFlow-%23FF6F00.svg?style=for-plastic&logo=TensorFlow&logoColor=white">
   <img src="https://img.shields.io/badge/jupyter-%23FA0F00.svg?style=for-plastic&logo=jupyter&logoColor=white">
   <img src="https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-plastic&logo=neovim&logoColor=white">
    <img src="https://img.shields.io/badge/python-3670A0?style=for-plastic&logo=python&logoColor=ffdd54">
    <img src="https://img.shields.io/badge/lua-%232C2D72.svg?style=for-plastic&logo=lua&logoColor=white">
    <img src="https://img.shields.io/badge/rust-%23000000.svg?style=for-plastic&logo=rust&logoColor=white">
    <img src="https://img.shields.io/badge/OCaml-%23E98407.svg?style=for-plastic&logo=ocaml&logoColor=white">
  <!--  <img src=""> -->

</p>

 ---

# Introduction

Dotfiles helps you to personalize your machine and your enviornment across your machine to have a unified experience.
This repository helps to restore/configure new machine via script based on the OS you run. 

All the configuration will be managed using [GNU Stow](https://www.gnu.org/software/stow/).

Supported OS:   

- Mac
- Ubuntu 
- Linux Fedora
- Linux Fedora on docker
- Arch Linux 

# Script Files 

| File | Type |  Description |
| --- | --- | --- |
| `install.sh` | shell Script  | starter script  |
| `macos.sh` | shell Script | Script to run on mac os| 
| `linux.sh` | shell Script | To run on Linux machine (Fedora) | 
| `ds_tools.sh` | shell script | To setup data science & ML tools |
| `projects.sh` | shell script | Initalizes your projects |
| `software_list.txt`  | text file | List of softwares to be installed | 
| `pip_list.txt`  | text file | List of softwares for data science and ML | 
| `config_list.txt`  | text file | List of config files | 

<br>

> # **Script**  
If you do not want to use scripts, just use your package manager to install them manually.



# Configuration files
| File | Type |  OS Supported | Description |
| --- | --- | --- | -- |
| `config/.tmux.conf`|  tmux  | Mac , Arch  | tmux configuration file| 
| `config/.wezterm.lua`| terminal | Mac , Arch | wezterm lua terminal config file | 
| `config/.zshrc`| profile | Mac , Arch | shell profile and aliases | 
| `config/starship.toml`| shell Prompt | Mac , Arch | shell prompt | 
| `config/yabai/yabairc` | Tiling Window Manger | Mac | Window Manager | 
| `config/skhd/skhdrc` | Tiling Window Manger | Mac | Window Manager | 
| `config/i3/config` | i3 window manager | Arch | Tiling window manager |
| `config/polybar/config.ini` | status bar | Arch | Polybar status | 


# Package Manager
| OS | Version |  package manager |
| --- | --- | --- |
| mac | Ventura | homebrew | 
| mac  | Sonoma | homebrew | 
| linux | Fedora  | dnf | 
| linux | Fedora on docker | dnf | 
| Linux | Arch on VM | pacman , yay |
| Linux | Ubuntu | apt |

<br>


> # **Ubuntu Neovim**   
The script works well on Ubuntu/Debian OS but the apt package manager keeps pointing to neovim 0.7x version. 
You will have to build it from source manually which is a separate step under `Ubuntu Neovim (Manual)` installation section below. 


# Docker
If you want to install the script on a `throw away` machine then try on docker images. Here are the steps to be followed. Below example is on fedora, but the steps pretty much remain the same on any version

- Install docker on your host machine. 
- Pull the image from docker hub (requires sign-in)
  
```bash
$> docker pull fedora

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


# Installations

The main script `install.sh` will guide through the setup processes. 

If the OS version is "Darwin" it calls for `macos.sh`. If it is "Linux" then runs `linux.sh`.   
You will be promoted if this script require sudo access to run the installation.   

`Note:` Avoid running this (or any script) as root. This script prompts you if you are a root user. 

Following are the prerequisite before starting the script

|  packages |  description |
| --- |  --- |
| brew| macos package manager, usually installs xcode-command line tools and also git|
| dnf   | if Fedora then it uses dnf package manager  |
| git  | install seperately if it is not installed using your package manager | 



Here are the list of softwares which will be installed

|  packages |  description |
| --- |  --- |
| wezterm | Terminal written in rust on Mac os| 
| neovim | An IDE supports mac and fedora   | 
| starship| customizable command prompt on Mac os | 
| curl | Client URL to enables data exchange between client and a server | 
| wget | same as curl | 
| tmux | Terminal Multiplexer | 
| fd | simple and fast alternative to find command| 
| ripgrep | real time grep | 
| npm | package manager|
| yarn | package manager| 
| python3 | Python | 
| lua5.4 | Lua | 
| rust-analyzer | For Rust| 
| lazygit | neat UI for git | 
| ocaml | For OCaml|
| tree | helps in directoy listing| 
| tree-sitter | parser generator | 

List of packages installed for Data Science and ML

|  packages |  description |
| --- |  --- |
| numpy | library for mathematical function | 
| pandas | library for data manipulation | 
| scikit-learn | simple ML libraries | 
| matplotlib | for plotting | 
| seaborn| alternative to matplotlib for plotting | 
| tensorflow | highlevel ML library | 
| notebook | IDE | 
| jupyterlab | IDE | 


# Ubuntu Neovim (Manual)
If you follow `sudo apt install neovim`, and run `nvim --version` , it will point to 0.7 version. The current version is `0.10`. Follow these steps for building neovim from source

### Build Pre-requisites
- You should either have  `clang` or `gcc` , if not available install using `sudo apt install clang` or `sudo apt install gcc`
- If you do not have CMake then install using `sudo apt install cmake` else you will have to install python3g `sudo apt install python` and then run `pip install cmake`
- Next, install the following
  ```bash
  sudo apt-get install ninja-build gettext cmake unzip curl build-essential
  ```
- Next, let us download the neovim source code 

### Installing Neovim
```bash

# clone the repository
git clone https://github.com/neovim/neovim
cd neovim

# set make
make CMAKE_BUILD_TYPE=RelWithDebInfo

# Fetch the stable branch (latest one)
git checkout stable
sudo make install
```


 # GNU Stow
GNU Stow is the symlink farm manager which helps you control your configuration files 

## Installation
`brew install stow`

## Setup
Installing Stow using your package manager.

```bash
# mac
brew install stow

# ubuntu
sudo apt install stow

# arch
pacman -S stow

```

It is very easy to use. Replicate location of your files and use `stow` command to create symlink. 

1. Create a folder to store all your dotfiles
2. Example - wezterm config file's original location is `~/.config/wezterm/wezterm.lua `
3. Same can be followed for all your dotfiles

```bash

$> mkdir ~/.dotfiles
$> cd ~/.dotfiles

# for weztem
# create main directory
$> mkdir wezterm/
$> cd wezterm
# replicate the location
$> mkdir -p .config/wezterm/

# mv the wezterm.lua file to this new location
$> mv wezterm.lua ~/.dotfiles/wezterm/.config/wezterm

# running stow command will create the sym link
$> cd ~/.dotfiles/
$> stow wezterm

```




# References

- [Neovim Configuration](https://github.com/rvbug/neovim)  
- [Cookie-ml](https://github.com/rvbug/cookie-ml/)
- [GNU Stow](https://www.gnu.org/software/stow/)
