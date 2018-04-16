export TERM=xterm-256color

# History file stuff
# Larger bash history (allow 32³ entries; default is 500)
# Make some commands not show up in history
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL='erasedups:ignoreboth'
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"
shopt -s histappend

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

# Typing directory name by itself cds to it
shopt -s autocd

# Automatically fix directory name typos when changing directory
shopt -s cdspell

#Automatically expand directory globs and fix directory name typos whilst completing. Note, this works in conjuction with the cdspell option listed above.
shopt -s direxpend dirspell

#Enable the ** globstar recursive pattern in file and directory expansions.
shopt -s globstar

# Enable history expansion with the space key
bind Space:magic-space
