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

    # check_n_install_essentials "macos"

  elif [ $os == "Linux" ]; then

    # check_for_docker
    
    #check_n_install_essentials "linux"
    echo "####### detected Linux OS..."
    echo "####### initiating linux installation"

    ./linux.sh

  else
    echo "####### $os not supported"
    exit 0
  fi
}

check_os

