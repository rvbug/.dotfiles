#!/bin/bash

########################################################
# script      : projects.sh
# description : select on-going projects  
# author      : rvbug
# date        : 15 Aug 2022 : inital commit 
########################################################
#
#

root_dir="$HOME/Documents/projects"


echo " "
echo "####### searching for projects in $root_dir"
echo " "

echo " "
echo "####### select the projects from the list..."
echo " "


echo "#######################################################"
echo " "
echo "1) .dotfiles"
echo "2) neovim"
echo "3) cookie-ml"
echo "4) ml-cookie-project"
echo "5) none"
echo " "
echo "#######################################################"


read -p "select : " -n 1 -r reply
echo " "
echo "project selected is $reply"

case $reply in
  1) echo " "  
    cd $root_dir/.dotfiles
    nvim .
    ;;
  2)  cd $HOME/.config/neovim
      nvim .
    ;;
  3)  cd $root_dir/cookie-ml
    ;;
  4)  cd $root_dir/ml-cookie-project
    ;;
  5)  exit
    ;;
esac

# if [[ $reply == 1 ]]; then
#   # check if the directory exists
#   if [ -d "$root_dir/.dotfiles" ]; then
#     cd $root_dir/.dotfiles
#
#   else
#     echo " "
#     echo "directory not found.. exiting the script"
#     exit 0
#   fi
#
#
#
# elif [[ $reply == 2 ]]; then
#   cd $HOME/.config/neovim
# elif [[ $reply == 3 ]]; then
#   cd $root_dir/cookie-ml
# elif [[ $reply == 4 ]]; then
#   cd $root_dir/ml-cookie-project
# elif [[ $reply == 5 ]]; then
#   exit
# fi
#
#


