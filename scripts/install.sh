#!/bin/bash

########################################################
# script      : setup.sh
# description : primary script 
# author      : rvbug
# date        : 06 Feb 2013 : inital commit 
########################################################

echo " "
echo "####### Starting installation process... "
echo " "
# preinstallation steps to be done
# before installing the essentials

# function check_for_docker() {
#
#     echo  " "
#      read -p "Do you want install on a docker machine? (y/n): " choice
#
#      case "$choice" in
#         y|Y) echo "installation on docker instance..."
#           echo "####### calling docker script"
#           source ./docker_install.sh
#           exit 0
#           ;;   
#         n|N) echo "Skipping docker installation..."
#             # exit 1 
#         ;;
#         *) echo "Invalid choice. Skipping..."
#           exit 0
#         ;;
#      esac   
# }

# --- Function to link dotfiles using GNU Stow ---
function link_dotfiles() {
  echo " "
  echo "####### Linking dotfiles with GNU Stow..."
  
  # Ensure stow is installed (essential check)
  if ! command -v stow &> /dev/null; then
    echo "Error: 'stow' is not installed. Skipping linking."
    return
  fi

  # Path to your dotfiles core directory
  # Using $HOME/.dotfiles because that is the standard location
  DOTFILES_DIR="$HOME/.dotfiles"
  CORE_DIR="$DOTFILES_DIR/core"

  if [ -d "$CORE_DIR" ]; then
    # 1. Clean up default files to prevent Stow conflicts
    # We remove them so Stow can replace them with symlinks
    rm -f ~/.zshrc
    rm -f ~/.tmux.conf
    rm -rf ~/.config/ghostty

    # 2. Change directory to core and link packages
    # We target the Home directory (~)
    cd "$CORE_DIR"
    stow -v -R -t ~ zsh
    stow -v -R -t ~ tmux
    stow -v -R -t ~ ghostty
    
    echo "####### Dotfiles linked successfully."
  else
    echo "Error: Dotfiles core directory not found at $CORE_DIR"
  fi
}

function check_os() {
  # function to check the OS version
  # and use the package manager to
  # install the essentials

  os=$(uname -s)
  # echo $os 

  if [ $os == "Darwin" ]; then

    echo " "
    echo "####### detected mac os..."
    # check_for_docker

    echo " "
    ./macos.sh

    # Link dotfiles after software is installed
    link_dotfiles

    # check_n_install_essentials "macos"

  elif [ $os == "Linux" ]; then

    # check_for_docker

    #check_n_install_essentials "linux"
    echo "####### detected Linux OS..."
    echo "####### initiating linux installation"

    ./linux.sh

    # Link dotfiles after software is installed
    link_dotfiles

  else
    echo "####### $os not supported"
    exit 0
  fi
}

check_os


