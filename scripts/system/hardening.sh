#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../core/logging.sh"
source "$(dirname "$0")/../core/checks.sh"

check_root

log_info "Activation du pare-feu UFW..."
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw --force enable

log_info "Désactivation de services inutiles..."
systemctl disable bluetooth.service || true

log_info "Configuration sysctl de base..."
cat <<EOF >/etc/sysctl.d/99-hardening.conf
kernel.kptr_restrict=2
kernel.dmesg_restrict=1
net.ipv4.conf.all.rp_filter=1
EOF

sysctl --system

log_success "Durcissement minimal appliqué."
