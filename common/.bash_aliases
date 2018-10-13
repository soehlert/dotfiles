# Enable aliases to be sudo'ed
alias sudo='sudo '

# Shorten up git
alias g='git '

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
