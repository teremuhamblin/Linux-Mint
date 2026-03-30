# Projet FIL ROUGE
> `Autour de Linux Mint concret, structuré, présentable (rapport + démo).`

Je te propose un projet complet :  
> `“Installation, sécurisation et automatisation d’un poste Linux Mint pour un usage quotidien”`

---

1. Objectif du projet

- But général :  
  Mettre en place un système Linux Mint prêt pour un usage réel (bureautique, web, multimédia), sécurisé, sauvegardé et partiellement automatisé.
- Livrables :  
  - Un rapport (PDF ou Markdown)  
  - Des captures d’écran / commandes  
  - Éventuellement une courte démo (vidéo ou présentation)

---

2. Plan global du projet

1. Choix et installation de Linux Mint
   - Télécharger l’ISO de Linux Mint (édition Cinnamon de préférence).
   - Créer une clé USB bootable (Rufus, Ventoy, Etcher…).
   - Installer Mint sur une machine réelle ou une VM (VirtualBox, VMware…).
   - Documenter : captures d’écran des étapes d’installation, choix de partitionnement, langue, etc.

2. Prise en main et configuration de base
   - Configurer :
     - Mises à jour (Update Manager)
     - Pilotes (Driver Manager)
     - Langue / clavier / heure
   - Personnaliser :
     - Thème, fond d’écran, applets, menu.
   - Documenter : ce que tu as changé et pourquoi.

3. Gestion des logiciels
   - Utiliser :
     - Gestionnaire de logiciels (GUI)
     - APT en ligne de commande
   - Installer un “pack utilisateur” :
     - Bureautique : LibreOffice (si pas déjà complet)
     - Web : Firefox, éventuellement un autre navigateur
     - Multimédia : VLC, outils audio/vidéo
     - Outils système : htop, neofetch, gparted…
   - Expliquer la différence entre :
     - .deb, Flatpak, Snap (si tu en parles)
     - installation via GUI vs terminal

4. Sécurisation de base
   - Activer/configurer :
     - Pare-feu : ufw ou interface graphique (Gufw)
     - Mises à jour automatiques (ou au moins régulières)
   - Créer un utilisateur standard (non admin) pour l’usage quotidien.
   - Expliquer :
     - Principe de sudo
     - Pourquoi on évite de travailler en root
   - Optionnel :  
     - Activer le chiffrement du dossier personnel (si tu réinstalles)  
     - Parler des bonnes pratiques (mots de passe, sauvegardes, etc.)

5. Sauvegarde et restauration
   - Mettre en place :
     - Timeshift pour les snapshots système
     - Une sauvegarde des données (par ex. avec rsync ou un outil graphique comme Grsync)
   - Démontrer :
     - Création d’un snapshot
     - Restauration simulée (ou réelle) d’un snapshot
   - Expliquer la différence :
     - Sauvegarde système vs sauvegarde de données utilisateur

6. Automatisation simple en ligne de commande
   - Créer un petit script Bash pour :
     - Mettre à jour le système
     - Nettoyer le cache APT
     - Afficher un petit rapport (espace disque, mises à jour, etc.)
   - Exemple d’idée de script maintenance.sh :
     - sudo apt update && sudo apt upgrade -y
     - sudo apt autoremove -y && sudo apt clean
     - df -h pour l’espace disque
   - Rendre le script exécutable, le placer dans ~/bin ou /usr/local/bin.
   - Optionnel :  
     - Ajouter une tâche cron ou un rappel pour l’exécuter régulièrement.

7. Observation et analyse
   - Utiliser des outils comme :
     - top / htop pour les processus
     - df -h pour le stockage
     - journalctl ou l’outil de logs graphique
   - Noter :
     - Consommation RAM/CPU au repos
     - Temps de démarrage approximatif
     - Stabilité, problèmes rencontrés

---

3. Structure possible du rapport

1. Introduction
   - Présentation de Linux Mint  
   - Pourquoi ce projet, quels objectifs

2. Méthodologie
   - Matériel utilisé (PC/VM, RAM, disque…)  
   - Version de Linux Mint  
   - Outils utilisés (clé USB, VirtualBox, etc.)

3. Installation
   - Étapes + captures d’écran  
   - Choix techniques (partitionnement, langue, environnement de bureau)

4. Configuration et logiciels
   - Paramètres système  
   - Logiciels installés et justification

5. Sécurité et sauvegarde
   - Pare-feu, mises à jour  
   - Timeshift, sauvegardes de données

6. Automatisation
   - Script(s) Bash  
   - Explication du code  
   - Exemple d’exécution

7. Résultats et retour d’expérience
   - Ce qui fonctionne bien  
   - Problèmes rencontrés et solutions  
   - Ce que tu as appris

8. Conclusion et pistes d’amélioration
   - Idées pour aller plus loin (serveur, Docker, scripts plus avancés, etc.)

---

4. Pour aller plus loin (idées d’extensions)

- Créer un petit serveur local (Nginx/Apache) sur Mint.  
- Mettre en place un partage réseau (Samba) pour échanger avec des machines Windows.  
- Créer plusieurs scripts Bash (sauvegarde automatique, monitoring simple, etc.).  
- Documenter tout dans un dépôt Git (GitHub/GitLab) comme un vrai projet.

---
