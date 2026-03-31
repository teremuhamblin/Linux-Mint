#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../core/logging.sh"

ISO_NAME="mint-engineering.iso"
WORKDIR="build"

log_info "Préparation du répertoire de build..."
rm -rf "$WORKDIR"
mkdir -p "$WORKDIR"

log_info "Extraction de l'ISO Linux Mint..."
# Placeholder — à compléter selon ta version Mint
# xorriso -osirrox on -indev linuxmint.iso -extract / "$WORKDIR"

log_info "Application des modules Engineering..."
# ./modules/devtools.sh
# ./modules/hardening.sh

log_info "Reconstruction de l'ISO..."
# xorriso -as mkisofs -o "$ISO_NAME" "$WORKDIR"

log_success "ISO générée : $ISO_NAME"
