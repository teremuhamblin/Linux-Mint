#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/logging.sh"

run_cmd() {
    local cmd="$*"
    log_info "Exécution : $cmd"
    if ! eval "$cmd"; then
        log_error "Commande échouée : $cmd"
        exit 1
    fi
}

file_exists() {
    [[ -f "$1" ]]
}

dir_exists() {
    [[ -d "$1" ]]
}

ensure_dir() {
    local dir="$1"
    if ! dir_exists "$dir"; then
        log_info "Création du répertoire : $dir"
        mkdir -p "$dir"
    fi
}
