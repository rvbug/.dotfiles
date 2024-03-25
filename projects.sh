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
echo "1) .dotfiles"
echo "2) neovim"
echo "3) cookie-ml"
echo "4) ml-cookie-project"
echo "5) none"
echo " "
echo "#######################################################"


read -p "select : " -n 1 -r reply
echo " "
echo "project selectec is $reply"

case $reply in
  1)  cd $root_dir/dotfiles
    ;;
  2)  cd $root_dir/neovim
    ;;
  3)  cd $root_dir/cookie-ml
    ;;
  4)  cd $root_dir/ml-cookie-project
    ;;
  5)  exit
    ;;
esac
