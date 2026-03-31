#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/logging.sh"

check_root() {
    if [[ $EUID -ne 0 ]]; then
        log_error "Ce script doit être exécuté en root."
        exit 1
    fi
}

check_mint() {
    if ! grep -qi "Linux Mint" /etc/os-release; then
        log_error "Ce système n'est pas Linux Mint."
        exit 1
    fi
}

check_internet() {
    if ! ping -c1 1.1.1.1 &>/dev/null; then
        log_warn "Pas d'accès Internet."
    fi
}
