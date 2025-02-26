# some ls aliases
alias ls='ls --color=auto --group-directories-first'
alias l='ls -CF1'
alias ll='ls -lhF'
alias la='ls -lhFA'
alias LL='ls -lhFL'
alias lls='ls -lhsF'
alias las='ls -lhsFA'

# other aliases
alias pathping='mtr'
alias dd='dd status=progress'
alias df='df -Th'
alias cd..='cd ..'
alias tree='tree -F'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
#alias reboot-win='sudo grub-reboot "Windows 7 (loader) (on /dev/sda1)"'
#alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias whatismyip='whatismy ip'
alias killdiscord='killall Discord;killall Discord'

# commands that need to be run as root
alias synaptic='sudo synaptic'
alias gparted='sudo gparted'
#alias firewall='sudo firewall'
alias firewall='sudo ufw'
alias ufw='sudo ufw'
alias iftop='sudo iftop'
alias iotop='sudo iotop'
alias shutdown='sudo shutdown -P now'

# "alias" functions

lsusers() {
  local UID_MIN="$(grep -w UID_MIN /etc/login.defs | awk '{ print $2 }')"
  local UID_MAX="$(grep -w UID_MAX /etc/login.defs | awk '{ print $2 }')"
  getent passwd | tr ':' ' ' | awk "\$3 >= ${UID_MIN} && \$3 <= ${UID_MAX} { print \$1,\$3 }"
}

sshkill() {
  for socket in $(find ~/.ssh -type s -user ${USER} ! -name "agent" 2> /dev/null); do
    if [[ -S ${socket} ]]; then
      socket=${socket##*/}  ## strip path
      port=${socket##*:}    ## save port number
      socket=${socket%:*}   ## strip port number
      echo -n "${socket} on port ${port}: "
      ssh -O exit "${socket}" -p "${port}"
    fi
  done
}

update() {
  if [ -f /etc/os-release ]; then
    source /etc/os-release
  else
    echo "Not a supported distribution"
    exit 1
  fi
  case ${ID_LIKE} in
    *debian*)
      sudo apt update && sudo apt -y full-upgrade
      ;;
    *fedora*)
      sudo yum -y update
      ;;
    *)
      echo "Unknown distribution, no idea how to update the system"
      exit 1
      ;;
  esac
}

rr() {
  if [ -f /etc/os-release ]; then
    source /etc/os-release
  else
    echo "Not a supported distribution"
    exit 1
  fi
  case ${ID_LIKE} in
    *debian*)
      if [ -f /run/reboot-required ]; then
        if [ -f /run/reboot-required.pkgs ]; then
          echo "The following packages require a system restart:"
          cat /run/reboot-required.pkgs
        else
          echo "A system restart is required."
        fi
      fi
      ;;
    *fedora*)
      if [ -x /usr/bin/needs-restarting ]; then
        /usr/bin/needs-restarting -r
      else
        echo "Command '/usr/bin/needs-restarting' not available"
        exit 1
      fi
      ;;
    *)
      echo "Unknown distribution, no idea how to check if a reboot of the system is required"
      exit 1
      ;;
  esac
}

vnstat() {
  if [[ $@ == "-a" ]]; then
    command vnstat; vnstat --top10
  else
    command vnstat "$@"
  fi
}

ipinfo() {
  if [[ "${1}" == *help ]] || [[ "${1}" == *usage ]] || [[ $# -gt 2 ]]; then
    echo -e "${BOLD}Usage:${NORM}   ipinfo [ip_address] [response_filter]\n${BOLD}Example:${NORM} ipinfo 123.45.67.89 loc\n${BOLD}Filters:${NORM} ip,hostname,city,region,country,loc,org,postal,timezone"
  else
    local IFS='/'"${IFS}"
    curl -q https://ipinfo.io/"${*}"
  fi
}

httpbin() {
  if [ $# -eq 0 ]; then
    echo -e "Query for ${BOLD}ip${NORM}, ${BOLD}user-agent${NORM}, ${BOLD}uuid${NORM} or ${BOLD}headers${NORM}, amongst\nother things. See ${BOLD}https://httpbin.org/${NORM} for more information."
  else
    for i in "$@"; do
      curl -q https://httpbin.org/$i
    done
  fi
}

whatismy() {
  if [ $# -eq 0 ]; then
    echo -e "Query for ${BOLD}ip${NORM}, ${BOLD}host${NORM}, ${BOLD}country_code${NORM}, ${BOLD}ua${NORM}, ${BOLD}referer${NORM},\n ${BOLD}port${NORM}, ${BOLD}lang${NORM}, ${BOLD}encoding${NORM}, ${BOLD}mime${NORM}, ${BOLD}forwarded${NORM} or ${BOLD}all${NORM}.\nSee ${BOLD}https://ifconfig.io/${NORM} for more information."
  else
    for i in "$@"; do
      curl -q https://ifconfig.io/$i
    done
  fi
}

