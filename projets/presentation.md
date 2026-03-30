# 🐧 Projet Linux Mint  
## Installation, Sécurisation, Sauvegarde et Automatisation d’un Poste Linux Mint

---

# 🎯 1. Objectifs du projet

- Installer un système Linux Mint complet  
- Configurer l’environnement utilisateur  
- Sécuriser le système (UFW, sudo, utilisateurs…)  
- Mettre en place des sauvegardes fiables  
- Automatiser des tâches via des scripts Bash  
- Documenter l’ensemble du processus  
- Produire un rapport et une présentation professionnelle  

---

# 🧱 2. Pourquoi Linux Mint ?

- Distribution stable et légère  
- Basée sur Ubuntu (fiabilité, support)  
- Environnement Cinnamon : simple, moderne, intuitif  
- Idéale pour l’apprentissage de l’administration Linux  
- Large communauté et documentation abondante  

---

# 🛠 3. Méthodologie

## Matériel utilisé
- Machine virtuelle (VirtualBox)  
- 4 Go RAM, 30 Go disque  
- ISO Linux Mint Cinnamon  

## Outils
- Terminal Linux  
- Timeshift  
- Rsync / Grsync  
- UFW  
- Scripts Bash  

---

# 🚀 4. Installation de Linux Mint

## Étapes principales
1. Téléchargement de l’ISO  
2. Création d’une clé USB bootable  
3. Démarrage sur le support  
4. Choix de la langue et du partitionnement  
5. Installation du système  
6. Premier démarrage et mises à jour  

## Documentation
- Captures d’écran dans `images/installation/`  
- Guide détaillé dans `docs/installation/`  

---

# ⚙️ 5. Configuration du système

## Paramètres configurés
- Mise à jour du système  
- Pilotes matériels  
- Langue, clavier, fuseau horaire  
- Thème Cinnamon, applets, extensions  

## Logiciels installés
- LibreOffice  
- Firefox  
- VLC  
- htop, neofetch, gparted  

Documentation : `docs/configuration/`

---

# 🔐 6. Sécurisation du système

## Pare-feu UFW
- Activation  
- Règles essentielles  

## Gestion des utilisateurs
- Création d’un utilisateur standard  
- Explication du rôle de `sudo`  

## Mises à jour automatiques
- Configuration via MintUpdate  

Documentation : `docs/securite/`

---

# 💾 7. Sauvegardes et restauration

## Timeshift
- Snapshots système  
- Mode RSYNC  
- Restauration testée  

## Sauvegarde des données
- Rsync  
- Grsync  

Documentation : `docs/sauvegardes/`

---

# ⚡ 8. Automatisation

## Scripts Bash créés
- `maintenance.sh` : mise à jour + nettoyage + rapport  
- `backup.sh` : sauvegarde automatique  
- `monitoring.sh` : surveillance système  
- `install-packages.sh` : installation groupée  

## Cron (optionnel)
- Automatisation planifiée  

Documentation : `docs/automatisation/`

---

# 📊 9. Analyse du système

## Tests réalisés
- Performances (RAM, CPU, stockage)  
- Vérification des logs  
- Tests des scripts  
- Tests de restauration Timeshift  

## Résultats
- Système stable  
- Automatisation fonctionnelle  
- Sauvegardes fiables  

Documentation : `docs/analyse/`

---

# 🧠 10. Retour d’expérience

## Points positifs
- Linux Mint très accessible  
- Interface intuitive  
- Automatisation simple et efficace  
- Documentation claire  

## Difficultés rencontrées
- Permissions des scripts  
- Configuration initiale de Timeshift  
- Gestion des pilotes selon la VM  

## Solutions
- Scripts commentés  
- Tests réguliers  
- Documentation progressive  

---

# 🚀 11. Conclusion

Ce projet a permis de :
- déployer un système Linux Mint complet  
- le sécuriser  
- l’automatiser  
- le documenter de manière professionnelle  

Il constitue une base solide pour l’apprentissage de l’administration Linux.

---

# 🌱 12. Pistes d’amélioration

- Mise en place d’un serveur web (Nginx/Apache)  
- Installation de Docker / Podman  
- Partage réseau Samba  
- Monitoring avancé  
- CI/CD GitHub Actions  
- Scripts Bash plus avancés  

---

# 📁 Annexes

- Scripts Bash (`scripts/`)  
- Fichiers de configuration (`config/`)  
- Captures d’écran (`images/`)  
- Rapport complet (`projet/rapport.md`)
