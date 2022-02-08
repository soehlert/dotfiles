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

export HOMEBREW_GITHUB_API_TOKEN=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
