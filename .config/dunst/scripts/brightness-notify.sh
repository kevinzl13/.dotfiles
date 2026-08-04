#!/bin/bash

# # Obtener el brillo actual usando brightnessctl
BRIGHTNESS=$(brightnessctl g)
#
# # Obtener el valor máximo de brillo para calcular el porcentaje
MAX_BRIGHTNESS=$(brightnessctl m)
#
# Calcular porcentaje redondeando
PERCENT=$(( (BRIGHTNESS * 100 + MAX_BRIGHTNESS / 2) / MAX_BRIGHTNESS ))

# Limitar entre 0 y 100
[ "$PERCENT" -gt 100 ] && PERCENT=100
[ "$PERCENT" -lt 0 ] && PERCENT=0

dunstify -u normal -t 1500 -i brightness-low -r 1001 "Brillo: ${PERCENT}%"




