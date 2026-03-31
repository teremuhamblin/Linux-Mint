📘 TOME 5 — VERSION INGÉNIERIE ULTIME

Sécurité Offensive • Défensive • Forensics • SOC • SIEM • EDR • Threat Hunting

---

🛡️ 16. ARCHITECTURE CYBER — VERSION INGÉNIERIE

---

16.1. Architecture SOC / SIEM pour Linux Mint

`
+--------------------------------------------------------------------------------+
|                                   Utilisateur                                  |
|                          Linux Mint Workstation (Admin)                        |
+-------------------------------------+------------------------------------------+
                                      |
                                      v
+--------------------------------------------------------------------------------+
|                               Endpoint Security                                |
|  UFW | Fail2ban | AppArmor | Auditd | eBPF Sensors | Sysmon-Linux              |
+-------------------------------------+------------------------------------------+
                                      |
                                      v
+--------------------------------------------------------------------------------+
|                               Log Collectors                                   |
|  journald | rsyslog | filebeat | fluentbit | promtail                          |
+-------------------------------------+------------------------------------------+
                                      |
                                      v
+--------------------------------------------------------------------------------+
|                               SIEM / Data Lake                                 |
|  ELK | Loki | Splunk | Sentinel | OpenSearch                                   |
+-------------------------------------+------------------------------------------+
                                      |
                                      v
+--------------------------------------------------------------------------------+
|                               SOC / Analysts                                   |
|  Threat Hunting | Incident Response | Forensics | Dashboards                    |
+--------------------------------------------------------------------------------+
`

---

16.2. Architecture EDR (Endpoint Detection & Response)

`
+--------------------------------------------------------------------------------+
|                               Linux Mint Endpoint                              |
+--------------------------------------------------------------------------------+
|  Syscalls | Processes | Network | File I/O | Kernel Events | eBPF              |
+-------------------------------------+------------------------------------------+
                                      |
                                      v
+--------------------------------------------------------------------------------+
|                               EDR Agent                                        |
|  eBPF Sensors | Auditd | Sysmon-Linux | Custom Hooks                           |
+-------------------------------------+------------------------------------------+
                                      |
                                      v
+--------------------------------------------------------------------------------+
|                               EDR Backend                                      |
|  Correlation | Alerts | Threat Intel | MITRE ATT&CK Mapping                    |
+--------------------------------------------------------------------------------+
`

---

🧨 17. SÉCURITÉ OFFENSIVE — VERSION INGÉNIERIE

(Pour comprendre, tester, auditer — pas pour nuire.)

---

17.1. Analyse réseau offensive (audit interne)

Scanner un réseau interne

`bash
sudo nmap -sV -O 192.168.1.0/24
`

Détection des services

`bash
sudo nmap -sC -sV 192.168.1.10
`

---

17.2. Analyse des ports locaux

`bash
sudo ss -tulnp
`

---

17.3. Analyse des binaires suspects

Vérifier les signatures ELF

`bash
readelf -h fichier
`

Vérifier les dépendances

`bash
ldd fichier
`

---

17.4. Analyse mémoire (Volatility)

Dump mémoire

`bash
sudo dd if=/dev/mem of=memdump.raw bs=1M
`

---

🛡️ 18. SÉCURITÉ DÉFENSIVE — VERSION INGÉNIERIE

---

18.1. Durcissement extrême (ANSSI + CIS + NIST)

18.1.1. Désactiver IPv6 si non utilisé

`
net.ipv6.conf.all.disable_ipv6 = 1
`

---

18.1.2. Durcissement PAM

Dans /etc/pam.d/common-password :

`
password requisite pam_pwquality.so retry=3 minlen=12 difok=4
`

---

18.1.3. Durcissement sudo

`
Defaults logfile="/var/log/sudo.log"
Defaults timestamp_timeout=0
`

---

18.2. Auditd — Surveillance avancée

18.2.1. Installer auditd

`bash
sudo apt install auditd audispd-plugins
`

18.2.2. Règles avancées

Surveiller /etc

`
-w /etc/ -p wa -k etc_changes
`

Surveiller les binaires sensibles

`
-w /usr/bin/sudo -p x -k sudo_exec
`

---

18.3. Sysmon for Linux (niveau expert)

Installation

`bash
sudo apt install sysmonforlinux
`

Exemple de règle

