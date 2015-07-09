export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# Link Homebrew casks in `/Applications` rather than `~/Applications`
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Laptop aliases
alias scphome='scp -i ~/.ssh/server'
alias trw='tmux rename-window'
alias tmux='tmux -2'
alias ncsa_build='docker run -v /Users/soehlert/projects/packages:/packages -v /Users/soehlert/projects/build_packages:/build_stuff --rm -t -i ncsa_builder'

# Show/hide hidden files in Finder
alias show_hidden="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Autocomplete hostnames from ssh config
complete -o default -o nospace -W "$(/usr/bin/env ruby -ne 'puts $_.split(/[,\s]+/)[1..-1].reject{|host| host.match(/\*|\?/)} if $_.match(/^\s*Host\s+/);' < $HOME/.ssh/config)" scp sftp ssh

# virtualenvs
#export WORKON_HOME=~/.virtualenvs
#source /usr/local/bin/virtualenvwrapper.sh

# start ssh agent and add relevant keys
# start agent and set environment variables, if needed
agent_started=0
if ! env | grep -q SSH_AGENT_PID >/dev/null;
then
  echo "Starting ssh agent"
  eval $(ssh-agent -s)
  ssh-add ~/.ssh/bitbucket
  agent_started=1
fi

# ssh become a function, adding identity to agent when needed
ssh() {
  if ! ssh-add -l >/dev/null 2>-; then
    ssh-add ~/.ssh/id_rsa
    ssh-add ~/.ssh/soehlert_ocean
  fi
  /usr/bin/ssh "$@"
}
export -f ssh

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
