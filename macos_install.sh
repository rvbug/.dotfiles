#!bin/sh

########################################################
# script      : macos_install.sh
# description : installs the essentials on mac
# author      : rvbug
# date        : 06 Feb 2017 : inital commit 
########################################################


echo "calling macos_install.sh script"

# Install Xcode Command Line Tools
xcode-select --install
echo "$?"

# check if the above command is successful
if [ $? -eq 0 ]; then
  echo "Xcode Command Line Tools installed successfully"
else
  echo "Xcode Command Line Tools installation failed, please set it up manually"
  echo "continuing with other installation"
fi


# installating some essential softwares

echo "check if homebrew is already installed"

if command -v brew &>/dev/null; then
  echo "Homebrew already installed"
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "##### Installing homebrew..."
fi

# for this script to work, we need a yaml processor

echo "check if yq is already installed"
if command -v yq &>/dev/null; then
  echo "yq already installed"
else
  echo "##### Installing yq..."
  brew install yq
fi


# let us use a function to now install the other softwarres

function check_n_install_essentials() {
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



