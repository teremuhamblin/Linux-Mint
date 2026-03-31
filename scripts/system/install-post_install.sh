#!/usr/bin/env bash
set -euo pipefail

# Chargement des fonctions internes
source "$(dirname "$0")/../core/logging.sh"
source "$(dirname "$0")/../core/checks.sh"

# Vérifications système
check_root
check_mint

###############################################
# 1. INSTALLATION DES PAQUETS ESSENTIELS
###############################################

PACKAGES=(
    git
    curl
    wget
    build-essential
    python3
    python3-pip
    vim
    htop
    tmux
    jq
)

log_info "Mise à jour des dépôts..."
apt update -y

log_info "Installation des paquets essentiels..."
apt install -y "${PACKAGES[@]}"

###############################################
# 2. POST-INSTALLATION ENGINEERING EDITION
###############################################

log_info "Configuration post-installation Linux Mint Engineering Edition..."

log_info "Configuration du shell par défaut (bash)..."
chsh -s /bin/bash "${SUDO_USER:-$USER}" || true

log_info "Activation des dépôts supplémentaires (si nécessaire)..."
# Exemple :
# add-apt-repository -y ppa:graphics-drivers/ppa

log_info "Application des mises à jour..."
apt update -y && apt upgrade -y

###############################################
# FIN
###############################################

log_success "Installation et post-installation terminées."
