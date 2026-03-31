#!/usr/bin/env bash

###############################################################################
# LMEE Preset: Full Linux Mint Engineering Edition
# Installs ALL modules required for a complete engineering environment.
###############################################################################

set -euo pipefail

MODULES_DIR="$(dirname "$0")/../modules"
LOG_FILE="/var/log/lmee-full-preset.log"

log() {
    echo "[LMEE-FULL] $1" | tee -a "$LOG_FILE"
}

run_module() {
    local module_path="$1"

    if [[ -f "$module_path" ]]; then
        log "Running module: $module_path"
        bash "$module_path"
    else
        log "ERROR: Module not found: $module_path"
        exit 1
    fi
}

log "Starting FULL Linux Mint Engineering Edition preset..."

# -----------------------------------------------------------------------------
# Shell & Terminal
# -----------------------------------------------------------------------------
run_module "$MODULES_DIR/shell/zsh.sh"

# -----------------------------------------------------------------------------
# Developer Tools
# -----------------------------------------------------------------------------
run_module "$MODULES_DIR/dev/dev-tools.sh"

# -----------------------------------------------------------------------------
# Sysadmin Tools
# -----------------------------------------------------------------------------
run_module "$MODULES_DIR/sysadmin/sysadmin-tools.sh"

# -----------------------------------------------------------------------------
# Network Tools
# -----------------------------------------------------------------------------
run_module "$MODULES_DIR/network/network-tools.sh"

# -----------------------------------------------------------------------------
# Security & Hardening
# -----------------------------------------------------------------------------
run_module "$MODULES_DIR/security/hardening.sh"

# -----------------------------------------------------------------------------
# System Optimizations
# -----------------------------------------------------------------------------
run_module "$MODULES_DIR/system/optimizations.sh"

# -----------------------------------------------------------------------------
# Engineering Applications Suite
# -----------------------------------------------------------------------------
run_module "$MODULES_DIR/apps/engineering-suite.sh"

log "FULL Linux Mint Engineering Edition preset completed successfully."
