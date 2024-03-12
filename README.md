# <p align="center"> <bold>•</bold> dotfiles <p> 

# Introduction

This repository helps to restore or configure a new machine with one single shell script

# Files 

List of files under this repository

| File | Type |  Description |
| --- | --- | --- |
| `install.sh` | Shell Script  | Installation & Configuration script  |    
| `software.yaml`  | YAML file | List of softwares to be installed | 
| `config/.tmux.conf`|  Tmux  | tmux configuration file| 
| `config/.wezterm.lua`| Terminal | wezterm lua config file | 
| `config/.zshrc`| profile | shell profile| 
| `config/starship.toml`| Shell Prompt | shell prompt | 


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


