##############
# Completions
##############

# Use the more powerful zsh completions
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# Add homebrew completions 
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# SSH Completions
alias s='ssh'
# Highlight the current autocomplete option
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Better SSH/Rsync/SCP Autocomplete
zstyle ':completion:*:(scp|rsync):*' tag-order ' hosts:-ipaddr:ip\ address hosts:-host:host files'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# Allow for autocomplete to be case insensitive
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
 '+l:|?=** r:|?=**'

# More powerful renaming
autoload -U zm

###########
# zplug
###########

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# Unify with tmux and vim
zplug "MikeDacre/tmux-zsh-vim-titles"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# Git fuzzy find stuff
zplug "wfxr/forgit"
zplug "zlsun/solarized-man"
# Set sane tab titles
zplug "trystan2k/zsh-tab-title"
# Strip leading dollar sign when pasting commands
zplug "zpm-zsh/undollar"
# Open vim to a specific line in a file with `vim filename:123`
zplug "nviennot/zsh-vim-plugin"
# Remind me of my aliases when I should have used one
zplug "djui/alias-tips"
# Automatically source venv when in a python project dir
zplug "MichaelAquilina/zsh-autoswitch-virtualenv"

zplug load

############
# Auto venvs
############
export AUTOSWTICH_VIRTUAL_ENV_DIR="$HOME/.envs"
export AUTOSWITCH_FILE=".autoswitch"

############
# FZF
############

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

############
# TMUX
############

# Start tmux or connect to it automatically
HOSTNAME=$(hostname -s)

# if [ -z "$TMUX" ]
# then
# tmux new-session -A -s $HOSTNAME
# exit
# fi

############
# History
############

HISTFILE=$HOME/.zsh_history
HISTSIZE=2000
SAVEHIST=2000

# Add ot history as it happens; dont wait for shell exit
setopt INC_APPEND_HISTORY
# Shared history file for all sessions
setopt SHARE_HISTORY
# Also show time started and time run
setopt EXTENDED_HISTORY

# HIST_IGNORE_ALL_DUPS simply
# removes copies of lines still in the history list, keeping the newly
# added one, while HIST_EXPIRE_DUPS_FIRST is more subtle: it
# preferentially removes duplicates when the history fills up, but does
# nothing until then. HIST_SAVE_NO_DUPS means that whatever options are
# set for the current session, the shell is not to save duplicated lines
# more than once; and HIST_FIND_NO_DUPS means that even if duplicate
# lines have been saved, searches backwards with editor commands don’t
# show them more than once.
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS

# So to get round the NO_CLOBBER you can just go back to the previous line and execute it without editing it.
# The second option, HIST_REDUCE_BLANKS, will tidy up the line when it
# is entered into the history by removing any excess blanks that mean
# nothing to the shell. This can also mean that the line becomes a
# duplicate of a previous one even if it would not have been in its
# untidied form. It is smart enough not to remove blanks which are
# important, i.e. are quoted
setopt HIST_ALLOW_CLOBBER
setopt HIST_REDUCE_BLANKS

# Ignore lines prepended with a space
setopt HIST_IGNORE_SPACE
# Don't story history commands
setopt HIST_NO_STORE
# Turn off beep if you've reached the beginning/end of history
setopt NO_HIST_BEEP

###############
# Moving around
###############

# Case insensitive globbing
setopt NO_CASE_GLOB
# Typing directory name by itself cds to it
setopt AUTO_CD
# Setup autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

###########
# Functions
###########
function bins() {
  alias | awk '{print $2}' | cut -d '=' -f1
  declare -F | grep -v bins | awk '{print $3}' | grep '\b[a-z]+\b'
}

function blog() {
  hugo new --kind post-bundle "posts/$1"
}

function http() {
	curl "http://httpcode.info/$1"
}

