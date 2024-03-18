#!/bin/sh

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
          echo " "
          echo "before starting the installation, checking for python3 and pip installation..."
          echo " " 
          if python3 --version > /dev/null; then
            echo "python3 is already installed..."
            echo " "
            echo "checking for pip3 installation..."
           elif pip3 --version > /dev/null; then
              echo "pip3 is already installed..."
              echo " "
            else
              echo "pip3 is not installed..."
              # exit 0
              echo "installing pip3..."
              dnf install python3-pip -y
            fi

          echo " "
          echo "upgrading pip before installing rest of the tools.."
          python3 -m pip install --upgrade pip

          for pip_list in "${pip_list[@]}"; do
            echo "installing packages using $pip_list"
             #pip install $pip_list
          done
          echo "upgrading pip before installing rest of the tools.."
          python3 -m pip install --upgrade pip

          echo " "
          echo "####### installing yaml parser"
          python3 -m pip install pyyaml


          # for pip_list in "${pip_list[@]}"; do
          #   echo "installing packages using $pip_list"
          #    pip install $pip_list
          # done
          cd $HOME
          # clone the cookie-ml repo
          git clone https://github.com/rvbug/cookie-ml.git $HOME/cookie-ml 
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

          # check if virtualenv is active
          echo " "
          echo " "
          echo "####### checking if virtualenv is active..."
          
          env | grep "VIRTUAL_ENV" | grep venv
          if [ $? -ne 0 ]; then
            echo " "
            echo "virtualenv is not active..."
            echo " "
            echo "activating the venv..."
            source venv/bin/activate
          else
            echo " "
            echo "virtualenv is active..."
            echo "continuing the installation..."
          fi

          echo " "
          echo " "

          # installing the necessary packages
          # open softwares.yaml file and read the contents
          # install all the softwares mentioned under pip
          echo " "
          echo "upgrading pip before installing rest of the tools.."
          python3 -m pip install --upgrade pip

          for pip_list in "${pip_list[@]}"; do
            echo "installing packages using $pip_list"
             pip install $pip_list
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

