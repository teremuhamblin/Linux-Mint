#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../core/logging.sh"
source "$(dirname "$0")/../core/checks.sh"
source "$(dirname "$0")/../core/utils.sh"

check_root
check_mint

USER_NAME="${SUDO_USER:-$USER}"
USER_HOME="/home/$USER_NAME"

log_info "Configuration Git pour Linux Mint Engineering Edition"

###############################################
# CONFIGURATION GIT GLOBALE
###############################################

log_info "Configuration Git globale..."

git config --global pull.rebase false
git config --global push.default simple

# Ces valeurs doivent être personnalisées par l'utilisateur
git config --global user.name "$USER_NAME"
git config --global user.email "$USER_NAME@example.com"

###############################################
# CONFIGURATION DE L'ÉDITEUR
###############################################

log_info "Définition de nano comme éditeur Git par défaut..."
git config --global core.editor "nano"

###############################################
# CONFIGURATION DU REMOTE (OPTIONNEL)
###############################################

PROJECT_NAME=$(basename "$(pwd)")

log_info "Configuration du remote Git (optionnel)..."

# Exemple : adapter à ton organisation GitHub
git remote set-url origin "git@github.com:Teremu/$PROJECT_NAME.git" || true

###############################################
# FIN
###############################################

log_success "Configuration Git terminée."
