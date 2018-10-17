# Enable aliases to be sudo'ed
alias sudo='sudo '

# Shortcuts
alias g="git"
alias h="history"
alias dl="cd ~/Downloads"

# IP addresses
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="sudo ifconfig | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias ips="sudo ifconfig -a | grep -o 'inet6\\? \\(addr:\\)\\?\\s\\?\\(\\(\\([0-9]\\+\\.\\)\\{3\\}[0-9]\\+\\)\\|[a-fA-F0-9:]\\+\\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Gitleaks
alias gl='docker run --rm --name=gitleaks zricethezav/gitleaks --help'

# Colorize grep
alias grep='grep --color -E'

# Make ls easier to use
alias ls='/bin/ls -G'
alias ll='/bin/ls -lG'
alias ll.='/bin/ls -laG'
alias lls='/bin/ls -laG --sort=size'
alias llt='/bin/ls -laG --sort=time'
alias hidden='/bin/ls -laG | grep "^\."'
alias show_hidden="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Directory backtracking
alias ..='cd ..'
alias ..2='..; ..'
alias ..3='..2; ..'
alias ..4='..3; ..'
alias ..5='..4; ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Confirm unsafe file operations
alias cp='/bin/cp -i'
alias mv='/bin/mv -i'
alias rm='/bin/rm -i'

# Tmux related
#alias trw='tmux rename-window'
#if [[ "$( uname -s )" == Darwin ]]; then
#	alias tmux='tmux -2 new-session /usr/local/bin/bash'
#else
#	alias tmux='tmux -2'
#fi

alias tmux='tmux -2'
