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


wifi_state=$(nmcli radio wifi)



# ==============================
# Escaneo
# ==============================

if [[ "$wifi_state" == "enabled" ]]; then

    nmcli device wifi rescan ifname "$wifi_iface" >/dev/null 2>&1
    sleep 1


    wifi_list=$(nmcli -t -f SSID,SECURITY,SIGNAL device wifi list ifname "$wifi_iface")


    wifi_bssid=$(nmcli -f SSID,BSSID device wifi list ifname "$wifi_iface" | tail -n +2)


else

    wifi_list=""

fi



declare -A wifi_map

menu=""



# ==============================
# Red actual
# ==============================

current_ssid=$(nmcli -t -f ACTIVE,SSID device wifi list ifname "$wifi_iface" |
awk -F: '$1=="yes"{print $2}')



if [[ -n "$current_ssid" ]]; then

    menu+="󰤨 Conectado: $current_ssid"$'\n'
    menu+=$'\n'

fi



# ==============================
# Opciones
# ==============================

if [[ "$wifi_state" == "enabled" ]]; then

    menu+="󰖪 WiFi Off"$'\n'

else

    menu+="󰖩 WiFi On"$'\n'

fi


menu+="󰑐 Refresh"$'\n'
menu+="󰆴 Olvidar red"$'\n'



# ==============================
# Redes WiFi
# ==============================

while IFS=: read -r ssid security signal; do


    [[ -z "$ssid" ]] && continue



    # Icono señal

    if (( signal <= 25 )); then

        icon="󰤟"

    elif (( signal <= 50 )); then

        icon="󰤢"

    elif (( signal <= 75 )); then

        icon="󰤥"

    else

        icon="󰤨"

    fi



    # Seguridad

    if [[ "$security" == "--" || -z "$security" ]]; then

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



    # Obtener BSSID correspondiente

    bssid=$(echo "$wifi_bssid" |
        awk -v s="$ssid" '$1==s {print $2; exit}')



    entry="$icon $lock $ssid $saved"



    # Guardar datos internos

    wifi_map["$entry"]="$ssid|$bssid|$security"



    menu+="$entry"$'\n'


done <<< "$wifi_list"



selected=$(echo "$menu" | rofi -dmenu -i -p "WiFi:")



[[ -z "$selected" ]] && exit 0



# ==============================
# Opciones
# ==============================


if [[ "$selected" == 󰤨* ]]; then
    exit 0
fi



if [[ "$selected" == "󰖪 WiFi Off" ]]; then

    nmcli radio wifi off
    exit 0

fi



if [[ "$selected" == "󰖩 WiFi On" ]]; then

    nmcli radio wifi on
    exit 0

fi



if [[ "$selected" == "󰑐 Refresh" ]]; then

    wifi_menu
    exit 0

fi



# ==============================
# Olvidar red
# ==============================

if [[ "$selected" == "󰆴 Olvidar red" ]]; then


    network=$(nmcli -t -f NAME,TYPE connection show |
        awk -F: '$2=="802-11-wireless"{print $1}' |
        rofi -dmenu -p "Eliminar red:")



    [[ -z "$network" ]] && exit 0



    nmcli connection delete "$network" >/dev/null 2>&1


    exit 0

fi



# ==============================
# Datos seleccionados
# ==============================

data="${wifi_map[$selected]}"


ssid=$(echo "$data" | cut -d'|' -f1)
bssid=$(echo "$data" | cut -d'|' -f2)
security=$(echo "$data" | cut -d'|' -f3)



[[ -z "$ssid" ]] && exit 0



# ==============================
# Red guardada
# ==============================

if nmcli -t -f NAME connection show | grep -Fxq "$ssid"; then


    nmcli connection up "$ssid" ifname "$wifi_iface"


    exit 0

fi



# ==============================
# Red abierta
# ==============================

if [[ "$security" == "--" || -z "$security" ]]; then


    nmcli device wifi connect "$ssid" \
        bssid "$bssid" \
        ifname "$wifi_iface"



    exit 0

fi



# ==============================
# Red con contraseña
# ==============================

password=$(rofi -dmenu \
    -password \
    -p "Contraseña:")



[[ -z "$password" ]] && exit 0



nmcli device wifi connect "$ssid" \
    bssid "$bssid" \
    password "$password" \
    ifname "$wifi_iface"


}


wifi_menu
