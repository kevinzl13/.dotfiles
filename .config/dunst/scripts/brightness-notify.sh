#!/bin/bash

# Obtener el brillo actual usando brightnessctl
BRIGHTNESS=$(brightnessctl g)

# Obtener el valor máximo de brillo para calcular el porcentaje
MAX_BRIGHTNESS=$(brightnessctl m)

# Calcular el porcentaje de brillo
PERCENT=$((BRIGHTNESS * 100 / MAX_BRIGHTNESS))

# Mostrar la notificación con el porcentaje de brillo
dunstify -u normal -t 1500 -i brightness-low -r 1001 "Brillo: $PERCENT%"
