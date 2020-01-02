# Load useful files
###################
# shellcheck source=/dev/null
. ~/.profile
# shellcheck source=/dev/null
. ~/.bashrc

source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'

export WORKON_HOME=~/.envs
eval "$(jump shell --bind=c)"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

