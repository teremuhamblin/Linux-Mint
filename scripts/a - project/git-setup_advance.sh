#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../core/logging.sh"
source "$(dirname "$0")/../core/checks.sh"
source "$(dirname "$0")/../core/utils.sh"

check_root
check_mint

USER_NAME="${SUDO_USER:-$USER}"
USER_HOME="/home/$USER_NAME"

log_info "Assistant interactif de configuration Git (Linux Mint Engineering Edition)"
echo

###############################################
# 1. NOM D'UTILISATEUR
###############################################
read -rp "➡ Entrez votre nom complet pour Git : " GIT_NAME
git config --global user.name "$GIT_NAME"
log_info "Nom configuré : $GIT_NAME"

###############################################
# 2. EMAIL
###############################################
read -rp "➡ Entrez votre email Git : " GIT_EMAIL
git config --global user.email "$GIT_EMAIL"
log_info "Email configuré : $GIT_EMAIL"

###############################################
# 3. MODE DE PULL
###############################################
echo
echo "➡ Voulez-vous utiliser le mode de pull classique (merge) ou rebase ?"
select PULL_MODE in "merge (par défaut)" "rebase"; do
    case $PULL_MODE in
        "merge (par défaut)")
            git config --global pull.rebase false
            log_info "Mode pull : merge"
            break
            ;;
        "rebase")
            git config --global pull.rebase true
            log_info "Mode pull : rebase"
            break
            ;;
    esac
done

###############################################
# 4. ÉDITEUR PAR DÉFAUT
###############################################
echo
echo "➡ Choisissez votre éditeur Git par défaut :"
select EDITOR in "nano" "vim" "code (VSCode)" "ne rien changer"; do
    case $EDITOR in
        nano)
            git config --global core.editor "nano"
            log_info "Éditeur configuré : nano"
            break
            ;;
        vim)
            git config --global core.editor "vim"
            log_info "Éditeur configuré : vim"
            break
            ;;
        "code (VSCode)")
            git config --global core.editor "code --wait"
            log_info "Éditeur configuré : VSCode"
            break
            ;;
        "ne rien changer")
            log_info "Éditeur laissé par défaut"
            break
            ;;
    esac
done

###############################################
# 5. CONFIGURATION DU REMOTE
###############################################
echo
read -rp "➡ Voulez-vous configurer l'URL du remote GitHub pour ce projet ? (o/n) : " CONFIRM_REMOTE

if [[ "$CONFIRM_REMOTE" =~ ^[Oo]$ ]]; then
    PROJECT_NAME=$(basename "$(pwd)")
    read -rp "➡ Entrez votre nom d'utilisateur GitHub : " GH_USER
    read -rp "➡ Entrez le nom du dépôt (défaut : $PROJECT_NAME) : " GH_REPO
    GH_REPO="${GH_REPO:-$PROJECT_NAME}"

    REMOTE_URL="git@github.com:$GH_USER/$GH_REPO.git"
    git remote set-url origin "$REMOTE_URL" || true

    log_info "Remote configuré : $REMOTE_URL"
else
    log_info "Remote GitHub non modifié."
fi

###############################################
# 6. PUSH DEFAULT
###############################################
git config --global push.default simple
log_info "push.default configuré sur 'simple'"

###############################################
# FIN
###############################################
log_success "Configuration Git interactive terminée."
