#!/bin/bash

# Obtener el volumen actual
VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F'/' '{print $2}' | tr -d '[:space:]' | sed 's/%//')

# Obtener el estado de muteo
MUTE=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -oP '(?<=Mute: ).*')

# Determinar el tipo de notificación basado en el volumen y muteo
if [[ "$MUTE" == "yes" ]]; then
  dunstify -u low -t 1500 -i audio-volume-muted -r 1000 "Volumen muteado"
elif [[ "$VOL" -lt 30 ]]; then
  dunstify -u normal -t 1500 -i audio-volume-low -r 1000 "Volumen bajo: $VOL%"
elif [[ "$VOL" -lt 70 ]]; then
  dunstify -u normal -t 1500 -i audio-volume-medium -r 1000 "Volumen: $VOL%"
else
  dunstify -u normal -t 1500 -i audio-volume-high -r 1000 "Volumen alto: $VOL%"
fi
