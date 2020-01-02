# Make sure we use homebrew bash
SHELL="/usr/local/bin/bash"

# Typing directory name by itself cds to it
shopt -s autocd

# Automatically fix directory name typos when changing directory
shopt -s cdspell

# Attempts to save all lines of a multiple-line command in the same history entry. This allows easy re-editing of multi-line commands.
shopt -s cmdhist

# Automatically expand directory globs and fix directory name typos whilst completing. Note, this works in conjuction with the cdspell option listed above.
shopt -s direxpand dirspell

# Allow tab completion of hidden files
shopt -s dotglob

# Expand aliases
shopt -s expand_aliases

# Enable the ** globstar recursive pattern in file and directory expansions.
shopt -s globstar

# Don't overwrite history file
shopt -s histappend

# Case insensitive globbing
shopt -s nocaseglob

# Enable history expansion with the space key
bind Space:magic-space

# Enable zsh like tab completion
bind 'TAB:menu-complete'

# Functions
###########
function bins() {
  alias | awk '{print $2}' | cut -d '=' -f1
  declare -F | grep -v bins | awk '{print $3}' | grep '\b[a-z]+\b'
}

function blog() {
  hugo new --kind post-bundle "posts/$1"
}

# Fuzzy find a file, with colorful preview, then once selected edit it in your preferred editor.
function fzf_find_edit() {
  local file=$(
    fzf --no-multi --preview 'bat --color=always --line-range :500 {}'
    )
   if [[ -n $file ]]; then
     $EDITOR $file
   fi
}

# Fuzzy find a file, with colorful preview, that contains the supplied term, then once selected edit it in your preferred editor.
# Note, if your EDITOR is Vim or Neovim then you will be automatically scrolled to the selected line.
function fzf_grep_edit(){
    if [[ $# == 0 ]]; then
        echo 'Error: search term was not provided.'
        return
    fi
    local match=$(
      rg --line-number "$1" |
        fzf --no-multi --delimiter : \
            --preview "bat --color=always --line-range {2}: {1}"
      )
    local file=$(echo "$match" | cut -d':' -f1)
    if [[ -n $file ]]; then
        $EDITOR $file +$(echo "$match" | cut -d':' -f2)
    fi
}

# Fuzzy find a process or group of processes and SIGKILL them
# Multi selection using TAB key
function fzf_kill() {
    local pids=$(
      ps -f -u $USER | sed 1d | fzf --multi | tr -s [:blank:] | cut -d' ' -f3
      )
    if [[ -n $pids ]]; then
        echo "$pids" | xargs kill -9 "$@"
    fi
}

# Selectively add fuzzy found files for committing
function fzf_git_add() {
    local files=$(git ls-files --modified | fzf --ansi)
    if [[ -n $files ]]; then
        git add --verbose $files
    fi
}

# A fancy compact git log list filtered with fzf; includes preview of changes
function fzf_git_log() {
    local commits=$(
      git ll --color=always "$@" |
        fzf --ansi --no-sort --height 100% \
            --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                       xargs -I@ sh -c 'git show --color=always @'"
      )
    if [[ -n $commits ]]; then
        local hashes=$(printf "$commits" | cut -d' ' -f2 | tr '\n' ' ')
        git show $hashes
    fi
}

function http() {
	curl "http://httpcode.info/$1"
}

# Call from a local repo to open the repository on github/bitbucket in browser
# Modified version of https://github.com/zeke/ghwd
repo() {
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
isup() {
	local uri=$1

	if curl -s --head  --request GET "$uri" | grep "200 OK" > /dev/null ; then
		echo "$uri is down"
	else
		echo "$uri is up"
	fi
}

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
getcertnames() {
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

# Query Wikipedia via console over DNS
mwiki() {
	dig +short txt "$*".wp.dg.cx
}

# Create a new directory and enter it
mkd() {
	mkdir -p "$@"
	cd "$@" || exit
}

# Make a temporary directory and enter it
tmpd() {
	local dir
	if [ $# -eq 0 ]; then
		dir=$(mktemp -d)
	else
		dir=$(mktemp -d -t "${1}.XXXXXXXXXX")
	fi
	cd "$dir" || exit
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

# shellcheck source=/dev/null
if [ -f ~/.fzf.bash ]; then
  . ~/.fzf.bash
fi
[ -f ~/.git-completion.bash ] && . ~/.git-completion.bash
