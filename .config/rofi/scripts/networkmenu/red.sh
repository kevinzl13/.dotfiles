#!/usr/bin/env bash

# Notificar que estamos obteniendo la lista de redes Wi-Fi
notify-send "Getting list of available Wi-Fi networks..."

# Obtener la lista de redes Wi-Fi con seguridad
wifi_list=$(nmcli -t -f SSID,SECURITY device wifi list)

# Función para mostrar la lista de Wi-Fi en Rofi
list_wifi() {
    # Procesamos la salida de nmcli para añadir el candado
    echo "$wifi_list" | while IFS=: read -r ssid security; do
        if [[ "$security" != "--" ]]; then
            # Si la red tiene seguridad, añadir icono de candado cerrado ()
            echo " $ssid"
        else
            # Si la red está abierta (sin seguridad), añadir icono de candado abierto ()
            echo " $ssid"
        fi
    done | rofi -dmenu -p "Select Wi-Fi"
}

# Llamar a la función para mostrar las redes en Rofi y guardar la selección
selected_wifi=$(list_wifi)

# Si se seleccionó una red, conectar a ella
if [[ -n "$selected_wifi" ]]; then
    # Eliminar los iconos y el SSID (quedándose solo con el nombre de la red)
    ssid=$(echo "$selected_wifi" | sed 's/ //;s/ //')  # Limpiar los iconos

    # Verificar si la red está guardada en las conexiones previas
    if nmcli connection show | grep -q "$ssid"; then
        # Si la red está guardada, conectarse a ella sin pedir contraseña
        notify-send "Connecting to network: $ssid"
        nmcli device wifi connect "$ssid" ifname wlo1
    else
        # Si la red está protegida (tiene seguridad), pedir la contraseña
        if [[ "$selected_wifi" == *""* ]]; then
            password=$(rofi -dmenu -p "Enter password for $ssid")

            # Si no se ingresó una contraseña, no hacemos nada
            if [[ -n "$password" ]]; then
                # Conectar a la red con la contraseña y guardarla
                notify-send "Connecting to $ssid..."
                nmcli device wifi connect "$ssid" password "$password" ifname wlo1
            else
                notify-send "No password entered for $ssid."
            fi
        else
            # Si la red no tiene seguridad, conectar sin pedir contraseña
            notify-send "Connecting to $ssid..."
            nmcli device wifi connect "$ssid" ifname wlo1
        fi
    fi
fi
