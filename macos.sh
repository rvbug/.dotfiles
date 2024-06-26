#!/bin/bash

########################################################
# script      : macos_install.sh
# description : installs the essentials on mac
# author      : rvbug
# date        : 06 Feb 2017 : inital commit 
########################################################

# script first check if the software list file exists
#

echo " "
echo "####### starting mac os installation..."
echo "########################################"
echo "to get started..."
echo "you will need to install homebrew first "
echo "it will ask you to run 2 commands on the terminal once the installaiton is complete"
echo " "
echo "xcode command line tool will also be installed along with git..."
echo "once the installation is completed, close and reopen the terminal..."
echo "########################################"

echo " "
echo "checking essential softwares..."

echo "####### checking for homebrew..."
if command -v brew &>/dev/null; then
  echo "Homebrew already installed"
else
  echo "##### Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo " "
echo "####### checking for git..."

if command -v git &>/dev/null; then
  echo "git already installed..."
else
  echo "##### Installing git..."
  brew install git
fi

echo " "
echo "####### checking list of software on the system..."


if [ -f "software_list.txt" ]; then
  echo "####### software_list.txt exists."
  cat software_list.txt | while read line
  do
    echo "#######"
    # check if the $line is lua 
    if [ "$line" = "lua" ]; then
      if brew list lua &>/dev/null; then
        echo "lua is already installed..."
      else
        echo " "
        echo "####### installing lua..."
        brew install lua@5.4
      fi
    fi

    if brew list $line &>/dev/null; then
      echo "$line is already installed"
    else
      echo " "
      echo "####### installing $line..."
      brew install $line
    fi
  done
else
  echo " "
  "####### software_list.txt does not exist, exiting the script..."
  exit 0
fi 

echo " "
echo "####### checking for ocaml ..."

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


function ds_tools() {
  # this will install ds tools from cookie-ml repo
  # setup all the libraries on the virtual env
  # regardless of the OS

  # install pyaml first
  echo " "
  echo " ###### checking for pyaml..."
  # check if pyyaml is installed
  if brew list pyyaml &>/dev/null; then
    echo " "
    echo "pyaml is already installed"
  else
    echo " "
    echo "####### installing pyaml..."
    brew install pyyaml
  fi

  echo " "
  read -p "####### Do you want to install Data Science & ML tools? (y/n): " choice
    case "$choice" in
      y|Y) echo " "
        # check if ml-cookie-cutter folder is available
        # if available, then skip the installation
        if [ -d "$HOME/ml-cookie-cutter" ]; then
          echo " "
          echo "cookie cutter project is setup at \"$HOME\" ..."
          echo "skipping ml setup installation..."
          echo " " 
          echo "continue with rest of the installation..."
        else
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

          echo " "
          echo "upgrading pip before installing rest of the tools.."
          python3 -m pip install --upgrade pip
          if [ -f "$HOME/.dotfiles/pip_list.txt" ]; then
              echo "####### pip_list.txt exists."
              cat $HOME/.dotfiles/pip_list.txt | while read cfg 
              do
                echo "checking if $cfg is already installed..."
                pip3 install $cfg

                # if brew list $cfg &>/dev/null; then
                #   echo "$cfg is already installed"
                # else
                #   echo " "
                #   echo "####### installing $cfg..."
                #   brew install $cfg
                # fi

              done
          else
              echo " "
              "####### config_list.txt does not exist, exiting the script..."
              exit 0
          fi 

          # for pip_list in "${pip_list[@]}"; do
          #   echo "installing packages using $pip_list"
          #   # pip install $pip_list
          # done
      
          echo " "
          echo "####### packages is installed successfully"
          echo " "
          cd $HOME/ml-cookie-cutter
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
#
#home folder
function configure_mac() {
  # backup dotfiles from the yaml file
  echo " "
  echo "####### backing up .config files"
  cd $HOME
  if [ -f "config_list.txt" ]; then
    echo "####### config_list.txt exists."
    cat config_list.txt | while read line
    do
      cp $HOME/$line $HOME/$line.bak.$(date +%Y-%m-%d-%H:%M:%S)
    done
       echo "cloning the repo"
       config_dir=".config"
       git clone "https://github.com/rvbug/.dotfiles/" "$HOME/.dotfiles"
         for files in "$HOME/.dotfiles/$config_dir"/.*; do
           echo $files
           cp "$files" "$HOME/"
           echo "files are now moved"
         done
        delete the repo
        echo " "
        echo "deleting the repo..."
        rm -rf "$HOME/.dotfiles"
  fi

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

echo " "
echo "data science setup coming soon..."
# ./ds_tools.sh

# # Install Xcode Command Line Tools
echo " "
echo "####### installing the xcode command line tools..."
echo " "

 xcode-select --version > /dev/null
# # echo "$?"
# # check if the above command is successful
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

