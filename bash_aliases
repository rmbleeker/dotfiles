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
alias less='less --tabs=4'
alias lsusers='getent passwd | tr ":" " " | awk "\$3 >= $(grep UID_MIN /etc/login.defs | cut -d " " -f 2) { print \$1 }"'
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

sshkill() {
  for socket in $(find ~/.ssh -type s); do
    socket=${socket##*/}  ## strip path
    socket=${socket%:*}   ## strip port number
    echo -n "${socket}: "
    ssh -O exit "${socket}"
  done
}

update() {
  case $(grep -w ID /etc/os-release | cut -d'=' -f2 | tr -d '"') in
    pop|ubuntu|debian)
      sudo apt update && sudo apt -y upgrade
      ;;
    rhel|centos)
      sudo yum -y update
      ;;
    *)
      echo "Unknown distribution, no idea how to update the system"
      ;;
  esac
}

rr() {
  case $(grep -w ID /etc/os-release | cut -d'=' -f2 | tr -d '"') in
    ubuntu|debian)
      [ -f /run/reboot-required ] && echo "The following packages require a system restart:" && cat /run/reboot-required.pkgs || echo "No reboot required"
      ;;
    rhel|centos)
      [ -x /usr/bin/needs-restarting ] && /usr/bin/needs-restarting -r || echo "command '/usr/bin/needs-restarting' not available"
      ;;
    *)
      echo "Unknown distribution, no idea how to check if a reboot of the system is required"
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
  case $# in
    0)
      curl -q https://ipinfo.io/
      ;;
    1|2)
      curl -q https://ipinfo.io/$1/$2
      ;;
    *)
      echo -e "${BOLD}Usage:${NORM}   ipinfo [ip_address] [response_filter]\n${BOLD}Example:${NORM} ipinfo 123.45.67.89 loc\n${BOLD}Filters:${NORM} ip,city,region,country,loc,postal,org"
      ;;
  esac
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

