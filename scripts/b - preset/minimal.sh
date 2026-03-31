#!/usr/bin/env bash

set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MODULES_DIR="$BASE_DIR/modules"
CONFIG_DIR="$BASE_DIR/config"
LOG_FILE="/var/log/lmee-minimal.log"

source "$CONFIG_DIR/modules.conf"

log() {
    echo "[LMEE-MINIMAL] $1" | tee -a "$LOG_FILE"
}

run_module() {
    local rel_path="$1"
    local module_path="$MODULES_DIR/$rel_path"

    if [[ -f "$module_path" ]]; then
        log "Running module: $rel_path"
        bash "$module_path"
    else
        log "ERROR: Module not found: $rel_path"
        exit 1
    fi
}

main() {
    log "Starting MINIMAL preset..."

    for module in "${PRESET_minimal[@]}"; do
        run_module "$module"
    done

    log "MINIMAL preset completed successfully."
}

main "$@"
