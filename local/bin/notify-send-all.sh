#!/bin/bash
PATH=/usr/bin:/bin

if [ $# -eq 0 ]; then
  echo "No summary specified"
  notify-send --help | sed -e 's/notify-send/&-all/g' -e 's/create a notification/& to all users/g'
  exit 1
fi

XUSERS=($(who|grep -E "\(:[0-9](\.[0-9])*\)"|awk '{print $1$NF}'|sort -u))
for XUSER in "${XUSERS[@]}"; do
    NAME=(${XUSER/(/ })
    DISPLAY=${NAME[1]/)/}
    DBUS_ADDRESS=unix:path=/run/user/$(id -u ${NAME[0]})/bus
    sudo -u ${NAME[0]} DISPLAY=${DISPLAY} \
                       DBUS_SESSION_BUS_ADDRESS=${DBUS_ADDRESS} \
                       PATH=${PATH} \
                       notify-send "$@"
done
