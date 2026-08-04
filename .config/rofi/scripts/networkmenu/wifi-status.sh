#!/usr/bin/env bash

# Detectar interfaz activa
active=$(ip route | awk '/default/ {print $5}')

# Detectar interfaz Wi-Fi
wifi_iface=$(iw dev | awk '$1=="Interface"{print $2; exit}')

# Colores Polybar
green="#50fa7b"
orange="#ffb86c"
alert="#ff5555"
blurple="#bd93f9"


# Wi-Fi conectado
if [[ "$active" == "$wifi_iface" ]]; then

    essid=$(iwgetid -r)

    signal=$(awk -v iface="$wifi_iface" '
        $1 ~ iface":" {
            gsub(/\./, "", $3)
            print int($3 * 100 / 70)
        }
    ' /proc/net/wireless)


    if (( signal <= 20 )); then
        icon="󰤭"
        color=$alert

    elif (( signal <= 40 )); then
        icon="󰤟"
        color=$orange

    elif (( signal <= 60 )); then
        icon="󰤢"
        color=$orange

    elif (( signal <= 80 )); then
        icon="󰤥"
        color=$green

    else
        icon="󰤨"
        color=$blurple
    fi


    echo "%{F$color}$icon%{F-} $essid"


# Ethernet
elif [[ -n "$active" ]]; then

    ip=$(ip -4 -o addr show "$active" | awk '{print $4}' | cut -d/ -f1)

    echo "󰈀 $ip"


# Sin conexión
else

    echo "%{F$alert}󰤭%{F-} Not connected"

fi
