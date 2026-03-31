#!/usr/bin/env bash

###############################################################################
# Linux Mint Engineering Edition - ZSH Module
# Installs ZSH, plugins, and configures Oh-My-Zsh safely and cleanly.
###############################################################################

set -euo pipefail

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------
THEME="random"
LOG_FILE="/var/log/lmee-zsh.log"

# -----------------------------------------------------------------------------
# Utils
# -----------------------------------------------------------------------------
log() {
    echo "[ZSH] $1" | tee -a "$LOG_FILE"
}

require_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root."
        exit 1
    fi
}

require_internet() {
    if ! ping -c1 github.com &>/dev/null; then
        log "No internet connection. Aborting."
        exit 1
    fi
}

# -----------------------------------------------------------------------------
# Install packages
# -----------------------------------------------------------------------------
install_packages() {
    log "Installing ZSH and plugins..."
    apt update -y
    apt install -y zsh git wget zsh-syntax-highlighting zsh-autosuggestions
}

# -----------------------------------------------------------------------------
# Install Oh-My-Zsh safely
# -----------------------------------------------------------------------------
install_oh_my_zsh() {
    local user_home
    user_home=$(eval echo "~$SUDO_USER")

    if [[ ! -d "$user_home/.oh-my-zsh" ]]; then
        log "Installing Oh-My-Zsh..."
        sudo -u "$SUDO_USER" wget -q https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O /tmp/omz.sh
        sudo -u "$SUDO_USER" bash /tmp/omz.sh --unattended
    else
        log "Oh-My-Zsh already installed. Skipping."
    fi
}

# -----------------------------------------------------------------------------
# Configure ZSH theme
# -----------------------------------------------------------------------------
configure_theme() {
    local user_home
    user_home=$(eval echo "~$SUDO_USER")

    log "Configuring ZSH theme to '$THEME'..."
    sudo -u "$SUDO_USER" sed -i "s|^ZSH_THEME=.*|ZSH_THEME=\"$THEME\"|" "$user_home/.zshrc"
}

# -----------------------------------------------------------------------------
# Set ZSH as default shell
# -----------------------------------------------------------------------------
set_default_shell() {
    log "Setting ZSH as default shell for $SUDO_USER..."
    chsh -s /bin/zsh "$SUDO_USER"
}

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------
main() {
    require_root
    require_internet
    install_packages
    install_oh_my_zsh
    configure_theme
    set_default_shell

    log "ZSH installation and configuration complete."
}

main "$@"
