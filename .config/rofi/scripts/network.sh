#!/bin/env bash

# Detectar interfaz activa
active=$(ip route | grep default | awk '{print $5}')

# Colores según tu tema Dracula
green="#50fa7b"
orange="#ffb86c"
alert="#ff5555"
blurple="#bd93f9"

# WiFi
if [[ "$active" == "wlo1" ]]; then
    essid=$(iwgetid -r)
    signal=$(grep -i "$active" /proc/net/wireless | awk '{print int($3 * 100 / 70)}')
    
    if ((signal <= 20)); then
        icon="󰤭"  # sin señal
        color=$alert
    elif ((signal <= 40)); then
        icon="󰤟"
        color=$orange
    elif ((signal <= 60)); then
        icon="󰤢"
        color=$orange
    elif ((signal <= 80)); then
        icon="󰤥"
        color=$green
    else
        icon="󰤨"
        color=$blurple
    fi

    echo "%{F$color}$icon%{F-} $essid"

# Ethernet
elif [[ "$active" == "enp2s0" ]]; then
    ip=$(ip -4 addr show enp2s0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    echo "󰈀 ${ip}"

# Sin conexión
else
    echo "%{F$alert}󰤭%{F-} not connected"
fi
