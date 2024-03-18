#!/bin/bash

echo " "
echo "#############################################"

echo " "
echo " "
echo "####### checking for linux distro..."
echo " "

pkg_mgr=""
os_name=""
if [ -f "/etc/debian_version" ]; then
    echo " " 
    echo "looks like this is debian"
    echo "####### debian uses apt or apt-get pkg manager"
    # echo "at this time, I am unable to get neovim installed on debian"
    pkg_mgr=apt
    os_name="debian"
elif [ -f "/etc/fedora-release" ]; then
    echo " "
    echo "looks like this is fedora"
    echo "####### checking for dnf or yum"
    dnf > /dev/null 2>&1
    if [ $? -eq 0 ]; then
      echo " "
      echo "dnf is available so using it as your package manager..."
      echo " "
      pkg_mgr=dnf
      os_name="fedora"
    else
      echo "dnf is unavailable so using yum..."
      pkg_mgr=yum
      os_name="fedora"
    fi

 elif [-z "/etc/os-release"]; then
     source /etc/os-release
     os_name=$NAME
     if [ "$os-name" == "Ubuntu" ]; then
       echo " "
       echo "looks like this is ubuntu"
       echo "####### using apt as your pkg manager"
     pkg_mgr=apt
     os_name="ubuntu"
     fi 
  else
    echo "sorry, I am not sure what this machine is"
    echo "exiting the script..."
    exit 0
fi

echo " "
echo " "
echo " "
echo "####### os detected will be $os_name"
echo "####### package manager will be $pkg_mgr"

exit 0
echo " "



# check if you are runing as root
user=$(whoami)
if [ "$user" == "root" ]; then
  echo " "
  echo "###################################################" 
  echo "####### looks like you are running as root"
  echo "####### never run any script as a root user" 
  echo "####### think twice..." 
  echo "###################################################" 
  echo " "
fi

 # ask user if they want to run this script as sudo or not
 echo " "
 echo "####### checking if you want to run this script as sudo..."
 echo "If without sudo gives you an error, rerun the script with sudo"

 read -p "do you want to run this script as sudo (y/n)?" choice
 case "$choice" in
   y|Y ) echo "running as sudo..."
         su_user=sudo
         pkg_mgr="$su_user $pkg_mgr"
        ;;
   n|N ) su_user=" " 
     echo "running as normal user..."
        ;;
   * ) su_user=" " 
     echo "invalid input, running as normal user"
   ;;
esac

echo "before starting the installation process, ensure you have git installed on your machine..."
git --version > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo " "
  echo "####### git is already installed"
  echo "continuing..."
else
  echo " "
  echo "git is not installed on your machine..."
  echo "installing git..."
  $pkg_mgr install git -y
fi


echo " "
echo "checking if you have wget installed on your machine, if not then install it"
wget --version > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo " "
  echo "####### wget is already installed"
  echo "continuing..."
else
  echo " "
  echo "wget is not installed on your machine..."
  echo "installing wget..."
  $pkg_mgr install wget -y
fi  

# setting up pkg manager as global variable 
# pkg_mgr=dnf

