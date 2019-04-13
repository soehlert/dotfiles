# Load useful files
###################
# shellcheck source=/dev/null
. ~/.profile
# shellcheck source=/dev/null
. ~/.bashrc
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'

export WORKON_HOME=~/.envs
export PYENV_VIRTUALENVWRAPPER_PREFER_PYENV="true"
if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\n; fi
pyenv virtualenvwrapper_lazy
eval "$(jump shell --bind=c)"
