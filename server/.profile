# extras
source ~/scripts/django_completion

export PYTHONPATH=/Users/soehlert/repos/ansible/lib:
export MANPATH=/Users/soehlert/repos/ansible/docs/man:

# Laptop aliases
alias trw='tmux rename-window'
alias tmux='tmux -2'
alias ncsa_build='docker run -v /Users/soehlert/projects/packages:/packages -v /Users/soehlert/projects/build_packages:/build_stuff --rm -t -i ncsa_builder'
# Show/hide hidden files in Finder
alias show_hidden="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
# Enable aliases to be sudo’ed
alias sudo='sudo '
