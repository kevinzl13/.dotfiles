#!/bin/bash

wifi=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d: -f2)
eth=$(nmcli -t -f DEVICE,STATE dev | grep ethernet | grep connected | cut -d: -f1)

if [ "$eth" != "" ]; then
    ip=$(ip -4 addr show "$eth" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    echo "󰈀 $ip"
elif [ "$wifi" != "" ]; then
    echo " $wifi"
else
    echo "󰖪 Offline"
fi
