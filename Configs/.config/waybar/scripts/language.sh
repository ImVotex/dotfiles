#!/usr/bin/env bash


get_layout() {
    layout=$(swaymsg -t get_inputs | grep -m1 'xkb_active_layout_name' | awk -F '"' '{print $4}')
    case "$layout" in
        *English*) echo "EN" ;;
        *Russian*) echo "RU" ;;
        *Ukrainian*) echo "UA" ;;
        *) echo "--" ;;
    esac
}

prev_layout=""

while true; do
    layout=$(get_layout)
    if [ "$layout" != "$prev_layout" ]; then
        echo "$layout"
        prev_layout="$layout"
    fi
    sleep 0.5
done