# Call from a local repo to open the repository on github/bitbucket in browser
# Modified version of https://github.com/zeke/ghwd
function repo() {
	# Figure out github repo base URL
	local base_url
	base_url=$(git config --get remote.origin.url)
	base_url=${base_url%\.git} # remove .git from end of string

	# Fix git@github.com: URLs
	base_url=${base_url//git@github\.com:/https:\/\/github\.com\/}

	# Fix git://github.com URLS
	base_url=${base_url//git:\/\/github\.com/https:\/\/github\.com\/}

	# Fix git@bitbucket.org: URLs
	base_url=${base_url//git@bitbucket.org:/https:\/\/bitbucket\.org\/}

	# Fix git@gitlab.com: URLs
	base_url=${base_url//git@gitlab\.com:/https:\/\/gitlab\.com\/}

	# Validate that this folder is a git folder
	if ! git branch 2>/dev/null 1>&2 ; then
		echo "Not a git repo!"
		exit $?
	fi

	# Find current directory relative to .git parent
	full_path=$(pwd)
	git_base_path=$(cd "./$(git rev-parse --show-cdup)" || exit 1; pwd)
	relative_path=${full_path#$git_base_path} # remove leading git_base_path from working directory

	# If filename argument is present, append it
	if [ "$1" ]; then
		relative_path="$relative_path/$1"
	fi

	# Figure out current git branch
	# git_where=$(command git symbolic-ref -q HEAD || command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null
	git_where=$(command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null

	# Remove cruft from branchname
	branch=${git_where#refs\/heads\/}

	[[ $base_url == *bitbucket* ]] && tree="src" || tree="tree"
	url="$base_url/$tree/$branch$relative_path"


	echo "Calling $(type open) for $url"

	open "$url" &> /dev/null || (echo "Using $(type open) to open URL failed." && exit 1);
}

# check if uri is up
function isup() {
	local uri=$1

	if curl -s --head  --request GET "$uri" | grep "200 OK" > /dev/null ; then
		echo "$uri is down"
	else
		echo "$uri is up"
	fi
}

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames() {
	if [ -z "${1}" ]; then
		echo "ERROR: No domain specified."
		return 1
	fi

	local domain="${1}"
	echo "Testing ${domain}…"
	echo ""; # newline

	local tmp
	tmp=$(echo -e "GET / HTTP/1.0\\nEOT" \
		| openssl s_client -connect "${domain}:443" 2>&1)

	if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
		local certText
		certText=$(echo "${tmp}" \
			| openssl x509 -text -certopt "no_header, no_serial, no_version, \
			no_signame, no_validity, no_issuer, no_pubkey, no_sigdump, no_aux")
		echo "Common Name:"
		echo ""; # newline
		echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//"
		echo ""; # newline
		echo "Subject Alternative Name(s):"
		echo ""; # newline
		echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
			| sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\\n" | tail -n +2
		return 0
	else
		echo "ERROR: Certificate not found."
		return 1
	fi
}

# Create a new directory and enter it
function mkd() {
	mkdir -p "$@"
	cd "$@" || exit
}

# Make a temporary directory and enter it
function tmpd() {
	local dir
	if [ $# -eq 0 ]; then
		dir=$(mktemp -d)
	else
		dir=$(mktemp -d -t "${1}.XXXXXXXXXX")
	fi
	cd "$dir" || exit
}

##########
# Aliases
##########

# Enable aliases to be sudo'ed
alias sudo='sudo '

# Shortcuts
alias h="history"
alias dl="cd ~/Downloads"

# IP addresses
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"
alias pubip2="curl ipinfo.io/ip"
alias localip="sudo ifconfig | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1'"

# Gitleaks
alias gl='docker run --rm --name=gitleaks zricethezav/gitleaks --help'

# Colorize grep
alias grep='rg --color always'

# Make ls easier to use
alias ls='/bin/ls -G'
alias ll='/bin/ls -lG'
alias ll.='/bin/ls -laG'
alias lls='/bin/ls -laG --sort=size'
alias llt='/bin/ls -laG --sort=time'

# File hiding stuff
alias hidden='/bin/ls -laG | grep "^\."'
alias show_hidden="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# System info for macOS
alias sysinfo='neofetch'

# Confirm unsafe file operations
alias cp='/bin/cp -i'
alias mv='/bin/mv -i'
alias rm='/bin/rm -i'

# Tmux related
alias trw='tmux rename-window'
alias tmux='tmux -2'


if [ `id -u` = 0 ]
then
  PROMPT="%{$fg[red]%}%n%{$fg_bold[white]%}@%{$fg_bold[yellow]%}%m %{$fg_bold[green]%}%1~%{$reset_color%} # "
else
	source ~/.promptline.sh
fi
export PATH="/usr/local/sbin:$PATH"
