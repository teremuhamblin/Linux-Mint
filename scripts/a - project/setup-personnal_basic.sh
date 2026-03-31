#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../core/logging.sh"
source "$(dirname "$0")/../core/checks.sh"
source "$(dirname "$0")/../core/utils.sh"

check_root
check_mint

USER_NAME="${SUDO_USER:-$USER}"
USER_HOME="/home/$USER_NAME"

# Répertoire d'installation = racine du projet
INSTALLED_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

log_info "Configuration personnelle pour l'utilisateur : $USER_NAME"
log_info "Répertoire projet détecté : $INSTALLED_DIR"

###############################################
# 1. CRÉATION DES DOSSIERS PERSONNELS
###############################################

create_user_dir() {
    local dir="$1"
    if [[ ! -d "$dir" ]]; then
        log_info "Création du dossier : $dir"
        mkdir -p "$dir"
        chown -R "$USER_NAME":"$USER_NAME" "$dir"
    fi
}

log_info "Création des dossiers personnels..."

create_user_dir "$USER_HOME/.bin"
create_user_dir "$USER_HOME/.fonts"
create_user_dir "$USER_HOME/.icons"
create_user_dir "$USER_HOME/.themes"
create_user_dir "$USER_HOME/.local/share/icons"
create_user_dir "$USER_HOME/.local/share/themes"
create_user_dir "$USER_HOME/.config"
create_user_dir "$USER_HOME/.config/gtk-3.0"
create_user_dir "$USER_HOME/.config/variety"
create_user_dir "$USER_HOME/.config/variety/scripts"
create_user_dir "$USER_HOME/DATA"
create_user_dir "$USER_HOME/Insync"
create_user_dir "$USER_HOME/Projects"

###############################################
# 2. INSTALLATION DES CONFIGS PERSONNELLES
###############################################

log_info "Installation des paramètres Thunar..."
create_user_dir "$USER_HOME/.config/Thunar"
if [[ -f "$INSTALLED_DIR/personal/thunar/uca.xml" ]]; then
    cp "$INSTALLED_DIR/personal/thunar/uca.xml" "$USER_HOME/.config/Thunar/"
    chown "$USER_NAME":"$USER_NAME" "$USER_HOME/.config/Thunar/uca.xml"
else
    log_warn "Fichier uca.xml introuvable dans personal/thunar/"
fi

log_info "Installation des paramètres Variety..."
if [[ -f "$INSTALLED_DIR/personal/variety/variety.conf" ]]; then
    cp "$INSTALLED_DIR/personal/variety/variety.conf" "$USER_HOME/.config/variety/"
    chown "$USER_NAME":"$USER_NAME" "$USER_HOME/.config/variety/variety.conf"
else
    log_warn "Fichier variety.conf introuvable dans personal/variety/"
fi

if [[ -f "$INSTALLED_DIR/personal/variety/set_wallpaper" ]]; then
    cp "$INSTALLED_DIR/personal/variety/set_wallpaper" "$USER_HOME/.config/variety/scripts/"
    chmod +x "$USER_HOME/.config/variety/scripts/set_wallpaper"
    chown "$USER_NAME":"$USER_NAME" "$USER_HOME/.config/variety/scripts/set_wallpaper"
else
    log_warn "Script set_wallpaper introuvable dans personal/variety/"
fi

log_info "Installation du .bashrc personnalisé..."
if [[ -f "$INSTALLED_DIR/personal/bash/bashrc" ]]; then
    cp "$INSTALLED_DIR/personal/bash/bashrc" "$USER_HOME/.bashrc"
    chown "$USER_NAME":"$USER_NAME" "$USER_HOME/.bashrc"
else
    log_warn "Fichier bashrc introuvable dans personal/bash/"
fi

###############################################
# 3. CONFIGURATION GRUB
###############################################

log_info "Configuration de GRUB (timeout + thème)..."

GRUB_FILE="/etc/default/grub"
if [[ -f "$GRUB_FILE" ]]; then
    sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=3/' "$GRUB_FILE"
    log_info "GRUB_TIMEOUT réglé à 3 secondes."
else
    log_warn "Fichier /etc/default/grub introuvable."
fi

log_info "Installation du thème GRUB Mint..."
apt update -y
apt install -y grub2-theme-mint || log_warn "Impossible d'installer grub2-theme-mint."

log_info "Mise à jour de GRUB..."
update-grub || log_warn "Échec de update-grub."

###############################################
# FIN
###############################################

log_success "Configuration personnelle appliquée pour $USER_NAME."
