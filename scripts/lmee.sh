#!/usr/bin/env bash

###############################################################################
# Linux Mint Engineering Edition - Global Orchestrator
###############################################################################

set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PRESET_DIR="$BASE_DIR/presets"
LOG_FILE="/var/log/lmee-orchestrator.log"

log() {
    echo "[LMEE] $1" | tee -a "$LOG_FILE"
}

usage() {
    cat <<EOF
Usage: $0 <preset>

Available presets:
  - full
  - minimal
  - dev
  - sysadmin
  - custom

Example:
  $0 full
EOF
}

require_preset() {
    local preset="$1"
    local preset_file="$PRESET_DIR/$preset.sh"

    if [[ ! -f "$preset_file" ]]; then
        echo "Preset '$preset' not found in $PRESET_DIR"
        exit 1
    fi

    echo "$preset_file"
}

main() {
    if [[ $# -lt 1 ]]; then
        usage
        exit 1
    fi

    local preset="$1"
    local preset_file
    preset_file="$(require_preset "$preset")"

    log "Starting LMEE with preset: $preset"
    bash "$preset_file"
    log "LMEE preset '$preset' completed successfully."
}

main "$@"
