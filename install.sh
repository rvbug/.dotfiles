#!bin/sh

########################################################
# script      : setup.sh
# description : installs the essentials on mac
# author      : rvbug
# date        : 06 Feb 2013 : inital commit 
########################################################

function check_n_install_essentials() {
  # list of generic softwares to be installed

  # open softwares.yaml file and read the contents
  # check if it is already installed using brew list option
  # if not then install it using brew install

  list=($(yq '.software-list' softwares.yaml))

  if [ $1 == "macos" ]; then

    echo "installing on mac..." 
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



function check_os() {
  # function to check the OS version
  # and use the package manager to
  # install the essentials
  
  os=$(uname -s)
  echo $os 

  if [ $os == "Darwin" ]; then
    echo "Detected Mac OS..."

    # now check if homebrew is installed if not then install it
    # we will use command -v option to check if homebrew is installed

    if command -v brew &>/dev/null; then
      echo "Homebrew already installed"
    else
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      echo "Installing homebrew..."
    fi

   check_n_install_essentials "macos"

  # this could be linux machine 
  elif [ $os == "Linux" ]; then
    echo "Detected Linux OS..."
    echo "using apt as package manager"
    check_n_install_essentials "linux"
  else
    echo "this might be another linux distro.. support coming soon"
    exit 0
  fi
}


function ds_tools() {
  # this will install ds tools from cookie-ml repo
  # setup all the libraries on the virtual env
  # regardless of the OS

  pip_list=($(yq '.pip-list' softwares.yaml))

  read -p "Do you want to install Data Science tools? (y/n): " choice
    case "$choice" in
      y|Y) echo "setting up cookie-ml repo..."
        echo "ml-cookie-cutter project is setup your $HOME directory"
        
        # cd into HOME directory  
        cd $HOME
        # clone the cookie-ml repo
        git clone https://github.com/rvbug/cookie-ml.git 
        # cd into the cloned repo 
        cd cookie-ml
        # cookie-ml help
        echo " "
        echo "here's the help file for cookie-ml"
        python3 main.py --h

        echo " "
        # check if ml-cookie-cutter folder is available
        # if available, then skip the installation

        if [ -d "$HOME/ml-cookie-cutter" ]; then
          echo "cookie cutter is already installed"
          echo "Skipping installation..."
          echo "deleteing the cookie-ml repo"
          rm -rf "$HOME/cookie-ml"
          exit 0
        fi
        
        # run the command with the structure
        # setting up cookie-ml repo
        python3 main.py --v 
        pwd
        # delete the cloned repo
        echo "deleting the cookie-ml repo..."
        cd $HOME
        rm -rf cookie-ml

        # moving to ml-cookie-cutter folder
        cd $HOME/ml-cookie-cutter
        # activing the venv
        echo "activating the venv..."
        source venv/bin/activate

        # installing the necessary packages
        # open softwares.yaml file and read the contents
        # install all the softwares mentioned under pip

        for pip_list in "${pip_list[@]}"; do
          echo "installing $pip_list"
        done
      ;;
      n|N) echo "Skipping ..."
        exit 0
      ;;
      *) echo "Invalid choice. Skipping..."
        exit 0
      ;;
    esac

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


echo "This script will install the essentials on your system"

# check the OS version and use the package manager 
# to install the essentials
#check_os
# call the function to install the datascience tools
#ds_tools

echo "it's time to add .config files"
add_config




# finally messages to the user before starting the script
# show the usage, what happens and how it happens
