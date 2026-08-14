#!/usr/bin/env bash

TOUCHPAD_ID="11"

get_status() {
    xinput list-props "$TOUCHPAD_ID" |
        awk '/Device Enabled/{print $NF}'
}

case "$1" in
    toggle)
        if [ "$(get_status)" = "1" ]; then
            xinput disable "$TOUCHPAD_ID"
        else
            xinput enable "$TOUCHPAD_ID"
        fi
        ;;

    status)
        if [ "$(get_status)" = "1" ]; then
             echo "%{F#bd93f9}󰟸 ON%{F-}"
        else
             echo "%{F#F38BA8}󰤳 OFF%{F-}"
        fi
        ;;
esac
