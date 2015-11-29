export PATH=/home/soehlert/projects/ansible/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/soehlert/.local/bin:/home/soehlert/bin:/opt/local/bin/:~/.local/bin
export PYTHONPATH=/home/soehlert/projects/ansible/lib:
export MANPATH=/home/soehlert/projects/ansible/docs/man:
export ANSIBLE_INVENTORY=~/projects/ansible-configs/ansible_hosts
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

# source ~/.profile, if available
if [[ -r ~/.profile ]]; then  
	. ~/.profile
fi

