📘 TOME 3 — VERSION INGÉNIERIE ULTIME

Sauvegardes • Dépannage • Personnalisation • Annexes avancées

---

💾 7. SAUVEGARDES — VERSION INGÉNIERIE AVANCÉE

---

7.1. Architecture des sauvegardes modernes

7.1.1. Vue d’ensemble (niveau entreprise)

`
+---------------------------------------------------------------+
|                        Poste Linux Mint                       |
|  /home | /etc | /var | /opt | /srv | /boot | LUKS | LVM       |
+-----------------------------+---------------------------------+
                              |
                              v
+---------------------------------------------------------------+
|                    Mécanismes de sauvegarde                   |
| Timeshift | rsync | Borg | Restic | Snapshots LVM | Btrfs     |
+-----------------------------+---------------------------------+
                              |
                              v
+---------------------------------------------------------------+
|                     Stockage de destination                   |
|  NAS | NFS | SMB | SSH | S3 | Backblaze | MinIO | Rclone     |
+-----------------------------+---------------------------------+
                              |
                              v
+---------------------------------------------------------------+
|                     Stratégies de rétention                   |
|  GFS (Grandfather-Father-Son) | Rotation | Versioning         |
+---------------------------------------------------------------+
`

---

7.2. Timeshift — Niveau ingénierie

7.2.1. Architecture Timeshift

`
+---------------------------+
| Timeshift (Frontend)      |
+-------------+-------------+
              |
              v
+---------------------------+
| Backend RSYNC / BTRFS     |
+-------------+-------------+
              |
              v
+---------------------------+
| Snapshots système         |
+---------------------------+
`

Recommandations ingénierie

- Utiliser BTRFS si possible (snapshots instantanés).  
- Sinon RSYNC avec exclusion fine.  
- Stocker les snapshots sur un disque séparé.  

---

7.3. Sauvegardes utilisateur — Niveau expert

7.3.1. rsync avancé

Synchronisation avec compression + chiffrement SSH

`bash
rsync -avz --delete -e "ssh -i ~/.ssh/id_rsa" /home user@backup:/data/home
`

Exclusion fine

`
--exclude=".cache"
--exclude="node_modules"
--exclude="*.iso"
`

---

7.3.2. BorgBackup — Niveau entreprise

Initialisation

`bash
borg init --encryption=repokey-blake2 /mnt/backup
`

Sauvegarde

`bash
borg create /mnt/backup::"mint-{now}" /home /etc /var
`

Vérification

`bash
borg check /mnt/backup
`

---

7.3.3. Restic — Sauvegardes cloud modernes

Sauvegarde vers S3

`bash
restic -r s3:https://s3.example.com/bucket backup /home
`

---

7.4. Clonage & migration — Niveau ingénierie

7.4.1. Architecture de migration disque

`
+---------------------------+
| Source Disk (ext4/LVM)    |
+-------------+-------------+
              |
              v
+---------------------------+
| Clonezilla / dd / rsync   |
+-------------+-------------+
              |
              v
+---------------------------+
| Destination Disk (NVMe)   |
+---------------------------+
`

Migration NVMe → NVMe

`bash
sudo dd if=/dev/nvme0n1 of=/dev/nvme1n1 bs=64K conv=noerror,sync
`

---

🛠️ 8. DÉPANNAGE — VERSION INGÉNIERIE ULTIME

---

8.1. Architecture du boot Linux Mint

`
+---------------------------------------------------------------+
|                         Firmware (UEFI)                       |
+-----------------------------+---------------------------------+
                              |
                              v
+---------------------------------------------------------------+
|                         Bootloader (GRUB2)                    |
+-----------------------------+---------------------------------+
                              |
                              v
+---------------------------------------------------------------+
|                     Kernel + initramfs                        |
+-----------------------------+---------------------------------+
                              |
                              v
+---------------------------------------------------------------+
|                     systemd (PID 1)                           |
+-----------------------------+---------------------------------+
                              |
                              v
+---------------------------------------------------------------+
|                     Services + Targets                        |
+---------------------------------------------------------------+
`

---

8.2. Dépannage GRUB — Niveau expert

8.2.1. Réinstaller GRUB (UEFI)

`bash
sudo mount /dev/sda2 /boot/efi
sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Mint
sudo update-grub
`

---

8.3. Dépannage matériel — Niveau ingénierie

8.3.1. Diagnostic GPU

NVIDIA

`bash
nvidia-smi
journalctl -u nvidia-persistenced
`

Intel

`bash
sudo intelgputop
`

---

8.3.2. Diagnostic Wi‑Fi

Voir les logs

`bash
dmesg | grep -i wifi
`

Voir les drivers chargés

`bash
lspci -k | grep -A 3 -i network
`

---

8.4. Dépannage logiciel — Niveau expert

8.4.1. Paquets cassés

`bash
sudo apt --fix-broken install
`

8.4.2. Forcer la réinstallation

`bash
sudo apt install --reinstall paquet
`

---

8.5. Diagnostic profond — Kernel, réseau, stockage

8.5.1. eBPF / bpftrace (niveau expert)

Voir les syscalls en temps réel

`bash
sudo bpftrace -e 'tracepoint:syscalls:sysenter* { @[probe] = count(); }'
`

---

8.5.2. Analyse réseau profonde

tcpdump

`bash
sudo tcpdump -i eth0 -nn -vv
`

Analyse DNS

`bash
sudo tcpdump -i eth0 port 53
`

---

8.5.3. Analyse stockage

IO en temps réel

`bash
iotop
`

Latence disque

`bash
sudo iostat -xz 1
`

---

🎨 9. PERSONNALISATION — VERSION INGÉNIERIE

---

9.1. Architecture Cinnamon avancée

`
+---------------------------------------------------------------+
|                         Cinnamon Shell                        |
+-----------------------------+---------------------------------+
                              |
                              v
+---------------------------------------------------------------+
|                     Muffin (Window Manager)                   |
+-----------------------------+---------------------------------+
                              |
                              v
+---------------------------------------------------------------+
|                     Nemo (File Manager)                       |
+---------------------------------------------------------------+
`

---

9.2. Optimisation système — Niveau expert

9.2.1. Optimisation SSD

`
sudo systemctl enable fstrim.timer
`

9.2.2. Swappiness

`
vm.swappiness=10
`

---

9.3. Développement — Version ingénierie

9.3.1. Stack DevOps complète

`
sudo apt install docker.io podman kubectl ansible terraform packer
`

---

📘 10. ANNEXES — VERSION INGÉNIERIE

---

10.1. Glossaire avancé
(avec termes SRE, DevOps, kernel, réseau…)

10.2. Commandes essentielles avancées
(ip, ss, bpftrace, perf, strace, lsof…)

10.3. Raccourcis clavier avancés
(Cinnamon, terminal, tmux…)

10.4. Arborescence Linux complète
(avec explications techniques)

10.5. FAQ avancée
(virtualisation, GPU, drivers, sécurité…)

---

🎯 TOME 3 — VERSION INGENIERIE ULTIME TERMINE
