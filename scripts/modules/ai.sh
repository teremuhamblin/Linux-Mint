#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../core/logging.sh"
source "$(dirname "$0")/../core/checks.sh"

check_root
check_mint

AI_PACKAGES=(
    python3
    python3-pip
    python3-venv
)

log_info "Installation de la base AI..."
apt update -y
apt install -y "${AI_PACKAGES[@]}"

log_info "Installation de bibliothèques Python AI de base..."
pip3 install --upgrade pip
pip3 install numpy scipy pandas scikit-learn jupyter

log_success "Module AI installé."
