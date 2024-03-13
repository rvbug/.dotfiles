#!/bin/sh

########################################################
# script      : macos_install.sh
# description : installs the essentials on mac
# author      : rvbug
# date        : 06 Feb 2017 : inital commit 
########################################################


# installating some essential softwares
echo " "
echo "####### checking for homebrew..."

if command -v brew &>/dev/null; then
  echo "Homebrew already installed"
else
  echo "##### Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# for this script to work, we need a yaml processor
echo " "
echo "####### checking for yq is installation..."
if command -v yq &>/dev/null; then
  echo "yq already installed..."
else
  echo "##### Installing yq..."
  brew install yq

  if [ $? -eq 0 ]; then
   echo "###### yq installed successfully"
   echo "##### installing other essential tools"
  else
    echo "yq installation failed, install it and then re-run the script..."
    exit 0
  fi

  echo "####### installing other essentials..."
  install_essentials

fi

function install_essentials() {
  # open softwares.yaml file and read the contents
  # check if it is already installed using brew list option
  # if not then install it using brew install

  list=($(yq '.software-list' softwares.yaml))

  for software in "${list[@]}"; do
     if brew list $software &>/dev/null; then
          echo "$software is already installed"
      else
      echo "Installing $software..."
      # brew install $software
      fi
   done
}


function ds_tools() {
  # this will install ds tools from cookie-ml repo
  # setup all the libraries on the virtual env
  # regardless of the OS

  pip_list=($(yq '.pip-list' softwares.yaml))

  echo " "
  read -p "####### Do you want to install Data Science & ML tools? (y/n): " choice
    case "$choice" in
      y|Y) echo "setting up ml-cookie-cutter in your $HOME dir.."
        echo "ml-cookie-cutter project is setup your $HOME directory"
        
        # cd into HOME directory  
        cd $HOME
        # clone the cookie-ml repo
        git clone https://github.com/rvbug/cookie-ml.git 
        # cd into the cloned repo 
        cd cookie-ml
        # cookie-ml help
        echo " "
        echo " "
        echo "###########################################################################"
        python3 main.py --h
        echo " "
        echo " " 
        echo "###########################################################################"
        
        # check if ml-cookie-cutter folder is available
        # if available, then skip the installation

        if [ -d "$HOME/ml-cookie-cutter" ]; then
          echo " "
          echo "cookie cutter could be already installed"
          echo "Skipping installation..."
          echo "deleteing the cookie-ml repo"
          rm -rf "$HOME/cookie-ml"
          exit 0
        fi
        
        # run the command with the structure
        # setting up cookie-ml repo
        echo " "
        echo "installing cookie cutter project...."
        echo " "
        python3 main.py --v 
        pwd

        echo " "
        # delete the cloned repo
        echo "####### deleting the cookie-ml repo..."
        cd $HOME
        rm -rf cookie-ml

        # moving to ml-cookie-cutter folder
        cd $HOME/ml-cookie-cutter
        # activing the venv
        echo " "
        echo " "
        echo "####### activating the venv..."
        source venv/bin/activate

        # installing the necessary packages
        # open softwares.yaml file and read the contents
        # install all the softwares mentioned under pip
        echo " "
        echo "upgrading pip before installing rest of the tools.."
        python3 -m pip install --upgrade pip

        for pip_list in "${pip_list[@]}"; do
          echo "installing packages using $pip_list"
          # pip install $pip_list
        done
    
        echo " "
        echo "####### packages is installed successfully"
        echo " "
        echo "deactivating the venv..."
        deactivate

        echo " "
        echo " "
        echo "###################################################################"
        echo "ml-cookie-cutter is available in your $HOME directory"
        echo "activate your project using source venv/bin/activate"
        echo "###################################################################"
        echo " "
        echo " "

      ;;
      n|N) echo "Skipping ..."
      ;;
      *) echo "Invalid choice. Skipping..."
      ;;
    esac

}

ds_tools

function configure_mac() {
  # backup dotfiles from the yaml file
  echo "backing up .config files"
  config_list=($(yq '.config-list' softwares.yaml))

  # backup the .config files
  for config_list in "${config_list[@]}"; do
    echo "backing up $config_list"
    # cp "$HOME/$config_list" "$HOME/$config_list.bak.$(date +%Y-%m-%d)"
    ls "$HOME/$config_list"
  done

  # echo "cloning the repo"
  # config_dir="config"
  # git clone "https://github.com/rvbug/.dotfiles/" "$HOME/.dotfiles"
  # # check if config folder is available
  # # if available, then skip the installation
  # if [ -d "$HOME/.dotfiles/$config_dir" ]; then
  #     cp "$HOME/.dotfiles/$config_dir"/.tmux.conf "$HOME/"
  #     cp "$HOME/.dotfiles/$config_dir"/.wezterm.lua "$HOME/"
  #     cp "$HOME/.dotfiles/$config_dir"/.zshrc "$HOME/"
  #     cp "$HOME/.dotfiles/$config_dir"/startship.toml "$HOME/"
      
  #    for files in "$HOME/.dotfiles/$config_dir"/.*; do
  #     echo $files
  #     mv "$files" "$HOME/"
  #     echo "files are now moved"
  #   done
  # else
    echo "config folder is not available"
  # exit 0
  #fi

}






# Install Xcode Command Line Tools
echo " "
echo "installing the xcode command line tools..."
echo " "

xcode-select --version > /dev/null
# echo "$?"
# check if the above command is successful
if [ $? -eq 0 ]; then
  echo " "
  echo "Xcode Command Line Tools is available..."
  echo "installation on macos is complete... enjoy !!!" 
else
  echo " "
  echo "trying to install xcode command line tools..."
  xcode-select --install 
  if [ $? -ne 0 ]; then
    echo "xcode could not be installed, try manually..."
  fi
fi

echo  " "
echo  " "


