#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../core/logging.sh"
source "$(dirname "$0")/../core/checks.sh"

check_root
check_mint

CLOUD_PACKAGES=(
    docker.io
    docker-compose
    kubectl
    helm
)

log_info "Installation des outils Cloud..."
apt update -y
apt install -y "${CLOUD_PACKAGES[@]}"

log_success "Module Cloud installé."
