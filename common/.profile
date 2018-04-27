# Exports
#########
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/Caskroom:~/bin:/opt/local/bin:~/.local/bin:~/scripts:~/projects/ansible/bin
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

# Only show the current directory's name in the tab
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

# No brew analytics
export HOMEBREW_NO_ANALYTICS=1
