export TERM=xterm-256color
export PATH=$PATH:/opt/local/bin/:~/.local/bin
export EDITOR=vim
# Prefer US English and use UTF-8
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# History file stuff
# Larger bash history (allow 32³ entries; default is 500)
# Make some commands not show up in history
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Highlight section titles in manual pages
export LESS_TERMCAP_md="$ORANGE"
# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto"

# Shell opts 
#############
shopt -s cdspell
shopt -s nocaseglob

# ALIASES
#############
alias ll='ls -al'
alias hidden='ls -al | grep "^\."'
alias checkip="curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"

# FUNCTIONS
#############
function http() {
    curl http://httpcode.info/$1
}

function ext_ip(){
  curl icanhazip.com
}

parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
# Set up terminal for git
PS1='[\u@\h: \w$(parse_git_branch)]\$ '

# start ssh agent and add relevant keys
# start agent and set environment variables, if needed
#agent_started=0
#if ! env | grep -q SSH_AGENT_PID >/dev/null; then  
#	echo "Starting ssh agent"  
#	eval $(ssh-agent -s)  
#	agent_started=1
#fi

# ssh become a function, adding identity to agent when needed
#ssh() {  
#  if ! ssh-add -l >/dev/null 2>-; then    
#    ssh-add ~/.ssh/id_rsa
#    ssh-add ~/.ssh/bitbucket
#    ssh-add ~/.ssh/soehlert_ocean
#  fi  
#  /usr/bin/ssh "$@"
#}
#export -f ssh

# source ~/.profile, if available
if [[ -r ~/.profile ]]; then  
	. ~/.profile
fi
