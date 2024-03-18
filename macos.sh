#!/bin/sh

########################################################
# script      : macos_install.sh
# description : installs the essentials on mac
# author      : rvbug
# date        : 06 Feb 2017 : inital commit 
########################################################

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


# installating some essential softwares
echo " "
echo "####### checking for homebrew..."

if command -v brew &>/dev/null; then
  echo "Homebrew already installed"
else
  echo "##### Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo " "
echo "checking if git is installed..."

if command -v git &>/dev/null; then
  echo "git already installed..."
else
  echo "##### Installing git..."
  brew install git
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
    echo "yq installation failed, install it manually and then re-run the script..."
    exit 0
  fi

fi
  echo " "
  echo "####### checking if ocaml is already installed..."

  if brew list ocaml &>/dev/null; then
    echo "####### ocaml is already installed"
  else
      echo " "
      read -p "do you want to install ocaml? (y/n): " choice
      
      if [ -z "$choice" ]; then
        choice="y"
      fi
      if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
          echo " "
          echo "####### installing ocaml..."
          brew install ocaml
          echo "####### installing ocaml's package manager..."
          bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"
          echo "####### Initialise opam..."
          opam init
      fi

  fi

 echo "####### installing other essentials..."
 install_essentials




function ds_tools() {
  # this will install ds tools from cookie-ml repo
  # setup all the libraries on the virtual env
  # regardless of the OS

  pip_list=($(yq '.pip-list' softwares.yaml))

  echo " "
  read -p "####### Do you want to install Data Science & ML tools? (y/n): " choice
    case "$choice" in
      y|Y) echo " "
        
        # check if ml-cookie-cutter folder is available
        # if available, then skip the installation
        if [ -d "$HOME/ml-cookie-cutter" ]; then
          echo " "
          echo "cookie cutter project is setup at \"$HOME\" ..."
          echo "skipping installation..."
          echo " "          
          echo "continue with rest of the installation..."
        else
          # run the command with the structure
          # setting up cookie-ml repo
          # cd into HOME directory  
          cd $HOME
          git clone https://github.com/rvbug/cookie-ml.git 
          # cd into the cloned repo 
          cd cookie-ml
          echo "####### setting up ml-cookie-cutter in your \"$HOME\" dir.."
          echo "feel free to rename this project"
          echo " "
          echo "installing cookie cutter project...."
          echo " "
          echo "####### Here's the help for cookie-ml..."
          echo " "
          echo " "
          echo "###########################################################################"
          python3 main.py --h
          echo " "
          echo " " 
          echo "###########################################################################"
          echo " "
          # cookie-ml help
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
          echo "deleteing the cookie-ml repo..."
          rm -rf "$HOME/cookie-ml"
          echo " "
          echo " "
          echo "###################################################################"
          echo "ml-cookie-cutter is setup at $HOME directory"
          echo " "
          echo "activate your project using source venv/bin/activate"
          echo "###################################################################"
          echo " "
          echo " "
        fi
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
  echo " "
  echo "####### backing up .config files"
  config_list=($(yq '.config-list' softwares.yaml))

  # backup the .config files
  for config_list in "${config_list[@]}"; do
    # echo "backing up $config_list"
    cp "$HOME/$config_list" "$HOME/$config_list.bak.$(date +%Y-%m-%d-%H:%M:%S)"
    ls "$HOME/$config_list"
  done

   echo "cloning the repo"
   config_dir=".config"
   git clone "https://github.com/rvbug/.dotfiles/" "$HOME/.dotfiles"
   # check if config folder is available
   # if available, then skip the installation
   if [ -d "$HOME/.dotfiles/$config_dir" ]; then
       cp "$HOME/.dotfiles/$config_dir"/.tmux.conf "$HOME/"
       cp "$HOME/.dotfiles/$config_dir"/.wezterm.lua "$HOME/"
       cp "$HOME/.dotfiles/$config_dir"/.zshrc "$HOME/"
       cp "$HOME/.dotfiles/$config_dir"/startship.toml "$HOME/$config_dir/"
     
     # for files in "$HOME/.dotfiles/$config_dir"/.*; do
     #   echo $files
     #   cp "$files" "$HOME/"
     #   echo "files are now moved"
     # done

   else
   echo "config folder is not available"
   echo " continue with rest of the installation..."
  fi

  # delete the repo
  echo " "
  echo "deleting the repo..."
  rm -rf "$HOME/.dotfiles"


  # now once this is completed then check if neovim is installed
  # if not then install it
  
  # check if neovim is installed
  
  if brew list neovim &>/dev/null; then
    echo " "
    echo "neovim is already installed"
    echo " "
    echo "starting configuring neovim..."

    # now since neovim is already installed, check if 
    # .config and .config/nvim folder is available 

    # if not then create it
    if [ -d "$HOME/.config/nvim" ]; then
      echo " "
      echo "neovim config folder is available"
      echo " "
      cd "$HOME"
      echo " "
      echo "backing up the existing neovim config if available..." 
      dt=$(date +%Y-%m-%d-%H-%M-%S) 
       # cp -r $HOME/.config/nvim/ $HOME/.config/nvim.bak.$dt
       # mv $HOME/.config/nvim/ $HOME/.config/nvim.bak.$dt
        cp -r $HOME/.config/nvim/ $HOME/.config/nvim.bak.$dt
      echo " "
    else
      # if these folders are not available then create them
      mkdir -p "$HOME/.config/nvim"
      echo " "
      echo "folders created..."
    fi

      echo " "
      echo " " 
      echo "####### downloading the neovim github repo to your $HOME/.config folder..."

      git clone https://github.com/rvbug/neovim.git $HOME/.config/nvim
      echo " "
      echo "###################################################################"
      echo " "
      echo " "
      echo "Now open nvim and wait for the magic to happen!!"
      echo " "
      echo "###################################################################"

      echo "Now open nvim and let it do it's thing.. wait for the magic to happen!!"
  
    # download the neovim github repo

    # git clone https://github.com/neovim/neovim.git "$HOME/nvim"


  else
    echo " "
    echo "something went wrong, go for manual installation..."
    echo " "
  fi

}


echo "###################################################################"
echo " configuring your new machine"
echo " "
echo "###################################################################"
configure_mac

# Install Xcode Command Line Tools
echo " "
echo "####### installing the xcode command line tools..."
echo " "

xcode-select --version > /dev/null
# echo "$?"
# check if the above command is successful
if [ $? -eq 0 ]; then
  echo "command line tools is already available..."
  echo " "
  echo "#############################################################"
  echo " "
  echo "installation on macos is complete... enjoy !!!" 
  echo " "
  echo "#############################################################"
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


