# ##########################################################################
# BASH
# ##########################################################################

# Load up bash config if it's around
[ -f ~/.bash_profile ] && source ~/.bash_profile
[ -f ~/.bashrc ] && source ~/.bashrc

# ##########################################################################
# EXPORT
# ##########################################################################

# Set timezone
export TZ=/usr/share/zoneinfo/US/Pacific

# Show color
export CLICOLOR=1

# Use neo-vim as default text editor
export EDITOR='nvim'

# Add home dir scripts to the path
export PATH=~/bin:$PATH

# Add Homebrew to path
export HOMEBREW_PREFIX=/opt/homebrew
export PATH=$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH

# Add Volta to path
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Add NPM stuff to path
export PATH=$PATH:~/.npm-global/bin

# Add Snap to path
export PATH=$PATH:/snap/bin

# Add Python binaries to path
export PATH=$PATH:~/Library/Python/3.8/bin

# Show password prompt in terminal for GPG
export GPG_TTY=$(tty)

# ##########################################################################
# ALIAS
# ##########################################################################

alias df='df -h'
alias dus='du -hs'
alias l='ls -CF'
alias la='ls -a'
alias ll='ls -l'
alias ls='ls -h'
alias vim='nvim'
alias vi=vim
alias cat=bat

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
#
# Follow "git" install instructions in README:
#   https://github.com/sindresorhus/pure
fpath+=$HOME/.zsh/pure
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
# GOOGLE CLOUD SDK
# ##########################################################################

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/huntca/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/huntca/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/huntca/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/huntca/google-cloud-sdk/completion.zsh.inc'; fi

# ##########################################################################
# EXE
# ##########################################################################

# Start up SSH Agent to avoid constant password prompts
eval $(ssh-agent) &>/dev/null

# Load our fzf config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Activate ZSH syntax highlighting
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Activate rbenv
eval "$(rbenv init -)"

# Always work in a tmux session if tmux is installed
if which tmux 2>&1 >/dev/null; then
  if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
    tmux attach -t hack || tmux new -s hack; exit
  fi
fi
