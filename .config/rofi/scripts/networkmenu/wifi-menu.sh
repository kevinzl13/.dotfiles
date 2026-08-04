#!/usr/bin/env bash

# ==============================
# Detectar interfaz WiFi
# ==============================

wifi_iface=$(nmcli -t -f DEVICE,TYPE device status | awk -F: '$2=="wifi"{print $1}')

if [[ -z "$wifi_iface" ]]; then
    notify-send "WiFi" "No se encontró interfaz WiFi"
    exit 1
fi



wifi_menu() {


# ==============================
# Estado WiFi
# ==============================

wifi_state=$(nmcli radio wifi)



# ==============================
# Escanear redes
# ==============================

if [[ "$wifi_state" == "enabled" ]]; then

    nmcli device wifi rescan ifname "$wifi_iface" >/dev/null 2>&1
    sleep 1

    wifi_list=$(nmcli -t -f SSID,SECURITY,SIGNAL device wifi list ifname "$wifi_iface")

else

    wifi_list=""

fi



# ==============================
# Crear menú
# ==============================

declare -A wifi_map

menu=""



# Encender / apagar WiFi

if [[ "$wifi_state" == "enabled" ]]; then

    menu+="󰖪 WiFi Off"$'\n'

else

    menu+="󰖩 WiFi On"$'\n'

fi



menu+="󰑐 Refresh"$'\n'



# ==============================
# Lista redes
# ==============================

while IFS=: read -r ssid security signal; do


    [[ -z "$ssid" ]] && continue



    # Evitar duplicados

    [[ -n "${wifi_map[$ssid]}" ]] && continue



    # Icono señal

    if (( signal <= 25 )); then

        wifi_signal="󰤟"

    elif (( signal <= 50 )); then

        wifi_signal="󰤢"

    elif (( signal <= 75 )); then

        wifi_signal="󰤥"

    else

        wifi_signal="󰤨"

    fi



    # Seguridad

    if [[ -z "$security" || "$security" == "--" ]]; then

        lock=""

    else

        lock=""

    fi



    # Guardada

    if nmcli -t -f NAME connection show | grep -Fxq "$ssid"; then

        saved="Guardada"

    else

        saved=""

    fi



    entry="$wifi_signal $lock $ssid ${signal}% $saved"


    wifi_map["$entry"]="$ssid"


    menu+="$entry"$'\n'



done <<< "$wifi_list"



selected=$(echo "$menu" | rofi -dmenu -i -p "WiFi:")



[[ -z "$selected" ]] && exit 0



# ==============================
# WiFi ON/OFF
# ==============================

if [[ "$selected" == "󰖪 WiFi Off" ]]; then

    nmcli radio wifi off
    notify-send "WiFi" "WiFi apagado"
    exit 0

fi



if [[ "$selected" == "󰖩 WiFi On" ]]; then

    nmcli radio wifi on
    notify-send "WiFi" "WiFi encendido"
    exit 0

fi



# ==============================
# Refresh
# ==============================

if [[ "$selected" == "󰑐 Refresh" ]]; then

    wifi_menu
    exit 0

fi



# ==============================
# Obtener SSID
# ==============================

ssid="${wifi_map[$selected]}"



[[ -z "$ssid" ]] && exit 0



# ==============================
# Buscar conexión guardada
# ==============================

saved_uuid=$(nmcli -t -f UUID,NAME connection show |
    awk -F: -v s="$ssid" '$2==s {print $1; exit}')



if [[ -n "$saved_uuid" ]]; then


    nmcli connection up uuid "$saved_uuid" ifname "$wifi_iface"


    if [[ $? -eq 0 ]]; then
        notify-send "WiFi" "✓ Conectado a $ssid"
    else
        notify-send "WiFi" "✗ Error conectando a $ssid"
    fi


    exit 0

fi



# ==============================
# Red nueva
# ==============================

security=$(echo "$wifi_list" |
    awk -F: -v s="$ssid" '$1==s {print $2; exit}')



# Red abierta

if [[ -z "$security" || "$security" == "--" ]]; then


    nmcli device wifi connect "$ssid" \
        ifname "$wifi_iface"



# Red con contraseña

else


    password=$(rofi -dmenu \
        -password \
        -p "Contraseña de $ssid:")



    [[ -z "$password" ]] && exit 0



    nmcli device wifi connect "$ssid" \
        password "$password" \
        ifname "$wifi_iface"


fi



if [[ $? -eq 0 ]]; then

    notify-send "WiFi" "✓ Conectado a $ssid"

else

    notify-send "WiFi" "✗ Error conectando a $ssid"

fi


}



wifi_menu
