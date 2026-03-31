#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../core/logging.sh"
source "$(dirname "$0")/../core/checks.sh"

check_root
check_mint

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

log_success "Installation terminée."
