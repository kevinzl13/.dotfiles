#!/usr/bin/env bash

# Mata TODAS las barras
killall -q polybar

# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit

echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log

# Espera a que mueran
while pgrep -x polybar >/dev/null; do sleep 1; done

# Lanza la barra
polybar bar1 &

echo "Polybar lanzada"
