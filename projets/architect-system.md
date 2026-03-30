# 🐧 Projet Linux Mint  
## Déploiement, Durcissement, Automatisation et Observabilité d’un Poste Linux Mint

---

# 1. Architecture Système & Conception

## 1.1 Base OS
- Distribution : Linux Mint Cinnamon (Ubuntu LTS-based)
- Kernel : Linux 5.x (HWE possible)
- Init system : systemd
- Filesystem : ext4 (option Btrfs pour snapshots natifs)
- Logging : systemd-journald + rotation persistante
- Package managers : APT (dpkg), Flatpak (sandboxing)

## 1.2 Architecture logique
- Partitionnement recommandé :
  - `/` (système)
  - `/home` (données utilisateur)
  - `/var` isolé (logs, caches)
  - Swap (2–4 Go selon RAM)
- Snapshots système via Timeshift (RSYNC ou Btrfs)
- Scripts dans `/usr/local/bin` (root) ou `~/.local/bin` (user)

## 1.3 Services critiques
- systemd units :
  - `NetworkManager.service`
  - `ufw.service`
  - `systemd-timesyncd.service`
  - `cron.service`
- Désactivation des services non essentiels :
  ```
  systemctl disable bluetooth.service
  systemctl disable cups.service
  ```

---

# 2. Durcissement & Sécurité Avancée

## 2.1 Pare-feu UFW (niveau entreprise)
- Politique par défaut :
  ```
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  ```
- Règles strictes :
  ```
  sudo ufw allow 22/tcp comment "SSH"
  sudo ufw limit 22/tcp
  sudo ufw deny 23/tcp
  ```

## 2.2 SSH Hardening (si activé)
- `/etc/ssh/sshd_config` :
  ```
  PermitRootLogin no
  PasswordAuthentication no
  PubkeyAuthentication yes
  MaxAuthTries 3
  AllowUsers admin
  ```
- Clés RSA/ED25519 uniquement

## 2.3 Gestion des privilèges
- Aucun login root
- Utilisation stricte de `sudo`
- Journalisation des commandes sudo :
  ```
  Defaults logfile="/var/log/sudo.log"
  ```

## 2.4 Durcissement kernel (sysctl)
- `/etc/sysctl.d/99-hardening.conf` :
  ```
  kernel.kptr_restrict=2
  kernel.dmesg_restrict=1
  net.ipv4.conf.all.rp_filter=1
  net.ipv4.tcp_syncookies=1
  net.ipv4.conf.all.accept_redirects=0
  net.ipv4.conf.all.send_redirects=0
  ```

## 2.5 Sécurité applicative
- Flatpak sandboxing
- Vérification des signatures APT :
  ```
  apt-key list
  ```

---

# 3. Automatisation & Orchestration

## 3.1 Scripts d’exploitation
### maintenance.sh
- Update + upgrade
- Nettoyage APT
- Vérification des services critiques
- Rapport système (CPU, RAM, I/O)

### backup.sh
- Rsync incrémental
- Exclusions via fichier `.rsync-exclude`
- Journalisation dans `/var/log/backup.log`

### monitoring.sh
- Charge CPU (1/5/15 min)
- RAM utilisée
- I/O via `iostat`
- Processus gourmands (top 5)

## 3.2 Cron jobs
```
0 3 * * * /usr/local/bin/maintenance.sh
0 */6 * * * /usr/local/bin/backup.sh
*/10 * * * * /usr/local/bin/monitoring.sh
```

## 3.3 Automatisation avancée (optionnel)
- Déploiement via Ansible
- Templates Jinja2 pour config
- Playbooks :
  - installation paquets
  - durcissement
  - configuration UFW
  - déploiement scripts

---

# 4. Observabilité & Diagnostic

## 4.1 Logs système
- Analyse des erreurs critiques :
  ```
  journalctl -p 3 -xb
  ```
- Logs persistants :
  ```
  mkdir -p /var/log/journal
  ```

## 4.2 Supervision locale
- `htop` : processus
- `iotop` : I/O
- `dstat` : ressources globales
- `ss -tulpen` : ports ouverts
- `systemctl --failed` : services en échec

## 4.3 Analyse réseau
- Table de routage :
  ```
  ip route
  ```
- Connexions actives :
  ```
  ss -antp
  ```

## 4.4 Analyse sécurité
- Vérification des permissions :
  ```
  find / -perm -4000 -type f 2>/dev/null
  ```
- Vérification des services exposés :
  ```
  nmap -sV localhost
  ```

---

# 5. Sauvegardes & Continuité de Service

## 5.1 Snapshots système (Timeshift)
- Mode RSYNC
- Snapshots automatiques
- Restauration testée en environnement isolé

## 5.2 Sauvegarde des données
- Rsync incrémental :
  ```
  rsync -avh --delete --exclude-from=/etc/rsync-exclude ~/ /mnt/backup/
  ```

## 5.3 Stratégie de continuité
- Système : snapshots fréquents
- Données : sauvegardes incrémentales
- Stockage externe ou réseau recommandé

---

# 6. Performance & Optimisation

## 6.1 Optimisation kernel
- Scheduler CFS
- Swappiness :
  ```
  vm.swappiness=10
  ```

## 6.2 Optimisation APT
- Cache local
- Nettoyage automatique

## 6.3 Optimisation Cinnamon
- Désactivation animations
- Réduction des services de session

---

# 7. Résultats Techniques

## Points forts
- Poste durci selon standards Linux
- Automatisation complète des tâches critiques
- Observabilité avancée
- Sauvegardes fiables et testées
- Architecture reproductible

## Points faibles
- Monitoring limité sans stack Prometheus
- Pas de gestion centralisée des logs
- Pas de conteneurisation native

---

# 8. Pistes d’évolution (niveau expert)

- Déploiement Ansible complet
- Monitoring Prometheus + Grafana
- Centralisation logs (ELK / Loki)
- Conteneurisation Docker/Podman
- Sécurité avancée (AppArmor, SELinux)
- Chiffrement LUKS
- CI/CD GitHub Actions pour scripts Bash
