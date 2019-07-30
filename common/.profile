# Exports
#########
export PATH=/usr/local/Cellar/openssl/1.0.2o_2/bin:/usr/local/bin:/usr/local/Caskroom:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:~/bin:/opt/local/bin:~/.local/bin:~/scripts:~/go/bin
export TERM=xterm-256color
# History file stuff
# Larger bash history (allow 32³ entries; default is 500)
# Make some commands not show up in history
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL='erasedups:ignoreboth'
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Highlight section titles in manual pages
export LESS_TERMCAP_md="$ORANGE"
# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto"

# Prefer US English and use UTF-8
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# No brew analytics
export HOMEBREW_NO_ANALYTICS=1

# Use fd for fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_ALT_C_COMMAND='fd --type d . --color=never'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"

# Tmuxp
eval "$(_TMUXP_COMPLETE=source tmuxp)"
