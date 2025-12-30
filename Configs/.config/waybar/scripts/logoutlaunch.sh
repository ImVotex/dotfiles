#!/bin/bash

export SWAYSOCK=${SWAYSOCK:-$(ls /run/user/$(id -u)/sway-ipc.*.sock 2>/dev/null | head -n 1)}
export WAYLAND_DISPLAY=${WAYLAND_DISPLAY:-wayland-1}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/run/user/$(id -u)}

if pgrep -x "wlogout" >/dev/null; then
    pkill -x "wlogout"
    exit 0
fi

confDir="${XDG_CONFIG_HOME:-$HOME/.config}"
style="${1:-1}"

layout="${confDir}/wlogout/layout_${style}"
css="${confDir}/wlogout/style_${style}.css"

if [ ! -f "$layout" ] || [ ! -f "$css" ]; then
    echo "Config $style not found, using default"
    layout="${confDir}/wlogout/layout_1"
    css="${confDir}/wlogout/style_1.css"
fi

output=$(swaymsg -t get_outputs | jq '.[] | select(.focused == true)')
x_mon=$(echo "$output" | jq '.current_mode.width')
y_mon=$(echo "$output" | jq '.current_mode.height')

export fntSize=$(( y_mon * 2 / 100 ))
export BtnCol="white"
export active_rad=10
export button_rad=15

exec wlogout --protocol layer-shell -b 6 --layout "$layout" --css "$css" &

