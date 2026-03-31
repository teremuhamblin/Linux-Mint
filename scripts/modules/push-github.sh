#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../../core/logging.sh"
source "$(dirname "$0")/../../core/checks.sh"
source "$(dirname "$0")/../../core/utils.sh"

check_root || true  # Git peut être utilisé sans root

log_info "🔄 Synchronisation du dépôt Git local avec GitHub"

###############################################
# 1. Vérification de l’état du dépôt
###############################################

if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    log_error "Ce répertoire n'est pas un dépôt Git valide."
    exit 1
fi

BRANCH=$(git symbolic-ref --short HEAD)
log_info "Branche active : $BRANCH"

###############################################
# 2. Pull des dernières modifications
###############################################

log_info "Récupération des dernières modifications distantes..."
git pull --rebase || {
    log_error "Échec du git pull. Conflits possibles. Résolvez-les manuellement."
    exit 1
}

###############################################
# 3. Ajout et commit
###############################################

git add --all

echo
read -rp "📝 Entrez un message de commit : " COMMIT_MSG
COMMIT_MSG="${COMMIT_MSG:-Mise à jour automatique}"

git commit -m "$COMMIT_MSG" || {
    log_warn "Aucun changement à valider."
}

###############################################
# 4. Push
###############################################

log_info "Envoi vers la branche distante : $BRANCH"
git push -u origin "$BRANCH" || {
    log_error "Échec du push. Vérifiez vos droits ou conflits."
    exit 1
}

log_success "✅ Dépôt synchronisé avec succès sur GitHub."
