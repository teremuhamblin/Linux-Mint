#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../core/logging.sh"
source "$(dirname "$0")/../core/checks.sh"

check_root
check_mint

DEV_PACKAGES=(
    git
    build-essential
    cmake
    ninja-build
    gdb
    strace
    ltrace
    valgrind
    clang
    clang-format
)

log_info "Installation des outils de développement..."
apt update -y
apt install -y "${DEV_PACKAGES[@]}"

log_success "Module DevTools installé."
