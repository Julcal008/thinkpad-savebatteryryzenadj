#!/bin/bash

export XDG_RUNTIME_DIR=/run/user/$(id -u)

Opciones="VIDEOS (2W)\nAhorronormal (4W)\nAhorroBateriaequilibrado (7W)\nEquilibrado (12W)\nRendimiento (25W)"

Eleccion=$(echo -e "$Opciones" | wofi --dmenu --cache-file /dev/null --p "Perfil de energía:")

aplicar_tdp() {
    sudo -n ryzenadj "$@" 2>/dev/null || pkexec ryzenadj "$@"
}

case $Eleccion in
    "VIDEOS (2W)")
        aplicar_tdp --stapm-limit=2000 --fast-limit=2000 --slow-limit=2000
        echo "VIDEOS (2W)" > /tmp/perfil_tdp ;;
    "Ahorronormal (4W)")
        aplicar_tdp --stapm-limit=4000 --fast-limit=4000 --slow-limit=4000
        echo "Ahorro(4W)" > /tmp/perfil_tdp ;;
    "AhorroBateriaequilibrado (7W)")
        aplicar_tdp --stapm-limit=7000 --fast-limit=7000 --slow-limit=7000
        echo "Ahorro (7W)" > /tmp/perfil_tdp ;;
    "Equilibrado (12W)")
        aplicar_tdp --stapm-limit=12000 --fast-limit=12000 --slow-limit=12000
        echo "Equilibrado (12W)" > /tmp/perfil_tdp ;;
    "Rendimiento (25W)")
        aplicar_tdp --stapm-limit=25000 --fast-limit=25000 --slow-limit=25000
        echo "Rendimiento (25W)" > /tmp/perfil_tdp ;;
esac
