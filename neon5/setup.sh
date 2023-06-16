#!/bin/sh
#   DevEnv - Setup a development environment with KDE Neon
#
#   Copyright © 2023, Rodrigo Ernesto Alvarez Aguilera <incognia@gmail.com>
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#   Version 0.2 - June 16, 2023
#   Author: Rodrigo Ernesto Alvarez Aguilera
#
#   Tested under KDE neon 5.27 using GNU bash version 5.1.16
#

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
    apt install -y clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev
    # Speedtest CLI
    wget https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh
    os=ubuntu dist=jammy bash script.deb.sh
    apt install -y speedtest
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