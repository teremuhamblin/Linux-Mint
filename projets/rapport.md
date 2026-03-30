# 🐧 Projet Linux Mint  
## Installation, Sécurisation, Sauvegarde et Automatisation d’un Poste Linux Mint

---

# 1. Introduction

Linux Mint est une distribution GNU/Linux basée sur Ubuntu, reconnue pour sa stabilité, sa simplicité d’utilisation et son environnement de bureau Cinnamon.  
Ce projet a pour objectif de mettre en place un poste Linux Mint complet, sécurisé, sauvegardé et automatisé, tout en documentant chaque étape de manière professionnelle.

## 1.1 Objectifs du projet
- Installer Linux Mint sur une machine réelle ou virtuelle  
- Configurer l’environnement utilisateur  
- Gérer les logiciels et les mises à jour  
- Sécuriser le système  
- Mettre en place des sauvegardes système et données  
- Automatiser des tâches via des scripts Bash  
- Analyser le fonctionnement du système  
- Produire un rapport final et une présentation  

## 1.2 Livrables
- Documentation complète (`docs/`)  
- Scripts Bash (`scripts/`)  
- Fichiers de configuration (`config/`)  
- Rapport final (`projet/rapport.md`)  
- Présentation (`projet/presentation.md`)  
- Captures d’écran (`images/`)  

---

# 2. Méthodologie

## 2.1 Matériel utilisé
- **Machine virtuelle** (VirtualBox)  
- 4 Go de RAM  
- 30 Go de stockage  
- ISO Linux Mint Cinnamon  

## 2.2 Outils utilisés
- Rufus / Etcher / Ventoy (création USB)  
- Terminal Linux  
- Timeshift  
- Rsync / Grsync  
- UFW  
- Scripts Bash  

## 2.3 Organisation du projet
Le projet est structuré en 5 dossiers principaux :
- `config/` : fichiers de configuration  
- `docs/` : documentation détaillée  
- `images/` : captures d’écran  
- `projet/` : rapport et présentation  
- `scripts/` : scripts Bash  

---

# 3. Installation de Linux Mint

## 3.1 Téléchargement de l’ISO
L’ISO officielle est récupérée depuis le site de Linux Mint.

## 3.2 Création de la clé USB bootable
Outils possibles :
- Rufus  
- Etcher  
- Ventoy  

## 3.3 Installation du système
Étapes principales :
1. Démarrage sur la clé USB  
2. Choix de la langue  
3. Partitionnement automatique ou manuel  
4. Installation du système  
5. Redémarrage  

## 3.4 Documentation
Toutes les captures d’écran sont stockées dans `images/installation/`.

---

# 4. Configuration du système

## 4.1 Mise à jour du système
- Utilisation de l’Update Manager  
- Commandes terminal :
  ```
  sudo apt update
  sudo apt upgrade -y
  ```

## 4.2 Pilotes
Configuration via **Driver Manager**.

## 4.3 Paramètres système
- Langue  
- Clavier  
- Date/heure  
- Thème Cinnamon  
- Applets et extensions  

## 4.4 Logiciels installés
- LibreOffice  
- Firefox  
- VLC  
- htop, neofetch, gparted  

## 4.5 Documentation
Stockée dans `docs/configuration/`.

---

# 5. Sécurisation du système

## 5.1 Pare-feu UFW
Activation :
```
sudo ufw enable
```

Règles de base :
```
sudo ufw allow ssh
sudo ufw status
```

## 5.2 Gestion des utilisateurs
Création d’un utilisateur standard :
```
sudo adduser utilisateur
sudo usermod -aG sudo utilisateur
```

## 5.3 Mises à jour automatiques
Configuration via MintUpdate.

## 5.4 Bonnes pratiques
- Mots de passe robustes  
- Pas d’utilisation du compte root  
- Installation de logiciels fiables  

---

# 6. Sauvegardes et restauration

## 6.1 Timeshift
Configuration :
- Mode RSYNC  
- Snapshots automatiques  
- Exclusion des données personnelles  

## 6.2 Sauvegarde des données
Avec `rsync` :
```
rsync -avh --delete ~/Documents /media/backup/
```

Ou Grsync (interface graphique).

## 6.3 Documentation
Stockée dans `docs/sauvegardes/`.

---

# 7. Automatisation

## 7.1 Scripts Bash

### Script de maintenance (`maintenance.sh`)
- Mise à jour  
- Nettoyage  
- Rapport système  

### Script de sauvegarde (`backup.sh`)
- Sauvegarde automatique des données  

### Script de monitoring (`monitoring.sh`)
- RAM  
- CPU  
- Stockage  

## 7.2 Cron (optionnel)
Exécution automatique :
```
crontab -e
```

---

# 8. Analyse du système

## 8.1 Performances
- RAM au repos  
- CPU au repos  
- Temps de démarrage  

## 8.2 Logs
Analyse via :
```
journalctl
```

## 8.3 Tests des scripts
- Exécution  
- Vérification des permissions  
- Vérification des résultats  

---

# 9. Résultats et retour d’expérience

## 9.1 Points positifs
- Système stable  
- Interface intuitive  
- Automatisation efficace  
- Sauvegardes fiables  

## 9.2 Difficultés rencontrées
- Gestion des pilotes selon le matériel  
- Permissions des scripts  
- Configuration initiale de Timeshift  

## 9.3 Solutions apportées
- Documentation détaillée  
- Scripts commentés  
- Tests réguliers  

---

# 10. Conclusion et pistes d’amélioration

## 10.1 Conclusion
Ce projet a permis de mettre en place un poste Linux Mint complet, sécurisé, automatisé et documenté.  
Il constitue une base solide pour l’apprentissage de l’administration système.

## 10.2 Améliorations possibles
- Mise en place d’un serveur web (Nginx/Apache)  
- Installation de Docker  
- Partage réseau Samba  
- Monitoring avancé  
- CI/CD GitHub Actions  

---

# Annexes
- Captures d’écran  
- Scripts Bash  
- Fichiers de configuration
