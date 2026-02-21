# Path
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$HOME/.local/bin:$HOME/scripts:$HOME/go/bin:$PATH

# History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY

# General options
setopt AUTO_CD
setopt CORRECT
setopt NO_CASE_GLOB
unsetopt BEEP
PROMPT_EOL_MARK=""

export HOMEBREW_NO_ANALYTICS=1
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export MANPAGER="less -X"

# Completion
autoload -Uz compinit && compinit
autoload -U zmv
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Prompt
autoload -Uz promptinit && promptinit

# Plugins (direct source, no plugin manager needed)
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# forgit (installed via brew)
[ -f $(brew --prefix)/share/forgit/forgit.plugin.zsh ] && source $(brew --prefix)/share/forgit/forgit.plugin.zsh

# Better fzf config (adds previews with bat and tree)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_ALT_C_COMMAND='fd --type d . --color=never'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"

# zoxide (replaces autojump)
eval "$(zoxide init zsh)"

# Key bindings
bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# Aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# Functions
function gh-open() {
  git remote -v \
    | awk '/origin.*push/ {print $2}' \
    | sed -E 's|git@github.com:|https://github.com/|' \
    | sed 's|\.git$||' \
    | xargs open
}

function isup() {
  local uri=$1
  if curl -s --head --request GET "$uri" | grep "200 OK" > /dev/null; then
    echo "$uri is up"
  else
    echo "$uri is down"
  fi
}

# Show all CNs and SANs listed in the SSL certificate for a given domain
function getcertnames() {
  if [ -z "${1}" ]; then
    echo "ERROR: No domain specified."
    return 1
  fi

  local domain="${1}"
  echo "Testing ${domain}…"
  echo ""

  local tmp
  tmp=$(echo -e "GET / HTTP/1.0\\nEOT" \
    | openssl s_client -connect "${domain}:443" 2>&1)

  if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
    local certText
    certText=$(echo "${tmp}" \
      | openssl x509 -text -certopt "no_header, no_serial, no_version, \
      no_signame, no_validity, no_issuer, no_pubkey, no_sigdump, no_aux")
    echo "Common Name:"
    echo ""
    echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//"
    echo ""
    echo "Subject Alternative Name(s):"
    echo ""
    echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
      | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\\n" | tail -n +2
    return 0
  else
    echo "ERROR: Certificate not found."
    return 1
  fi
}

# Create a new directory and enter it
function mkd() {
  mkdir -p "$@"
  cd "$@" || exit
}

# Prompt
if [ $(id -u) = 0 ]; then
  # Root prompt - plain and obvious
  PROMPT="%{$fg[red]%}%n%{$fg_bold[white]%}@%{$fg_bold[yellow]%}%m %{$fg_bold[green]%}%1~%{$reset_color%} # "
else
  eval "$(starship init zsh)"
fi
