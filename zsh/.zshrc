# enable brew shell
eval "$(/opt/homebrew/bin/brew shellenv)"

# Random options
setopt NO_BEEP

NEWLINE=$'\n'
PS1="%B%F{green}%n@%M%F{red} %~%f%b${NEWLINE}$ "

# History
HISTSIZE=1000
SAVEHIST=5000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY
setopt sharehistory
setopt INC_APPEND_HISTORY

# Read aliases from external file
if [[ -r ~/.dotfiles/zsh/.aliasrc ]]; then
  source ~/.dotfiles/zsh/.aliasrc
fi

# Enable reverse history search
bindkey "^R" history-incremental-search-backward

# Remove mode switching delay.
KEYTIMEOUT=1

bindkey "^?" backward-delete-char

# Use beam shape cursor on startup.
echo -ne '\e[5 q'
# Use beam shape cursor for each new prompt.
preexec() {
  echo -ne '\e[5 q'
}

export PATH=/usr/local/bin:$PATH

# enable UV
source "$HOME/.local/bin/env"
