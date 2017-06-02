# This should be useful on every host I have
export PATH=~/scripts/:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:~/.local/bin:~/bin:/opt/local/bin:~/.local/bin

# Shell opts
#############
shopt -s cdspell
shopt -s nocaseglob

# ALIASES
#############
alias ll='ls -al'
alias hidden='ls -al | grep "^\."'

# FUNCTIONS
#############
# Super useful Docker container oneshots.
# Usage: dockrun, or dockrun [centos7|fedora24|debian8|ubuntu1404|etc.]
dockrun() {
  docker run -it geerlingguy/docker-"${1:-ubuntu1604}"-ansible /bin/bash
}

function http() {
  curl http://httpcode.info/$1
}

function checkip(){
  curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'
}

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Autocomplete hostnames from ssh config
complete -o default -o nospace -W "$(/usr/bin/env ruby -ne 'puts $_.split(/[,\s]+/)[1..-1].reject{|host| host.match(/\*|\?/)} if $_.match(/^\s*Host\s+/);' < $HOME/.ssh/config) " scp sftp ssh

# Set up terminal for git
PS1='[\u@\h: \w$(parse_git_branch)]\$ '

# source ~/.profile, if available
if [ -f ~/.profile ]; then
  . ~/.profile
fi

# source ~/scripts/django_completion
if [ -f ~/scripts/django_completion ]; then
  . ~/scripts/django_completion
fi

if [ -f ~/projects/bash-wakatime/bash-wakatime.sh ]; then
  . ~/projects/bash-wakatime/bash-wakatime.sh
fi

if [ -f ~/.bash_work ]; then
  . ~/.bash_work
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