function install_essentials {

  echo "Package manager is $pkg_mgr"
  echo "####### checking other essentials..."
  echo " "

  echo "####### checking if yq is installed"
  if $pkg_mgr list installed yq &>/dev/null; then
    echo " "
    echo "yq already installed..."
  else
      echo " "
      echo "##### Installing yq..."
      echo "#######downloaing the package using wget.."
      echo "#######this will take few minutes..." 
      $su_user wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
      if [ $? -eq 0 ]; then
        $su_user chmod +x /usr/local/bin/yq

        echo " " 
        echo "####### checking for the installation..."
        if yq --version &>/dev/null; then
          echo " "
          echo "yq installed successfully..."
        fi
      else
      echo "####### yq installation failed, please manually install this package to proceed with the installation"
      exit 0
      fi
  fi

  echo " "
  read -p "Do you want to update your system?: (y/n) " choice 
  case "$choice" in
    y|Y ) echo "updating system..."
          $su_user $pkg_mgr update -y
        ;;
    n|N ) echo "skipping update..."
      ;;
    * ) echo "invalid input, skipping update"
    ;;
  esac
   echo " " 
   echo "####### for linux distro using dnf "  


   echo " "
   echo "####### checking if ocaml is already installed..."

   # if  dnf list installed ocaml &>/dev/null; then
   #    read -p "Do you want to initialize opam?: (y/n) " choice
   #
   #  case "$choice" in
   #    y|Y ) echo "initializing opam..."
   #          opam init
   #          opam install ocaml-lsp-server odoc ocamlformat utop
   #        ;;
   #    n|N ) echo "skipping opam initialization..."
   #      ;;
   #    * ) echo "invalid input, skipping opam initialization"
   #    ;;
   #  esac

    # echo "###################################################################"
    # echo "####### starting configuration process..."
    # echo " "
    # echo "###################################################################"
    #
    # configure_linux
  if $pkg_mgr list installed ocaml &>/dev/null; then
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
          $pkg_mgr install ocaml
          echo "####### installing ocaml's package manager..."
          bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"
          echo "####### Initialise opam..."
          opam init
      fi

  fi


  list=($(yq '.software-list' softwares.yaml))

  for software in "${list[@]}"; do
    case "$software" in
      wezterm) echo " "
        echo "####### wezterm is unavailble on fedora, use inbuilt terminal instead, skipping..."
        ;;
      starship) echo " " 
        echo "####### starship is not yet supported on fedora, use ohmyzsh instead..."
        ;;
      fd) echo " "
        echo "####### fd is not yet supported on fedora, use ripgrep instead..."
        ;;
      yarn) echo " "
        echo "####### installing yarnpkg"
        # dnf install yarnpkg -y
        $su_user $pkg_mgr install yarnpkg -y
        ;;
      lazygit) echo " " 
        echo "####### lazygit is not yet supported on fedora, installing gitui instead..."
        # dnf install gitui -y
        $su_user $pkg_mgr install gitui -y
        ;;
      lua5.4) echo "lua5.4 is not yet supported on fedora, installing lua5.1 instead..."
        # dnf install lua5.1 -y
        $su_user $pkg_mgr install lua5.1 -y 
        ;;
      npm) echo "npm is installed via nodejs in fedora, installing"
        # dnf install nodejs -y
        $su_user $pkg_mgr install nodejs -y
        ;;
      tree-sitter) echo " "
        echo "####### tree-sitter is unavailable in fedora...download it manually..."
        ;;
      # ocaml) echo " "
      #   # dnf install ocaml -y
      #   echo "####### installing opam..."
      #   bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"
      #   ;; 
      *) echo "checking other packages..."
          # if dnf list $software &>/dev/null; then 
          #   echo "####### $software is already installed" 
          # else
            # dnf install $software -y
            $su_user $pkg_mgr install $software -y
          ;;
    esac
  done

}
install_essentials

function configure_linux() {

  config_list=($(yq '.config-list' softwares.yaml))


  echo " "
  echo "######## starting configuration process..."

  echo " "
  echo "ensure you do not run this as root..." 

  # check if the config folder is available
  # if available, then skip the installation
  if [ -d "$HOME/.config" ]; then
    echo " "
    echo "config folder is already available at $HOME/.config"
  else
    echo " "
    echo "config is not available at $HOME creating one"
    mkdir -p "$HOME/.config"
  fi

  # backup dotfiles from the yaml file
  echo " "
  echo "####### check if your config files esists" 

  for config_list in "${config_list[@]}"; do
    if [ -f "$HOME/$config_list" ]; then
      echo " "
      echo "file $config_list exists"
      echo " "
      echo "backing up $config_list"
      cp "$HOME/$config_list" "$HOME/$config_list.bak.$(date +%Y-%m-%d-%H:%M:%S)"
    else
      echo " "
      echo "file $config_list does not exist"
    fi
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
  
  if dnf list neovim &>/dev/null; then
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
      echo "nvim folders created..."
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

# calling the ds script

echo "calling the datascience tools script..."
./ds_tools.sh

