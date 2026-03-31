#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../core/logging.sh"
source "$(dirname "$0")/../core/checks.sh"
source "$(dirname "$0")/../core/utils.sh"

check_root
check_mint

USER_NAME="${SUDO_USER:-$USER}"
USER_HOME="/home/$USER_NAME"

# Racine du projet (2 niveaux au-dessus du module)
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

log_info "Initialisation du module de personnalisation (stable & optimisé)"
log_info "Utilisateur ciblé : $USER_NAME"
log_info "Répertoire projet : $PROJECT_ROOT"

###############################################
# 1. CRÉATION DES DOSSIERS (optimisée)
###############################################

USER_DIRS=(
    "$USER_HOME/.bin"
    "$USER_HOME/.fonts"
    "$USER_HOME/.icons"
    "$USER_HOME/.themes"
    "$USER_HOME/.local/share/icons"
    "$USER_HOME/.local/share/themes"
    "$USER_HOME/.config"
    "$USER_HOME/.config/gtk-3.0"
    "$USER_HOME/.config/variety"
    "$USER_HOME/.config/variety/scripts"
    "$USER_HOME/DATA"
    "$USER_HOME/Insync"
    "$USER_HOME/Projects"
)

log_info "Création des dossiers personnels..."

for dir in "${USER_DIRS[@]}"; do
    ensure_dir "$dir"
    chown -R "$USER_NAME":"$USER_NAME" "$dir"
done

###############################################
# 2. INSTALLATION DES CONFIGS PERSONNELLES
###############################################

copy_config() {
    local src="$1"
    local dest="$2"

    if [[ -f "$src" ]]; then
        ensure_dir "$(dirname "$dest")"
        cp "$src" "$dest"
        chown "$USER_NAME":"$USER_NAME" "$dest"
        log_info "Copié : $(basename "$src")"
    else
        log_warn "Fichier introuvable : $src"
    fi
}

log_info "Installation des configurations personnelles..."

copy_config "$PROJECT_ROOT/personal/thunar/uca.xml" \
            "$USER_HOME/.config/Thunar/uca.xml"

copy_config "$PROJECT_ROOT/personal/variety/variety.conf" \
            "$USER_HOME/.config/variety/variety.conf"

copy_config "$PROJECT_ROOT/personal/variety/set_wallpaper" \
            "$USER_HOME/.config/variety/scripts/set_wallpaper"

chmod +x "$USER_HOME/.config/variety/scripts/set_wallpaper" || true

copy_config "$PROJECT_ROOT/personal/bash/bashrc" \
            "$USER_HOME/.bashrc"

###############################################
# 3. CONFIGURATION GRUB (fiable & propre)
###############################################

log_info "Configuration GRUB..."

GRUB_FILE="/etc/default/grub"

if [[ -f "$GRUB_FILE" ]]; then
    sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=2/' "$GRUB_FILE"
    log_info "GRUB_TIMEOUT réglé à 2 secondes."
else
    log_warn "Fichier GRUB introuvable."
fi

log_info "Installation du thème GRUB Mint..."
apt update -y
apt install -y grub2-theme-mint || log_warn "Installation du thème GRUB échouée."

log_info "Mise à jour de GRUB..."
update-grub || log_warn "update-grub a rencontré un problème."

###############################################
# FIN
###############################################

log_success "Personnalisation terminée avec succès (version stable & optimisée)."
