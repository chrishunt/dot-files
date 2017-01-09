# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="chris"

# Disable weekly update checks
DISABLE_AUTO_UPDATE="true"

# Disable auto-setting of terminal title
DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? Plugins can be found in:
#   ~/.oh-my-zsh/plugins/*
#
# Custom plugins may be added to:
#   ~/.oh-my-zsh/custom/plugins/
#
# Example format:
#   plugins=(rails git textmate ruby)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Disable auto-correct
unsetopt correct_all

# Load up chruby, auto-load ruby version, and set default
source /usr/local/opt/chruby/share/chruby/chruby.sh
chruby ruby-2.3

# Load up rbenv?
eval "$(rbenv init -)"

# Load up ssh keys
ssh-add -A &> /dev/null

# Always work in a tmux session if tmux is installed
if which tmux 2>&1 >/dev/null; then
  if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
    tmux attach -t hack || tmux new -s hack; exit
  fi
fi
