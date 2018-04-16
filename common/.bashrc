# Don't overwrite history file
shopt -s histappend
 
# Typing directory name by itself cds to it
shopt -s autocd

# Automatically fix directory name typos when changing directory
shopt -s cdspell

#Automatically expand directory globs and fix directory name typos whilst completing. Note, this works in conjuction with the cdspell option listed above.
shopt -s direxpend dirspell

#Enable the ** globstar recursive pattern in file and directory expansions.
shopt -s globstar

# Enable history expansion with the space key
bind Space:magic-space

# Functions
###########
function http() {
	curl http://httpcode.info/$1
}

function checkip() {
	curl ipecho.net/plain
}

# Autocomplete hostnames from ssh config
complete -o default -o nospace -W "$(/usr/bin/env ruby -ne 'puts $_.split(/[,\s]+/)[1..-1].reject{|host| host.match(/\*|\?/)} if $_.match(/^\s*Host\s+/);' < $HOME/.ssh/config) " scp sftp ssh

# Load some useful files
if [ -f ~/scripts/django_completion ]; then
	. ~/scripts/django_completion
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew-prefix)/etc/bash_completion
fi

if [ -f ~/.shell_prompt.sh ]; then
	. ~/.shell_prompt.sh
fi

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi
