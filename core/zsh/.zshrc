export PATH="/opt/homebrew/opt/curl/bin:$PATH"
# PS1='%n:%1~ %# '


eval "$(starship init zsh)"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# Added by Windsurf
export PATH="/Users/rv/.codeium/windsurf/bin:$PATH"

neofetch
# aliases
alias v="nvim"
alias vim="nvim"
alias wez="nvim ~/.config/wezterm/wezterm.lua"
alias zsh="nvim ~/.zshrc"
alias z="source ~/.zshrc"

alias aero="nvim ~/.config/aerospace/aerospace.toml"
alias aerolist="aerospace list-apps"

alias projects="cd ~/Documents/projects"
alias proj="cd ~/Documents/projects"
alias la="ls -al"
alias ll="ls -lrt"
alias t="tmux"
alias dot="cd ~/.dotfiles && nvim ."

echo " "
echo " "
echo " ######## "
alias
echo " ######## "

eval "$(starship init zsh)"
