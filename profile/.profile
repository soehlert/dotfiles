export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# Link Homebrew casks in `/Applications` rather than `~/Applications`
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Laptop aliases
alias scphome='scp -i ~/.ssh/server'
alias trw='tmux rename-window'
alias tmux='tmux -2'
