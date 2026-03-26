#!/bin/env bash

cd "$(dirname "$0")"

# Iconos
POWEROFF=""
LOCK=""
SUSPEND=""
REBOOT=""
LOGOUT=""
CLOSE=""
YES=""
NO=""

# Opciones del menú
powermenu_options() {
    echo -en "$POWEROFF Apagar\0meta\x1fpoweroff power off shutdown apagar\n"
    echo -en "$REBOOT Reiniciar\0meta\x1freboot restart reiniciar\n"
    echo -en "$SUSPEND Suspender\0meta\x1fsuspend sleep suspender\n"
    echo -en "$LOCK Bloquear\0meta\x1flock lock screen bloquear\n"
    echo -en "$LOGOUT Cerrar Sesión\0meta\x1flogout log out cerrarsesion cerrar sesion\n"
    echo -en "$CLOSE Salir\0meta\x1fsalir cerrar\n"
}

# Menú principal
powermenu() {
    powermenu_options | rofi -dmenu -i -p "Power Menu" \
        -theme-str 'listview {lines:6;} element {text-align:center; font:"FiraCode Nerd Font 18";}'
}

# Menú de confirmación
confirm_menu() {
    echo -en "$YES Si\0meta\x1fconfirm si yes\n"
    echo -en "$NO No\0meta\x1fcancel no cancel\n"
}

# Ejecuta un comando solo si el usuario confirma
assert_confirm() {
    local cmd="$1"
    local choice
    choice=$(confirm_menu | rofi -dmenu -i -p "¿Estás seguro?" \
        -theme-str 'listview {lines:2;} element {text-align:center; font:"FiraCode Nerd Font 18";}')

    if [[ "$choice" == "$YES Si" ]]; then
        eval "$cmd"
    else
        echo "Acción cancelada"
    fi
}

# Función principal (una sola ejecución)
main() {
    chosen=$(powermenu)

    case "$chosen" in
        "$POWEROFF Apagar")
            # assert_confirm "echo 'Apagando...'"
            assert_confirm "systecmctl poweroff"
            ;;
        "$REBOOT Reiniciar")
            # assert_confirm "echo 'Reiniciando...'"
            assert_confirm "systemctl reboot"
            ;;
        "$SUSPEND Suspender")
            # assert_confirm "echo 'Suspendiendo...'"
            assert_confirm "systemctl suspend"
            ;;
        "$LOCK Bloquear")
            # assert_confirm "echo 'Bloqueando...'"
            assert_confirm "i3lock"
            ;;
        "$LOGOUT Cerrar Sesión")
            # assert_confirm "echo 'Cerrando sesión...'"
            assert_confirm "i3-msg exit"
            ;;
        "$CLOSE Salir")
            echo "Saliendo del menú..."
            exit 0
            ;;
        *)
            # Si se cierra rofi sin seleccionar nada
            exit 0
            ;;
    esac
}

main
