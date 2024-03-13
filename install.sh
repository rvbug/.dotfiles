#!/bin/sh

########################################################
# script      : setup.sh
# description : primary script 
# author      : rvbug
# date        : 06 Feb 2013 : inital commit 
########################################################

echo " "
echo "Starting installation process... "
echo " "
# preinstallation steps to be done
# before installing the essentials

function check_for_docker() {

    echo  " "
     read -p "Do you want install on a docker machine? (y/n): " choice

     case "$choice" in
        y|Y) echo "installation on docker instance..."
          echo "####### calling docker script"
          source ./docker_install.sh
          exit 0
          ;;   
        n|N) echo "Skipping docker installation..."
            # exit 1 
        ;;
        *) echo "Invalid choice. Skipping..."
          exit 0
        ;;
     esac   
}


function check_os() {
  # function to check the OS version
  # and use the package manager to
  # install the essentials
  
  os=$(uname -s)
  # echo $os 

  if [ $os == "Darwin" ]; then

    echo " "
    echo "####### Mac OS detected..."
    check_for_docker

    echo " "
    echo "####### initiating macos installation"
    ./macos_install.sh

    # check_n_install_essentials "macos"

  elif [ $os == "Linux" ]; then

    check_for_docker
    
    #check_n_install_essentials "linux"
    echo "####### detected Linux OS..."
    echo "####### initiating linux installation"

    source ./linux_install.sh

  else
    echo "####### $os not supported"
    exit 0
  fi
}

check_os

function check_n_install_essentials() {
  # list of generic softwares to be installed

  # open softwares.yaml file and read the contents
  # check if it is already installed using brew list option
  # if not then install it using brew install

  list=($(yq '.software-list' softwares.yaml))

  if [ $1 == "macos" ]; then

    echo "#############################################"
    echo "installing on mac..." 
    
    echo "check if homebrew is installed"
    echo "#############################################"

    if command -v brew &>/dev/null; then
      echo "Homebrew already installed"
    else
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      echo "##### Installing homebrew..."
    fi

    for software in "${list[@]}"; do
      if brew list $software &>/dev/null; then
          echo "$software is already installed"
      else
      echo "Installing $software..."
      # brew install $software
      fi
    done

  else
      echo "this is linux OS"
      echo "calling linux script"
      source ./linux.sh

      # apt update -y
      # apt upgrade -y
      for software in "${list[@]}"; do
        if dpkg -s $software &>/dev/null; then
            echo "$software is already installed"
        else
        echo "Installing $software..."
        # sudo apt install $software
        fi
      done
  fi

}

function add_config() {
  # add .config files
  echo "backing up the .config files"
  config_list=($(yq '.config-list' softwares.yaml))

  
  # backup the .config files
  for config_list in "${config_list[@]}"; do
    echo "backing up $config_list"
    cp "$HOME/$config_list" "$HOME/$config_list.bak.$(date +%Y-%m-%d)"
  done

  echo "cloning the repo"
  config_dir="config"
  git clone "https://github.com/rvbug/.dotfiles/" "$HOME/.dotfiles"
  # check if config folder is available
  # if available, then skip the installation
  if [ -d "$HOME/.dotfiles/$config_dir" ]; then
      cp "$HOME/.dotfiles/$config_dir"/.tmux.conf "$HOME/"
      cp "$HOME/.dotfiles/$config_dir"/.wezterm.lua "$HOME/"
      cp "$HOME/.dotfiles/$config_dir"/.zshrc "$HOME/"
      cp "$HOME/.dotfiles/$config_dir"/startship.toml "$HOME/"
      
  #    for files in "$HOME/.dotfiles/$config_dir"/.*; do
  #     echo $files
  #     mv "$files" "$HOME/"
  #     echo "files are now moved"
  #   done
   else
    echo "config folder is not available"
    exit 0
  fi

  # delete the cloned repo
  echo "deleting the repo..."
  rm -rf "$HOME/.dotfiles"
}


# echo "This script will install the essentials on your system"

# check the OS version and use the package manager 
# to install the essentials
#check_os
# call the function to install the datascience tools
# echo "installing data science tools..."

#ds_tools

# echo "it's time to add .config files"
#add_config

#source ./linux.sh


# finally messages to the user before starting the script
# show the usage, what happens and how it happens
