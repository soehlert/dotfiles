# This all should be useful just for Main hosts
export PYTHONPATH=/Users/soehlert/repos/ansible/lib:
export MANPATH=/Users/soehlert/repos/ansible/docs/man:
export ANSIBLE_HOST_KEY_CHECKING=False
export PATH=~/projects/ansible/bin:~/scripts:/usr/local/Caskroom:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:~/.local/bin:~/bin:/opt/local/bin:~/.local/bin
# Link Homebrew casks in `/Applications` rather than `~/Applications`
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"

# Laptop aliases
alias trw='tmux rename-window'
alias tmux='tmux -2'
alias ncsa_build='docker run -v /Users/soehlert/projects/packages:/packages -v /Users/soehlert/projects/build_packages:/build_stuff --rm -t -i ncsa_builder'
# Show/hide hidden files in Finder
alias show_hidden="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
# Enable aliases to be sudo’ed
alias sudo='sudo '
