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

# options for less
LESS=-rFx4

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# Define some colors to use
BOLD="\033[1m"
NORM="\033[0m"

# A more elaborate prompt deserves its own file, otherwise a simple prompt will do
if [ -f ~/.bash_prompt ]; then
  . ~/.bash_prompt
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  PS2=':-( '
fi

# enable color support of the bourne shell
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
  eval "`dircolors -b`"
fi

# Alias definitions are done in a separate file
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Search for an existing ssh agent, connect to the first one we find
__get_agent_pid() {
  pgrep --uid ${USER} ssh-agent | head -n1
}

__get_agent_socket() {
  find /tmp/ssh-* -type s -user ${USER} -name "agent.*" 2> /dev/null
}

if [[ $(__get_agent_pid) -gt 1 ]] &&\
   [[ $(__get_agent_pid) -le $(< /proc/sys/kernel/pid_max) ]] &&\
   [[ -S $(__get_agent_socket) ]]; then
  export SSH_AGENT_PID=$(__get_agent_pid)
  export SSH_AUTH_SOCK=$(__get_agent_socket)
  echo -e "${BOLD}Agent pid ${SSH_AGENT_PID} (reconnected)${NORM}"
else
  echo -ne "${BOLD}"
  eval $(ssh-agent -s)
  echo -ne "${NORM}"
fi

# set proxy if necessary
if [ -f ~/.proxy ]; then
  . ~/.proxy
fi
