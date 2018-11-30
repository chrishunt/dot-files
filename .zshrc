# ##########################################################################
# EXPORT
# ##########################################################################

# Show color
export CLICOLOR=1

# Use VIM as default text editor
export EDITOR='mvim -v'

# PATH for MySQL
export PATH=/usr/local/mysql/bin:$PATH

# PATH for MongoDB
export PATH=/Applications/mongodb-osx-x86_64-2.0.0/bin:$PATH

# PATH for QT5.5 libraries (needed for Capybara gem)
export PATH=/usr/local/opt/qt@5.5/bin:$PATH

# Add node binaries to path
export PATH=/usr/local/share/npm/bin:$PATH

# Add home dir scripts to the path
export PATH=~/bin:$PATH

# ##########################################################################
# ALIAS
# ##########################################################################

alias df='df -h'
alias dus='du -hs'
alias l='ls -CF'
alias la='ls -a'
alias ll='ls -l'
alias ls='ls -h'
alias lt='ls -ltr'
alias tmux-pbcopy="tmux saveb -|pbcopy"
alias tmux="TERM=screen-256color-bce tmux"
alias vim='mvim -v'
alias vi=vim

# Ruby
alias be='bundle exec'
alias rspec='rspec --color'

# Git
alias g='git s'
alias gap='git ap'
alias gd='git d'
alias gds='git ds'
alias gl='git l'
alias gs='git s'
alias gaa='git aa'
alias gc='git c'
alias gcm='git commit -m'

# ##########################################################################
# CONFIG
# ##########################################################################

# Disable auto-correct
unsetopt correct_all

# Show pure prompt
autoload -U promptinit; promptinit
prompt pure

# Key bindings, for all options see docs:
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
bindkey '^r' history-incremental-search-backward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^k' kill-line
bindkey '^l' clear-screen
bindkey -v

# ##########################################################################
# EXE
# ##########################################################################

# Load up correct ruby version
eval "$(rbenv init -)"

# Load up ssh keys
# ssh-add -A &> /dev/null

# Always work in a tmux session if tmux is installed
if which tmux 2>&1 >/dev/null; then
  if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
    tmux attach -t hack || tmux new -s hack; exit
  fi
fi
