#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../core/logging.sh"
source "$(dirname "$0")/../core/checks.sh"
source "$(dirname "$0")/../core/utils.sh"

check_root
check_mint

log_info "Installation des navigateurs et outils (Vivaldi, Chrome, Brave, VSCode, Alacritty)"

###############################################
# VIVALDI
###############################################
log_info "Ajout du dépôt Vivaldi..."

wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub \
    | gpg --dearmor | tee /usr/share/keyrings/vivaldi.gpg >/dev/null

echo "deb [signed-by=/usr/share/keyrings/vivaldi.gpg] https://repo.vivaldi.com/archive/deb/ stable main" \
    | tee /etc/apt/sources.list.d/vivaldi.list >/dev/null

###############################################
# GOOGLE CHROME
###############################################
log_info "Ajout du dépôt Google Chrome..."

wget -qO- https://dl.google.com/linux/linux_signing_key.pub \
    | gpg --dearmor | tee /usr/share/keyrings/google-chrome.gpg >/dev/null

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" \
    | tee /etc/apt/sources.list.d/google-chrome.list >/dev/null

###############################################
# BRAVE
###############################################
log_info "Ajout du dépôt Brave..."

curl -fsSL https://brave-browser-apt-release.s3.brave.com/brave-core.asc \
    | gpg --dearmor | tee /usr/share/keyrings/brave-browser.gpg >/dev/null

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/brave-browser.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \
    | tee /etc/apt/sources.list.d/brave-browser.list >/dev/null

###############################################
# VISUAL STUDIO CODE
###############################################
log_info "Ajout du dépôt VSCode..."

wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
    | gpg --dearmor | tee /usr/share/keyrings/vscode.gpg >/dev/null

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main" \
    | tee /etc/apt/sources.list.d/vscode.list >/dev/null

###############################################
# ALACRITTY
###############################################
log_info "Ajout du PPA Alacritty..."
add-apt-repository -y ppa:aslatter/ppa

###############################################
# INSTALLATION
###############################################
log_info "Mise à jour des dépôts..."
apt update -y

log_info "Installation des applications..."
apt install -y \
    vivaldi-stable \
    google-chrome-stable \
    brave-browser \
    code \
    alacritty

log_success "Module navigateurs & outils installé avec succès."
