export PATH="/opt/homebrew/opt/curl/bin:$PATH"
# PS1='%n:%1~ %# '



export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# Added by Windsurf
export PATH="/Users/rv/.codeium/windsurf/bin:$PATH"

neofetch
# aliases

# general 
alias v="nvim"
alias vim="nvim"
alias projects="cd ~/Documents/projects"
alias proj="cd ~/Documents/projects"
# eza
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-user"
alias la="eza -al --icons"
alias ll="eza -al --icons"
alias lt="eza -laT --icons"
alias lt1="eza -laT --icons"
alias lt2="eza -laT --icons --level=2"

alias cd="z"
alias dot="z ~/.dotfiles && nvim ."

# wezterm
alias wez="nvim ~/.config/wezterm/wezterm.lua"
# zsh
alias zsh="nvim ~/.zshrc"
alias zs="source ~/.zshrc"

# tmux
alias t="tmux"

# aerospace & sketchybar
alias aero="nvim ~/.config/aerospace/aerospace.toml"
alias sbar="cd ~/.config/sketchybar && nvim sketchybarrc"
alias aerolist="aerospace list-apps"
alias sbar-start="brew services start sketchybar"
alias sbar-reload="sketchybar --reload"


# export pytorch for rust
export LIBTORCH=/Users/rv/Documents/projects/libtorch
export DYLD_LIBRARY_PATH=$LIBTORCH/lib
export LIBRARY_PATH=$LIBTORCH/lib
export LD_LIBRARY_PATH=${LIBTORCH}/lib
#export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
#export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
# LIBTORCH_INCLUDE must contain `include` directory.
export LIBTORCH_INCLUDE=$LIBTORCH
# LIBTORCH_LIB must contain `lib` directory.
export LIBTORCH_LIB=$LIBTORCH

echo " "
echo " "
echo " ######## "
alias
echo " ######## "

# bat & theme

export BAT_THEME=tokyonight_night
# after adding a theme to bat
alias bat-rebuild="bat cache --build"
alias cat="bat"


# ----------- fzf previews

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}
# ----------- fzf previews

alias man="tldr"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(fzf --zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

#export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/Library/Application Support/reflex/bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
