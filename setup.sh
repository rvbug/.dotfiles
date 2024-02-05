#!bin/sh

########################################################
# script      : setup.sh
# description : 
# 
#
#
########################################################


help()
{
  # displays help
  # this script helps you to install on a fresh machine
  echo " ##########################################################"
  echo " "
  echo " This script performs the following actions :"
  echo " \n "
  echo "\t * Backup your tmux, neovim & wezterm files & clones from repository."
  echo "\t * Deletes cloned repo folders"
  echo "\n"
  echo "Usage: setup.sh [-h | --help]"
  echo "  -help: Displays this help message."
  echo "  -a: Install all missing packages automatically."
  echo "  -b: Install Homebrew."
  echo "  -t: Install tmux."
  echo "  -n: Install neovim."
  echo " "
  echo " ##########################################################"
 
}

check_for_installation ()
{
   $? = "command -v bre0"
   ##if ! [[ command -v brew &> /dev/null ]]; then
     if ! [[ "$0" != 0 ]]; then
     echo "brew is not installed"
     install "brew"
   else
    echo "brew is already installed"
  fi

  # if ! [[ command -v tmux &> /dev/null ]]; then
  #   echo "tmux not installed"
  #   install tmux
  # fi

}

install ()
{
  read -p "Do you want to install $1? 
  ([aA] to install all, 1 for $1, 2 for tmux, 
  3 for neovim, or press Enter to skip): " choice

    case "$choice" in
      a|A) echo "installed brew"
      ;;
      t) echo "tmux is installed now" 
      ;;
      *) echo "default installation"
      ;;
    esac
}


if [[ "$#" -eq 0 ]]; then
  echo "no arguments provided, please use the following flag"
  clear >$(tty)

  # call for help!
  help
  exit 0
fi

if [[ "$1" == "--h" ]]; then 
  clear >$(tty)
  help
fi  

check_for_installation
install

