#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../core/logging.sh"

log_info "Mise à jour du système..."
apt update -y && apt upgrade -y

log_info "Nettoyage..."
apt autoremove -y
apt autoclean -y

log_success "Système mis à jour."
