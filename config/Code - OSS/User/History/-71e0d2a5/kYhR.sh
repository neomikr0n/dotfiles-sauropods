#!/bin/bash

iDIR="$HOME/.config/dunst/icons"

# Notifcation
# notification= notify-send -t 909 -u low -h int:value:80 '⌛ POWERing-OFF... (3)' 
    # $notification 
# -h string:x-canonical-private-synchronous:sys-notify 

# --expire-time=909 --urgency=low
shutdown() {
    # $notification,
    # notification= notify-send -t 909 -u low -h int:value:80 "⌛ POWERing-OFF... (2)"
    notify-send -t 909 -u low -h int:value:80 "⌛ POWERing-OFF... (3)"
    # sleep 1 && \
    # $notification 50 "⏳ POWERing-OFF... (2)" && \
    # sleep 1 && \
    # $notification 15 "⌛ POWERing-OFF... (1)" && \
  # notify-send -h string:x-canonical-private-synchronous:sys-notify -u "$(get_urgency)" -i "$(get_icon)" -h  int:value:$(get_volume) "Volume : $(get_volume)%"
}

# Restart
restart() {
notify-send -t 909 -u low -h int:value:80 "⌛ POWERing-OFF... (3)" && \
}

# Logout
logout() {
  pactl set-sink-volume @DEFAULT_SINK@ -5% && notify_user   # an alternave is using pactl instead
  # pamixer -d 5 && notify_user   # an alternative to pactl, doesn't go beyond 100% tho
}

# Execute accordingly
if [[ "$1" == "--shutdown" ]]; then
  shutdown
elif [[ "$1" == "--inc" ]]; then
  inc_volume
elif [[ "$1" == "--dec" ]]; then
  dec_volume
elif [[ "$1" == "--toggle" ]]; then
  toggle_mute
elif [[ "$1" == "--toggle-mic" ]]; then
  toggle_mic
elif [[ "$1" == "--get-icon" ]]; then
  get_icon
elif [[ "$1" == "--up" ]]; then
  up
elif [[ "$1" == "--down" ]]; then
  down
elif [[ "$1" == "--notify" ]]; then
  notify_user
else
  get_volume & notify_user
fi