📘 TOME 6 — VERSION INGÉNIERIE ULTIME

Kernel Hacking • Reverse Engineering • Exploit Mitigation • Hardening Extrême

---

🧬 24. KERNEL HACKING — VERSION EXPERT

---

24.1. Architecture interne du noyau Linux (niveau chercheur)

`
+--------------------------------------------------------------------------------+
|                                 User Space                                     |
|  Applications | Shell | Services | Containers | VMs                            |
+-------------------------------------+------------------------------------------+
                                      |
                                      v
+--------------------------------------------------------------------------------+
|                               System Call API                                  |
|  read() | write() | open() | clone() | execve() | ioctl()                      |
+-------------------------------------+------------------------------------------+
                                      |
                                      v
+--------------------------------------------------------------------------------+
|                               Kernel Space                                     |
|                                                                                |
|  +-------------------+   +-------------------+   +---------------------------+ |
|  | Process Scheduler |   | Memory Manager    |   | Virtual File System (VFS)| |
|  | CFS / RT / DL     |   | SLAB / SLUB       |   | ext4 / xfs / btrfs       | |
|  +-------------------+   +-------------------+   +---------------------------+ |
|                                                                                |
|  +-------------------+   +-------------------+   +---------------------------+ |
|  | Networking Stack  |   | Block I/O Layer   |   | Security Modules (LSM)   | |
|  | Netfilter / eBPF  |   | blk-mq / io_uring |   | AppArmor / SELinux       | |
|  +-------------------+   +-------------------+   +---------------------------+ |
|                                                                                |
|  +-------------------+   +-------------------+   +---------------------------+ |
|  | Drivers (GPU/NIC) |   | Namespaces        |   | cgroups v2               | |
|  | DRM / KMS / i915  |   | PID / NET / UTS   |   | CPU / IO / MEM           | |
|  +-------------------+   +-------------------+   +---------------------------+ |
+--------------------------------------------------------------------------------+
`

---

24.2. Compilation avancée du noyau (mode recherche)

1. Récupérer les sources

`bash
git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
cd linux
`

2. Charger la config Mint

`bash
cp /boot/config-$(uname -r) .config
make oldconfig
`

3. Activer les options de debug kernel

`
CONFIGDEBUGKERNEL=y
CONFIG_KASAN=y
CONFIG_KCOV=y
CONFIGDEBUGINFO_DWARF4=y
CONFIGGDBSCRIPTS=y
`

4. Compiler

`bash
make -j$(nproc)
sudo make modules_install
sudo make install
`

---

24.3. Instrumentation du noyau (ftrace, perf, eBPF)

24.3.1. ftrace — Tracer les fonctions kernel

`bash
echo function > /sys/kernel/debug/tracing/current_tracer
echo dosysopen > /sys/kernel/debug/tracing/setftracefilter
cat /sys/kernel/debug/tracing/trace
`

---

24.3.2. perf — Profilage kernel

`bash
sudo perf record -a
sudo perf report
`

---

24.3.3. eBPF — Tracer les syscalls

`bash
sudo bpftrace -e 'tracepoint:syscalls:sysenterexecve { printf("%s\n", comm); }'
`

---

🧩 25. REVERSE ENGINEERING — VERSION INGÉNIERIE

---

25.1. Analyse ELF avancée

Voir les sections ELF

`bash
readelf -S binaire
`

Voir les symboles

`bash
nm -D binaire
`

Voir les dépendances

`bash
ldd binaire
`

---

25.2. Debugging avancé (gdb)

Lancer un programme avec gdb

`bash
gdb --args ./programme arg1 arg2
`

Breakpoints avancés

`gdb
break *0x400123
break malloc
`

Tracer les syscalls

`gdb
catch syscall
`

---

25.3. Analyse dynamique (strace, ltrace)

Tracer les appels système

`bash
strace -f -o trace.log ./programme
`

Tracer les appels de fonctions libc

`bash
ltrace ./programme
`

---

🛡️ 26. EXPLOIT MITIGATION — VERSION INGÉNIERIE

---

26.1. Protections modernes Linux

26.1.1. ASLR

`bash
cat /proc/sys/kernel/randomizevaspace
`

26.1.2. Stack canaries

`
checksec --file=binaire
`

26.1.3. RELRO

`
Partial RELRO
Full RELRO
`

26.1.4. PIE (Position Independent Executable)

`
checksec --file=binaire
`

---

26.2. seccomp — Sandbox syscalls

Exemple de filtre seccomp

`c
SCMP_SYS(execve),
SCMP_SYS(open),
SCMP_SYS(read),
SCMP_SYS(write),
`

---

26.3. AppArmor — Sandbox avancée

Mettre un binaire en confinement strict

`bash
sudo aa-enforce /etc/apparmor.d/usr.bin.monprogramme
`

---

🧱 27. HARDENING EXTRÊME — VERSION INGÉNIERIE

---

27.1. Hardening kernel

Désactiver les modules non utilisés

`
blacklist firewire-core
blacklist bluetooth
blacklist usb-storage
`

---

27.2. Hardening réseau

`
net.ipv4.conf.all.accept_redirects=0
net.ipv4.conf.all.send_redirects=0
net.ipv4.conf.all.log_martians=1
`

---

27.3. Hardening filesystem

Interdire exécution dans /tmp

`
/tmp ext4 defaults,noexec,nosuid,nodev 0 2
`

---

🧬 28. FORENSICS KERNEL — VERSION EXPERT

---

28.1. Analyse mémoire (LiME + Volatility)

Dump mémoire

`bash
sudo insmod lime.ko "path=/mnt/memdump.lime format=lime"
`

Analyse Volatility

`bash
volatility -f memdump.lime linux_pslist
`

---

28.2. Analyse des modules kernel

`bash
lsmod
modinfo module.ko
`

---

28.3. Détection de rootkits

chkrootkit

`bash
sudo chkrootkit
`

rkhunter

`bash
sudo rkhunter --check
`

---

🛰️ 29. DÉTECTION D’EXPLOITS — VERSION INGÉNIERIE

---

29.1. Détection d’anomalies kernel

Surveiller les Oops

`bash
dmesg | grep -i oops
`

Surveiller les panics

`bash
journalctl -k | grep -i panic
`

---

29.2. Détection d’exploits via eBPF

Détecter execve suspects

`bash
sudo bpftrace -e 'tracepoint:syscalls:sysenterexecve { printf("%s %s\n", comm, str(args->filename)); }'
`

---

🧾 30. SCRIPTS PROFESSIONNELS — VERSION INGÉNIERIE

---

30.1. Script de détection d’exploits

`

!/usr/bin/env bash
echo "=== DETECTION EXPLOITS ==="
dmesg | grep -Ei "segfault|overflow|corruption|oops|panic"
`

---

30.2. Script de forensic kernel

`

!/usr/bin/env bash
mkdir forensic
cp /proc/kallsyms forensic/
cp /var/log/kern.log forensic/
lsmod > forensic/modules.txt
`

---

30.3. Script de sandbox seccomp

`

!/usr/bin/env bash
seccomp-tools dump ./programme
`

---

🎯 TOME 6 — VERSION INGÉNIERIE ULTIME TERMINÉ

---
