#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../core/logging.sh"
source "$(dirname "$0")/../core/checks.sh"

check_root
check_mint

HPC_PACKAGES=(
    mpich
    openmpi-bin
    libopenmpi-dev
    htop
    numactl
)

log_info "Installation des outils HPC..."
apt update -y
apt install -y "${HPC_PACKAGES[@]}"

log_success "Module HPC installé."
