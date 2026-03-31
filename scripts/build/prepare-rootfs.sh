#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../core/logging.sh"
source "$(dirname "$0")/../core/utils.sh"

ROOTFS_DIR="${1:-rootfs}"

log_info "Préparation du rootfs dans : $ROOTFS_DIR"
ensure_dir "$ROOTFS_DIR"

log_info "Extraction de la base Linux Mint (placeholder)..."
# Exemple à adapter :
# debootstrap --arch=amd64 vanessa "$ROOTFS_DIR" http://archive.ubuntu.com/ubuntu/

log_info "Application des modules Engineering dans le rootfs..."
# chroot "$ROOTFS_DIR" /bin/bash -c "/scripts/modules/devtools.sh"
# chroot "$ROOTFS_DIR" /bin/bash -c "/scripts/modules/cloud.sh"

log_success "Rootfs préparé (base)."
