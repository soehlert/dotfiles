# Enable aliases to be sudo'ed
alias sudo='sudo '

# Make ls easier to use
alias ls='ls --color --classify --human-readable'
alias ll='ls -l'
alias ll.='ls -la'
alias lls='ls -la --sort=size'
alias llt='ls -la --sort=time'
alias hidden='ls -al | grep "^\."'
alias show_hidden="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Directory backtracking
alias ..='cd ..'
alias ..2='..; ..'
alias ..3='..2; ..'
alias ..4='..3; ..'
alias ..5='..4; ..'

# Confirm unsafe file operations
alias cp='/bin/cp -i'
alias mv='/bin/mv -i'
alias rm='/bin/rm -i'

# Tmux related
alias trw='tmux rename-window'
alias tmux='tmux -2'
