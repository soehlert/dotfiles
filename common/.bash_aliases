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
