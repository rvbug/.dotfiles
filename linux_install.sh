#!/bin/sh
#
echo " "
echo "#############################################"


# check which packae manager is being used
# option 1: apt for debian
# option 2: pacman for arch
# option 3: dnf for fedora
# option 4: zypper
# option 5: brew
# option 6: choco
# option 7: yay
# option 8: flatpak
# option 9: snap
# option 10: none

echo " "
echo "Checking version of Linux"
echo " "


if [ -f "/etc/debian_version" ]; then
  echo "debian uses apt or apt-get pkg manager"
  echo "at this time, I am unable to get neovim installed on debian"
  exit 0

elif [ -f "/etc/fedora-release" ]; then
  echo "looks like this is fedora"
  echo "starting the installation process"
  # install_essentials
else
  echo "this could be ubuntu"
  echo "currently, I am unable to install neovim on ubuntu"
  exit 0
fi

echo " "
# checking for pkg manager here to keep the variable global
echo "####### checking if package manager is dnf or yum"
dnf > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "dnf is available so using as the package manager"
fi

echo " "
echo " "

echo "before starting the installation process, ensure you have git installed on your machine..."
# check if git is installed on your machine
git --version > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo " "
  echo "####### git is already installed"
  echo "continuing..."
else
  echo " "
  echo "git is not installed on your machine..."
  echo "installing git..."
  sudo $pkg_mgr install git -y
fi


# setting up pkg manager as global variable 
pkg_mgr=dnf

function install_essentials {

  echo "Package manager is $pkg_mgr"

  echo "####### checking other essentials..."

  echo "checking for wget ..."
  wget --version > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "wget is installed on your machine"
    echo "continuing..."
  else
    echo "wget is not installed on your machine..."
    echo "installing wget..."
    sudo $pkg_mgr install wget -y
  fi

  echo "####### checking if yq is installed"

  if dnf list installed yq &>/dev/null; then
    echo "yq already installed..."
  else
      echo "##### Installing yq..."
      echo "downloaing the package using wget.."
      echo "this will take few minutes..." 
      sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
      echo "...looks like this will take few more minutes..."
      if [ $? -eq 0 ]; then
      sudo chmod +x /usr/local/bin/yq
      
      echo "checking for the installation..."

      if yq --version &>/dev/null; then
        echo "yq installed successfully..."
      fi

      else
      echo "yq installation failed, please manually install this package to proceed with the installation"
      exit 0
      fi
  fi

  read -p "Do you want to update your system?: (y/n) " choice 
  case "$choice" in
    y|Y ) echo "updating system..."
          sudo $pkg_mgr update -y
        ;;
    n|N ) echo "skipping update..."
      ;;
    * ) echo "invalid input, skipping update"
    ;;
  esac
   echo "####### for linux distro using dnf "  


  list=($(yq '.software-list' softwares.yaml))

  for software in "${list[@]}"; do
    case "$software" in
      wezterm) echo "wezterm unaavailble on fedora, skipping..."
        ;;
      starship) echo "starship is not yet supported on fedora, use ohmyzsh instead..."
        ;;
      lazygit) echo "lazygit is not yet supported on fedora, installing gitui instead..."
        dnf list gitui
        ;;
      lua5.4) echo "lua5.4 is not yet supported on fedora, installing lua5.1 instead..."
        dnf list lua5.1
        ;;
      npm) echo "npm is installed via nodejs in fedora, installing"
        dnf list nodejs
        ;;
      *) echo "checking other packages..."
          # if dnf list $software &>/dev/null; then 
          #   echo "####### $software is already installed" 
          # else
            dnf list $software
          ;;
    esac
  done

    # echo "###################################################################"
    # echo "####### starting configuration process..."
    # echo " "
    # echo "###################################################################"
    #
    # configure_linux
}

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
          echo "####### setting up ml-cookie-cutter in your \"$HOME\" dir.."
          echo "feel free to rename this project"
          echo " "
          echo "installing cookie cutter project...."
          echo " "
          echo "####### Here's the help for cookie-ml..."
          echo " "
          python3 main.py --v 
          pwd
        
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




function configure_linux() {
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
   config_dir="config"
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



