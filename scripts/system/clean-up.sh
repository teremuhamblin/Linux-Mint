#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../core/logging.sh"
source "$(dirname "$0")/../core/checks.sh"

check_root

log_info "Nettoyage des paquets inutiles..."
apt autoremove -y
apt autoclean -y

log_info "Nettoyage des fichiers temporaires..."
rm -rf /tmp/* /var/tmp/* || true

log_success "Nettoyage système terminé."
