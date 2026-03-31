#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../core/logging.sh"
source "$(dirname "$0")/../core/checks.sh"
source "$(dirname "$0")/../core/utils.sh"

check_root
check_mint

log_info "Installation des applications standards (Mint Engineering Edition)"

###############################################
# DÉPÔTS EXTERNES (Spotify, Sublime Text, VirtualBox)
###############################################

log_info "Ajout du dépôt Spotify..."
curl -fsSL https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg \
    | gpg --dearmor | tee /usr/share/keyrings/spotify.gpg >/dev/null

echo "deb [signed-by=/usr/share/keyrings/spotify.gpg] http://repository.spotify.com stable non-free" \
    | tee /etc/apt/sources.list.d/spotify.list >/dev/null

log_info "Ajout du dépôt Sublime Text..."
curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg \
    | gpg --dearmor | tee /usr/share/keyrings/sublime.gpg >/dev/null

echo "deb [signed-by=/usr/share/keyrings/sublime.gpg] https://download.sublimetext.com/ apt/stable/" \
    | tee /etc/apt/sources.list.d/sublime-text.list >/dev/null

log_info "Ajout du dépôt VirtualBox..."
curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc \
    | gpg --dearmor | tee /usr/share/keyrings/virtualbox.gpg >/dev/null

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/virtualbox.gpg] https://download.virtualbox.org/virtualbox/debian jammy contrib" \
    | tee /etc/apt/sources.list.d/virtualbox.list >/dev/null

###############################################
# MISE À JOUR
###############################################

log_info "Mise à jour des dépôts..."
apt update -y

###############################################
# INSTALLATION DES APPLICATIONS
###############################################

APPS=(
    chromium
    dconf-editor
    flameshot
    gimp
    git
    inkscape
    meld
    obs-studio
    qbittorrent
    rxvt-unicode
    simplescreenrecorder
    spotify-client
    sublime-text
    telegram-desktop
    virtualbox
    vlc
)

log_info "Installation des applications..."
apt install -y "${APPS[@]}"

###############################################
# FIN
###############################################

log_success "Module Applications installé avec succès."
