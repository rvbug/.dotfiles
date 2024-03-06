# <p align="center"> <bold>.</bold> dotfiles <p>


To manage the .dotfiles

# File and description

Install the following

- To uninstall iterm
- Uninstall oh_my_zsh since it is very bloated for my needs
  
  ```bash
  # backup your existing .zshrc just in case
  $> cp ~/.zshrc ~/.zshrc.backup

  # if you use .bashrc then do the following
  $> cp ~/.bashrc ~/.bashrc.backup

  # proceecd to uninstall oh_my_zsh
  $> uninstall_oh_my_zsh
  ```
  
-  Once .wezterm, copy the following config file from this repo. In future, I will create a script to install it via a script

- Next step, install starship terminal
  ```bash
    brew install starship
  ```
  
- tmux
```bash
  brew install tmux
```


## Jupyter NBEXtension

## Installation 
`pip3 install nbextension`  
`jupyter contrib nbextension install --user`

.jupyter/

## Pipenv 
pip3 install --user pipenv  
- To use  
pipenv shell

## Tensorflow
pipenv install tensorflow-macos

## Pytorch
pip install pytorch

## Tmux
- To be added
