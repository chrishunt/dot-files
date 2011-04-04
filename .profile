# .profile

# Used to show status of current Git repository
function parse_git_deleted {
  [[ $(git status 2> /dev/null | grep deleted:) != "" ]] && echo "-"
}
function parse_git_added {
  [[ $(git status 2> /dev/null | grep "Untracked files:") != "" ]] && echo '+'
}
function parse_git_modified {
  [[ $(git status 2> /dev/null | grep modified:) != "" ]] && echo "*"
}
function parse_git_dirty {
  echo "$(parse_git_added)$(parse_git_modified)$(parse_git_deleted)"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}

# Make prompt pretty, showing current Git branch
export PS1="\[\033[0;35m\]\h\[\033[0;33m\] \w\[\033[0;37m\]\$(parse_git_branch)\[\033[00m\]: "

# Add color to terminal
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

# Load correct libraries for MySQL
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib

# PATH for FLEX SDK
export PATH=$PATH:/Applications/flex_sdk_4.1/bin

# Helpful paths
export SVN=~/Dropbox/Progeny/coffee-svn/Development

# Load RVM environment
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

# Aliases
alias grep='grep --color=auto'
alias dus='du -hs'
alias df='df -h'

alias ls='ls -h'
alias ll='ls -l'
alias la='ls -a'
alias l='ls -CF'
alias lt='ls -ltr'

alias dunnet='emacs -batch -l dunnet'

# Open everything with MacVim
alias vi='mvim'

# Show color with rspec
alias rspec='rspec --color'
