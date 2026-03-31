#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../core/logging.sh"
source "$(dirname "$0")/../core/checks.sh"
source "$(dirname "$0")/../core/utils.sh"

check_root
check_mint

USER_HOME="/home/${SUDO_USER:-$USER}"
CONFIG_DIR="$USER_HOME/.config/arco-chadwm"

log_info "Installation de chadwm (window manager) pour Linux Mint Engineering Edition"

###############################################
# INSTALLATION DES DÉPENDANCES
###############################################
log_info "Installation des dépendances de compilation..."

apt update -y
apt install -y \
    build-essential \
    libimlib2-dev \
    libx11-dev \
    libxft-dev \
    libxinerama-dev \
    libfreetype6-dev \
    libfontconfig1-dev

###############################################
# COPIE DE LA CONFIGURATION
###############################################
log_info "Copie de la configuration chadwm dans $CONFIG_DIR"

ensure_dir "$USER_HOME/.config"
cp -r arco-chadwm "$CONFIG_DIR"

chown -R "${SUDO_USER:-$USER}":"${SUDO_USER:-$USER}" "$CONFIG_DIR"

###############################################
# COMPILATION
###############################################
log_info "Compilation de chadwm..."

cd "$CONFIG_DIR/chadwm"
make
make install

###############################################
# CREATION DU FICHIER .desktop
###############################################
log_info "Création de l'entrée de session chadwm..."

DESKTOP_FILE="/usr/share/xsessions/chadwm.desktop"

cat <<EOF | tee "$DESKTOP_FILE" >/dev/null
[Desktop Entry]
Encoding=UTF-8
Name=Chadwm
Comment=Dynamic window manager
Exec=$CONFIG_DIR/scripts/run.sh
Icon=chadwm
Type=Application
EOF

log_success "chadwm installé et disponible dans l'écran de connexion."
