# .profile

# Print all colors
function print_colors {
  for i in {0..255} ; do
    printf "\x1b[38;5;${i}mcolour${i}\n"
  done
}

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
export PS1="\[\033[0;35m\]\\$\[\033[0;33m\] \w\[\033[0;38m\]\$(parse_git_branch)\[\033[00m\]: "

# Add color to terminal
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

# Load correct libraries for MySQL
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib

# PATH for FLEX SDK
export PATH=$PATH:/Applications/flex_sdk_4.1/bin

# PATH for MySQL
export PATH=/usr/local/mysql/bin:$PATH

# PATH for MongoDB
export PATH=/Applications/mongodb-osx-x86_64-2.0.0/bin:$PATH

# Set /usr/local/bin before /usr/bin for Homebrew
export PATH=/usr/local/bin:$PATH

# Helpful paths
export SVN=~/Dropbox/Progeny/coffee-svn/Development

# Aliases
alias colors=print_colors
alias grep='grep --color=auto'
alias dus='du -hs'
alias df='df -h'

alias ls='ls -h'
alias ll='ls -l'
alias la='ls -a'
alias l='ls -CF'
alias lt='ls -ltr'

alias dunnet='emacs -batch -l dunnet'
alias vim='mvim -v'
alias vi=vim
alias tmux="TERM=screen-256color-bce tmux"

# Rails helpers
alias be='bundle exec'
alias rspec='rspec --color'
alias openoffice="/Applications/OpenOffice.org.app/Contents/MacOS/soffice.bin -headless -nofirststartwizard -accept='socket,host=localhost,port=8100;urp;StarOffice.Service'"

# Load RVM environment
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
