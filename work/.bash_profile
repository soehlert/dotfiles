export PATH=~/projects/ansible/bin:~/scripts/:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:~/.local/bin:~/bin:/opt/local/bin:~/.local/bin
export PYTHONPATH=/home/soehlert/projects/ansible/lib:
export MANPATH=/home/soehlert/projects/ansible/docs/man:
export ANSIBLE_HOST_KEY_CHECKING=False
export EDITOR=vim

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

function checkip(){
  curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'
}

parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
# Set up terminal for git
PS1='[\u@\h: \w$(parse_git_branch)]\$ '

# add epass token if present
if epass-list 2>/dev/null;
then
  eval `ssh-agent`
  epass-add
fi

# source ~/.profile, if available
if [[ -r ~/.profile ]]; then
  . ~/.profile
fi
