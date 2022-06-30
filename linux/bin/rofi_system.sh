#!/usr/bin/env bash

set -eo pipefail

main() {
  local -Ar menu=(
    ['Reboot']='systemctl reboot'
    ['Suspend']='systemctl suspend'
    ['Shutdown']='systemctl poweroff'
    ['Mute']='pactl set-sink-mute @DEFAULT_SINK@ 1'
    ['Unmute']='pactl set-sink-mute @DEFAULT_SINK@ 0'
#    ['Change Wallpapers']='nitrogen ~/Pictures/wallpapers'
  )

  local -r IFS=$'\n'
  [[ $ROFI_RETV -eq 0 ]] && echo "${!menu[*]}" || eval "${menu[$@]}"
}

main "$@"
