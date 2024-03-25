# <p align="center"> <bold>•</bold>dotfiles </p> 


  
![macOS](https://img.shields.io/badge/mac%20os-000000?style=for-plastic&logo=macos&logoColor=F0F0F0)
![Fedora](https://img.shields.io/badge/Fedora-294172?style=for-plastic&logo=fedora&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-plastic&logo=docker&logoColor=white)  

![NumPy](https://img.shields.io/badge/numpy-%23013243.svg?style=for-plastic&logo=numpy&logoColor=white)
![Pandas](https://img.shields.io/badge/pandas-%23150458.svg?style=for-plastic&logo=pandas&logoColor=white)
![scikit-learn](https://img.shields.io/badge/scikit--learn-%23F7931E.svg?style=for-plastic&logo=scikit-learn&logoColor=white)
![Matplotlib](https://img.shields.io/badge/Matplotlib-%23ffffff.svg?style=for-plastic&logo=Matplotlib&logoColor=black)
![TensorFlow](https://img.shields.io/badge/TensorFlow-%23FF6F00.svg?style=for-plastic&logo=TensorFlow&logoColor=white)
![Jupyter Notebook](https://img.shields.io/badge/jupyter-%23FA0F00.svg?style=for-plastic&logo=jupyter&logoColor=white)  

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-plastic&logo=neovim&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-plastic&logo=python&logoColor=ffdd54)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-plastic&logo=lua&logoColor=white)
![Rust](https://img.shields.io/badge/rust-%23000000.svg?style=for-plastic&logo=rust&logoColor=white)
![OCaml](https://img.shields.io/badge/OCaml-%23E98407.svg?style=for-plastic&logo=ocaml&logoColor=white)

# Introduction

This repository helps to restore/configure new machine via script based on the OS. Currently, this configuration supports

- Mac OS
- Linux Fedora
- Linux 

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
| `software_list.txt`  | text file | List of softwares to be installed | 
| `pip_list.txt`  | text file | List of softwares for data science and ML | 
| `config_list.txt`  | text file | List of config files | 
| `config/.tmux.conf`|  tmux  | tmux configuration file| 
| `config/.wezterm.lua`| terminal | wezterm lua terminal config file | 
| `config/.zshrc`| profile | shell profile| 
| `config/starship.toml`| shell Prompt | shell prompt | 


# Versions Tested on
| OS | Version |  package manager |
| --- | --- | --- |
| mac | Ventura | homebrew | 
| mac  | Sonoma | homebrew | 
| linux | Fedora (incld. docker support) | dnf | 


**`Note`**: The script works on Ubuntu/Arch/Debian machines but the apt package manager keeps pointing to neovim 0.7x version. Current version of neovim as of today is 0.9x 

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

 
# Future Support
- Ubuntu & Debian

# References

- [Neovim Configuration](https://github.com/rvbug/neovim)  
- [Cookie-ml](https://github.com/rvbug/cookie-ml/)  
