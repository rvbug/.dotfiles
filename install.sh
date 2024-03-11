#!bin/sh

########################################################
# script      : setup.sh
# description : installs the essentials on mac
# author      : rvbug
# date        : 06 Feb 2020 : inital commit
# future      : support for all linux machine  
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


function check_n_install_essentials() {
  # open softwares.yaml file and read the contents
  # install all the softwares mentioned in the file

  list=($(yq '.software-list' softwares.yaml))

  for software in "${list[@]}"; do
    # prints everyting in the list
    # echo $software

    # for each of the software in the list, check if it is already installed using brew list option
    # if not then install it using brew install

    if brew list $software &>/dev/null; then
      echo "$software is already installed"
    else
      echo "Installing $software..."
      # brew install $software
    fi


    # need to add pip and also install the respective python scripts
    # check user input as Y or N if they want to install data science tools

     done

}

# call the function
# check_n_install_essentials

function ds_tools() {

  pip_list=($(yq '.pip-list' softwares.yaml))

  read -p "Do you want to install Data Science tools? (y/n): " choice
    case "$choice" in
      y|Y) echo "setting up cookie-ml repo..."
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

# call the function
ds_tools




# finally messages to the user before starting the script
# show the usage, what happens and how it happens
