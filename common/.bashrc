# Currently commented out some shopts because they don't work inside of tmux
# Typing directory name by itself cds to it
#shopt -s autocd

# Don't overwrite history file
shopt -s histappend

# Automatically fix directory name typos when changing directory
shopt -s cdspell

#Automatically expand directory globs and fix directory name typos whilst completing. Note, this works in conjuction with the cdspell option listed above.
#shopt -s direxpand dirspell

# Allow tab completion of hidden files
shopt -s dotglob

#Enable the ** globstar recursive pattern in file and directory expansions.
#shopt -s globstar

# Enable history expansion with the space key
bind Space:magic-space

# Functions
###########
function http() {
	curl "http://httpcode.info/$1"
}

function checkip() {
	curl ipecho.net/plain
}

# Add tab completion for SSH hostnames based on ~/.ssh/config
# ignoring wildcards
[[ -e "$HOME/.ssh/config" ]] && complete -o "default" \
	-o "nospace" \
	-W "$(grep "^Host" ~/.ssh/config | \
	grep -v "[?*]" | cut -d " " -f2 | \
	tr ' ' '\n')" scp sftp ssh

# Load some useful files
# shellcheck source=/dev/null
if [ -f ~/scripts/django_completion ]; then
	. ~/scripts/django_completion
fi

# shellcheck source=/dev/null
if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
	. "$(brew --prefix)/etc/bash_completion"
fi

# shellcheck source=/dev/null
if [ -f ~/.shell_prompt.sh ]; then
	. ~/.shell_prompt.sh
fi

# shellcheck source=/dev/null
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi
