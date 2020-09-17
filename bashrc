# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
elif [ -f /etc/bash.bashrc ]; then
  . /etc/bash.bashrc
fi

# Enable tab completion in shell
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# File-creation mode mask.  No core dumps.
umask 007
ulimit -c 0

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# don't put duplicate lines or those starting with a space in the history
# and erase previously saved lines matching the current line
HISTCONTROL=ignoreboth:erasedups
# Mark the history with timestamps
HISTTIMEFORMAT="%F %T %Z | "
# Number of history lines saved (default 500)
HISTSIZE=1000

# set the default editor
export EDITOR=vim

# Uncomment the following line if you don't like systemctl's auto-paging feature:
export SYSTEMD_PAGER=

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# check for likely color support of the terminal
case "$TERM" in
  xterm-*color) color_prompt=yes;;
esac

if [ -n "$color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    # Define some colors to use
    BOLD="\033[1m"
    NORM="\033[0m"
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  if [ -f ~/.bash_prompt ]; then
    . ~/.bash_prompt
  else
#   PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='${debian_chroot:+($debian_chroot)}\[\033[00;32m\]\u\[\033[00m\]@\[\033[01;32m\]\h\[\033[00m\]:\[\033[00m\]\w \[\033[01;34m\]> \[\033[00m\]'
  fi
  PS2=':-( '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  PS2=':-( '
fi

# enable color support of the bourne shell
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
  eval "`dircolors -b`"
fi

unset color_prompt

# Alias definitions are done in a separate file
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Search for an existing ssh agent, connect to the first one we find
get_agent_pid() {
  pgrep --uid ${USER} ssh-agent | head -n1
}

get_agent_socket() {
  find /tmp/ssh-* -type s -user ${USER} -name "agent.*" 2> /dev/null
}

if [[ $(get_agent_pid) -gt 1 ]] && [[ $(get_agent_pid) -le $(< /proc/sys/kernel/pid_max) ]] && [[ -S $(get_agent_socket) ]]
then
  export SSH_AGENT_PID=$(get_agent_pid)
  export SSH_AUTH_SOCK=$(get_agent_socket)
  echo "Agent pid ${SSH_AGENT_PID} (reconnected)"
else
  eval $(ssh-agent -s)
fi

# set proxy if necessary
if [ -f ~/.proxy ]; then
  . ~/.proxy
fi
