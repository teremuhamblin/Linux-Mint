#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../core/logging.sh"
source "$(dirname "$0")/../core/checks.sh"
source "$(dirname "$0")/../core/utils.sh"

check_root
check_mint

log_info "Installation des outils supplémentaires pour chadwm (Mint Engineering Edition)"

###############################################
# MISE À JOUR
###############################################
log_info "Mise à jour des dépôts..."
apt update -y

###############################################
# INSTALLATION DES APPLICATIONS
###############################################

EXTRAS=(
    acpi
    arandr
    autorandr
    catfish
    duf
    feh
    font-manager
    hwinfo
    hw-probe
    lolcat
    lxappearance
    most
    nitrogen
    nomacs
    numlockx
    pavucontrol
    picom
    ripgrep
    rofi
    suckless-tools
    sxhkd
    thunar
    thunar-archive-plugin
    variety
    xfce4-taskmanager
    xfce4-terminal
    silversearcher-ag
)

log_info "Installation des outils chadwm..."
apt install -y "${EXTRAS[@]}"

###############################################
# FIN
###############################################

log_success "chadwm extras installés avec succès."
