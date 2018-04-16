export PATH=/home/soehlert/projects/ansible/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/soehlert/.local/bin:/home/soehlert/bin:/opt/local/bin:~/.local/bin
export PYTHONPATH=/home/soehlert/projects/ansible/lib:
export MANPATH=/home/soehlert/projects/ansible/docs/man:
export ANSIBLE_INVENTORY=~/projects/ansible/ansible_hosts
export ANSIBLE_HOST_KEY_CHECKING=False
export EDITOR=vim

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

# source ~/.profile, if available
if [[ -r ~/.profile ]]; then
  . ~/.profile
fi

