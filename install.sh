#!bin/sh

########################################################
# script      : setup.sh
# description : installs the essentials on mac
# author      : rvbug
# date        : 06 Feb 2020 : inital commit
# future      : support for linux machine  
########################################################


# function to check the OS version

function check_os() {
  os=$(uname -s)
  echo $os 


  if [ $os == "Darwin" ]; then
    echo "Detected Mac OS..."

    # now check if homebrew is installed if not then install it
    # we will use command -v option to check if homebrew is installed

    if command -v brew &>/dev/null; then
      echo "Homebrew already installed"
      exit
    else
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      echo "Installing homebrew..."
    fi

  # this could be linux machine 
  else
    echo "this might be a linux machine.. for now this script supports only mac os"
  fi
}

# call the function to 
# check_os


function check_essentials() {
  # open softwares.yaml file and read the contents
  # install all the softwares mentioned in the file

  # open softwares.yaml file and read the contents

}


# function install_essentials() {
#       brew install git
#       brew install ffmpeg
# }
