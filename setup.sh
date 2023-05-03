#!/bin/sh

# bool function to test if the user is root or not (POSIX only)
is_user_root ()
{
    [ "$(id -u)" -eq 0 ]
}

if is_user_root; then
    reset
    echo '┌──────────────────────────────────────────────────────────────────────────────┐'
    echo '│ ¡Eres el todo poderoso \033[31mroot\033[39m y tus bolas llegan al piso!                      │'
    echo '└──────────────────────────────────────────────────────────────────────────────┘'
    sleep 2
    # You can do whatever you need...
    reset
    echo '┌──────────────────────────────────────────────────────────────────────────────┐'
    echo '│ Actualizando el sistema...                                                   │'
    echo '└──────────────────────────────────────────────────────────────────────────────┘'
    sleep 2
    apt update
    apt install -y aptitude
    aptitude safe-upgrade -y
    reset
    echo '┌──────────────────────────────────────────────────────────────────────────────┐'
    echo '│ Instalando paquetes (apt) adicionales...                                     │'
    echo '└──────────────────────────────────────────────────────────────────────────────┘'
    sleep 2
    # OpenSSH Server
    apt install -y openssh-server
    # Utilerías básicas
    apt install -y neofetch mc nmon htop glances
    # Dependencias de Flutter
    apt install clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev
    # Speedtest CLI
    wget https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh
    os=ubuntu dist=jammy bash script.deb.sh
    apt install speedtest
    rm script.deb.sh
    reset
    echo '┌──────────────────────────────────────────────────────────────────────────────┐'
    echo '│ Descargando paquetes (deb) adicionales...                                    │'
    echo '└──────────────────────────────────────────────────────────────────────────────┘'
    sleep 2
    wget -i deb.files
    reset
    echo '┌──────────────────────────────────────────────────────────────────────────────┐'
    echo '│ Instalando paquetes (deb) adicionales...                                     │'
    echo '└──────────────────────────────────────────────────────────────────────────────┘'
    sleep 2
    dpkg -i *.deb
    apt install -fy
    rm *.deb
    # Eliminar Firefox
    apt purge firefox
    apt autoremove --purge
    reset
    echo '┌──────────────────────────────────────────────────────────────────────────────┐'
    echo '│ Probando la conexión a internet...                                           │'
    echo '└──────────────────────────────────────────────────────────────────────────────┘'
    sleep 2
    speedtest --accept-license
    sleep 5
    reset
    cat minion.banner
else
    echo '┌──────────────────────────────────────────────────────────────────────────────┐'
    echo '│ Eres un usuario mortal, ordinario y pedestre.                                │'
    echo '│ Necesitas ser \033[31mroot\033[39m o usar \033[31msudo\033[39m para ejecutar esta madre.                     │'
    echo '└──────────────────────────────────────────────────────────────────────────────┘' >&2
    exit 1
fi