`
<EventFiltering>
  <ProcessCreate onmatch="exclude">
    <CommandLine condition="contains">apt</CommandLine>
  </ProcessCreate>
</EventFiltering>
`

---

🕵️ 19. THREAT HUNTING — VERSION INGÉNIERIE

---

19.1. Chasse aux anomalies (MITRE ATT&CK)

19.1.1. Processus anormaux

`bash
ps aux | grep -vE "bash|systemd|Xorg"
`

19.1.2. Ports suspects

`bash
sudo ss -tulnp | grep -vE "22|80|443"
`

---

19.2. Chasse aux rootkits

chkrootkit

`bash
sudo chkrootkit
`

rkhunter

`bash
sudo rkhunter --check
`

---

19.3. Chasse aux connexions persistantes

`bash
systemctl list-unit-files | grep enabled
`

---

🧬 20. FORENSICS — VERSION INGÉNIERIE

---

20.1. Forensics disque

Copier un disque en mode forensic

`bash
sudo dd if=/dev/sda of=image.dd bs=4M conv=noerror,sync
`

Vérifier l’intégrité

`bash
sha256sum image.dd
`

---

20.2. Forensics mémoire

Dump mémoire (LiME)

`bash
sudo insmod lime.ko "path=/mnt/memdump.lime format=lime"
`

---

20.3. Analyse journaux

Recherche IOC

`bash
journalctl | grep -Ei "suspicious|error|unauthorized"
`

---

🛰️ 21. MONITORING & OBSERVABILITÉ — VERSION INGÉNIERIE

---

21.1. Architecture monitoring avancée

`
+--------------------------------------------------------------------------------+
|                               Linux Mint Node                                  |
|  node_exporter | cadvisor | journald | eBPF probes                             |
+-------------------------------------+------------------------------------------+
                                      |
                                      v
+--------------------------------------------------------------------------------+
|                               Prometheus                                       |
+-------------------------------------+------------------------------------------+
                                      |
                                      v
+--------------------------------------------------------------------------------+
|                               Grafana                                          |
+--------------------------------------------------------------------------------+
`

---

21.2. node_exporter

`bash
sudo useradd -rs /bin/false node_exporter
`

---

21.3. Loki (logs modernes)

Configuration promtail

`
/var/log/*.log
journalctl -u ssh
`

---

⚙️ 22. SCRIPTS PROFESSIONNELS — VERSION INGÉNIERIE

---

22.1. Script de threat hunting automatisé

`

!/usr/bin/env bash
set -Eeuo pipefail

echo "=== THREAT HUNTING REPORT ==="

echo "[1] Processus suspects"
ps aux | grep -vE "bash|systemd|Xorg"

echo "[2] Ports suspects"
ss -tulnp | grep -vE "22|80|443"

echo "[3] Fichiers récemment modifiés"
find /etc -mtime -1

echo "[4] Services activés"
systemctl list-unit-files | grep enabled
`

---

22.2. Script forensic automatique

`

!/usr/bin/env bash
set -Eeuo pipefail

OUT="forensic$(hostname)$(date +%F).tar.gz"

mkdir forensic
cp /var/log/* forensic/
cp /etc/passwd forensic/
cp /etc/shadow forensic/
cp /etc/ssh/sshd_config forensic/

tar -czf "$OUT" forensic
`

---

🧾 23. CHECKLISTS CYBER — VERSION INGÉNIERIE

---

23.1. Checklist Blue Team

- [ ] UFW activé  
- [ ] Fail2ban configuré  
- [ ] AppArmor en mode enforce  
- [ ] Auditd actif  
- [ ] Sysmon actif  
- [ ] Journaux persistants  
- [ ] Sauvegardes testées  
- [ ] SSH durci  
- [ ] Services inutiles désactivés  

---

23.2. Checklist Forensics

- [ ] Dump mémoire  
- [ ] Dump disque  
- [ ] Hashs vérifiés  
- [ ] Journaux collectés  
- [ ] Processus analysés  
- [ ] Réseau analysé  

---

23.3. Checklist SOC

- [ ] Logs envoyés au SIEM  
- [ ] Dashboards opérationnels  
- [ ] Alertes MITRE ATT&CK  
- [ ] Threat intel intégrée  
- [ ] Playbooks IR prêts  

---

🎯 TOME 5 — VERSION INGÉNIERIE ULTIME TERMINÉ
