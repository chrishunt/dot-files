# .profile

################
# Functions
################

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

################
# Environment
################

# Set 256 color term
export TERM=xterm-256color

# Add color to terminal
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

# Make prompt pretty, showing current Git branch
export PS1="\[\033[0;35m\]\\$\[\033[0;33m\] \w\[\033[0;38m\]\$(parse_git_branch)\[\033[00m\]: "

# Load correct libraries for MySQL
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib

# PATH for MySQL
export PATH=/usr/local/mysql/bin:$PATH

# PATH for MongoDB
export PATH=/Applications/mongodb-osx-x86_64-2.0.0/bin:$PATH

# Set /usr/local/bin before /usr/bin for Homebrew
export PATH=/usr/local/bin:$PATH

################
# Aliases
################

alias grep='grep --color=auto'
alias dus='du -hs'
alias df='df -h'
alias ls='ls -h'
alias ll='ls -l'
alias la='ls -a'
alias l='ls -CF'
alias lt='ls -ltr'
alias vim='mvim -v'
alias vi=vim
alias dunnet='emacs -batch -l dunnet'
alias tmux="TERM=screen-256color-bce tmux"
alias md5sum='md5 -r'
alias be='bundle exec'
alias rspec='rspec --color'

################
# Path Aliases
################

alias wb='cd /Users/huntca/workspace/weatherbill'
alias tw='cd /Users/huntca/workspace/twain'

################
# Climate.com
################

alias vpn='sudo openconnect --script /usr/local/etc/vpnc/vpnc-script vpn.climate.com'
alias wbgo='/Users/huntca/workspace/weatherbill/tools/wbgo'
alias openoffice="/Applications/OpenOffice.org.app/Contents/MacOS/soffice.bin -headless -nofirststartwizard -accept='socket,host=localhost,port=8100;urp;StarOffice.Service'"

alias tunnel_refresh='wbgo -u root --refresh'
alias tunnel_dynamo='wbgo -u root -y --tunnel http: dynamo'
alias tunnel_metro='wbgo -u root -y --tunnel http: metro'
alias tunnel_ministry='wbgo -u root -y --tunnel http: ministry'
alias tunnel_nostra='wbgo -u root -y --tunnel http: nostra'
alias tunnel_varnish='wbgo -u root -y --tunnel http: varnish'
alias tunnel_shelf='wbgo -u root --tunnel http: shelf'
alias tunnel_wfe='wbgo -u root --tunnel http: wfe'
alias tunnel_kill="ps -ef | grep 'ssh -f' | grep -v 'grep' | awk '{print \$2}' | xargs kill -9"
alias tunnel_all='tunnel_kill; tunnel_refresh && tunnel_ministry --balancer && tunnel_nostra --balancer && tunnel_varnish --balancer && tunnel_metro --balancer && tunnel_dynamo --balancer && tunnel_wfe --balancer'
alias tunnel_all_qa='killall ssh; tunnel_refresh -eqa1 && tunnel_nostra --balancer -eqa1 && tunnel_ministry --balancer -eqa1 && tunnel_varnish --balancer -eqa1 && tunnel_dynamo --balancer -eqa1 && tunnel_metro --balancer -eqa1'

# Post gerrit code reviews
postgreview () {
  if [ -z "$1" -o -z "$2" ]; then
    echo "usage: postgreview <repository> <branch>"
  else
    if [ -z "$3" ]; then
      SHA=HEAD
    else
      SHA="$3"
    fi
    echo "submitting review for branch $2 ($SHA) in repo $1"
    git push ssh://chunt@zeus:29418/$1 $SHA:refs/for/$2;
  fi
}

################
# RVM
################
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
