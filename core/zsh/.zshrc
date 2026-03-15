# --- 1. Environment & Path ---
export PATH="/opt/homebrew/bin:/opt/homebrew/opt/curl/bin:/opt/homebrew/opt/llvm/bin:$PATH"

# libtorch (Keep for Rustimate release safety)
export LIBTORCH=$HOME/Documents/projects/libtorch
export DYLD_LIBRARY_PATH=$LIBTORCH/lib:$DYLD_LIBRARY_PATH
export LIBRARY_PATH=$LIBTORCH/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$LIBTORCH/lib:$LD_LIBRARY_PATH
export LIBTORCH_INCLUDE=$LIBTORCH
export LIBTORCH_LIB=$LIBTORCH

# --- 2. Native Prompt Setup ---
setopt prompt_subst
autoload -Uz vcs_info

# Combined precmd for Git and CIOP Logging
precmd() {
  vcs_info
  local RET=$?
  local TS=$(date -Iseconds)
  local CMD=$(fc -ln -1)
  local CMD_B64=$(printf "%s" "$CMD" | base64 | tr -d '\n')
  printf "%s\t%s\t%s\t%s\n" "$TS" "$PWD" "$RET" "$CMD_B64" >> ~/.cli_command_buffer
}

# Style: on  branch
zstyle ':vcs_info:git:*' formats 'on %F{magenta} %b%f'

# Minimalist Two-Line Prompt
PROMPT='
%F{cyan}%~%f ${vcs_info_msg_0_}
%F{white}❯%f '

# --- 3. Aliases ---
alias v="nvim"
alias vim="nvim"
alias projects="cd ~/Documents/projects"
alias proj="cd ~/Documents/projects"
alias zsh="nvim ~/.zshrc"
alias zs="source ~/.zshrc"
alias t="tmux"
alias dot="cd ~/.dotfiles && nvim ."

# --- 4. Tools ---
eval "$(fzf --zsh)"
export FZF_CTRL_T_OPTS="--preview 'cat {} | head -50'"

# --- 5. Bandit System ---
bandit-suggest() {
  CMD=$(python3 ~/Documents/projects/ciop/agent/cli_agent/bandit_suggest.py) 
  if [ -n "$CMD" ]; then
    echo "🧠 Bandit suggests: $CMD"
    eval "$CMD"
  fi
}
bindkey -s '^b' 'bandit-suggest\n'

# --- 6. Syntax Highlighting (Load Last) ---
[[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
