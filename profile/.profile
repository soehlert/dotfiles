export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# Link Homebrew casks in `/Applications` rather than `~/Applications`
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Laptop aliases
alias scphome='scp -i ~/.ssh/server'
alias trw='tmux rename-window'
alias tmux='tmux -2'
alias ncsa_build='docker run -v `pwd`:/packages -v /Users/soehlert/projects/build_packages:/build_stuff --rm -t -i ncsa_builder'

# Show/hide hidden files in Finder
alias show_hidden="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Autocomplete hostnames from ssh config
complete -o default -o nospace -W "$(/usr/bin/env ruby -ne 'puts $_.split(/[,\s]+/)[1..-1].reject{|host| host.match(/\*|\?/)} if $_.match(/^\s*Host\s+/);' < $HOME/.ssh/config)" scp sftp ssh

# virtualenvs
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
