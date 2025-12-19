# Prompt
PS1="%F{cyan}%n%f:%1~%# "

# Enable vim bindings
bindkey -v
bindkey '^R' history-incremental-search-backward

# Aliases
alias ..="cd .."
alias ...="cd ../.."

alias ll="ls -lh --color=auto"
alias la="ls -lha --color=auto"

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

alias gs="git status"
alias gl="git log"
alias glg="git log --graph --oneline --decorate --all"


# Locale
export LANG="en_US.UTF-8"


# Autocomplete
autoload -Uz compinit && compinit

# Cfg editing
alias "cfg=git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Other
export TERM="screen-256color"

# Local sourcing
[ -f $HOME/.localrc ] && . $HOME/.localrc

# OS spesific configuration
case "$(uname)" in
  Darwin)
    [ -f "$HOME/.osrc.darwin" ] && . "$HOME/.osrc.darwin"
    ;;
  Linux)
    [ -f "$HOME/.osrc.linux" ] && . "$HOME/.osrc.linux"
    ;;
esac

