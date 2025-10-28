# System Recon - Linux System Reconnaissance Tool

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bash](https://img.shields.io/badge/Bash-4.0%2B-green.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Linux-blue.svg)](https://www.linux.org/)

**Autor**: Manuel Sánchez Gutiérrez  
**Fecha**: Octubre 2024  
**Propósito**: Herramienta educativa para reconocimiento y auditoría de sistemas Linux

---

## 📋 Descripción

**System Recon** es una herramienta de línea de comandos escrita en Bash para recopilar información detallada de sistemas Linux. Desarrollada como parte de mi formación en **Administración de Sistemas Informáticos en Red (ASIR)** y mi especialización en **ciberseguridad**.

Esta herramienta es útil en la fase de **post-explotación** de un pentesting, así como para **auditorías de seguridad** y **documentación de sistemas**.

---

## ✨ Características

- ✅ **Información del sistema** (OS, kernel, arquitectura, uptime)
- ✅ **Configuración de red** (interfaces, rutas, DNS, conexiones activas)
- ✅ **Usuarios y grupos** (usuarios con shell, últimos logins, sesiones activas)
- ✅ **Privilegios y permisos** (sudo, archivos SUID/SGID, archivos escribibles)
- ✅ **Procesos y servicios** (procesos en ejecución, servicios activos, tareas cron)
- ✅ **Software instalado** (versiones de Python, GCC, Git, herramientas de desarrollo)
- ✅ **Almacenamiento** (uso de disco, particiones montadas, dispositivos de bloque)
- ✅ **Variables de entorno** (PATH, HOME, variables sensibles)
- ✅ **Archivos sensibles** (configuración SSH, historial de comandos, archivos .env)
- ✅ **Configuración de seguridad** (firewall, SELinux, AppArmor)
- ✅ **Logs del sistema** (autenticación, syslog)
- ✅ **Exportación de informe completo** a archivo de texto
- ✅ **Modo silencioso** para automatización

---

## 🚀 Instalación

### Requisitos

- Sistema operativo: Linux (Ubuntu, Debian, Kali Linux, CentOS, etc.)
- Bash 4.0 o superior
- Permisos de ejecución (algunos comandos requieren sudo)

### Pasos

1. Clonar el repositorio:
```bash
git clone https://github.com/tuusuario/system-recon.git
cd system-recon
```

2. Dar permisos de ejecución:
```bash
chmod +x system_recon.sh
```

3. ¡Listo para usar!

---

## 💻 Uso

### Sintaxis Básica

```bash
./system_recon.sh [OPCIONES]
```

### Opciones

| Opción | Descripción | Ejemplo |
|--------|-------------|---------|
| `-o, --output ARCHIVO` | Guardar informe completo en archivo | `-o informe.txt` |
| `-q, --quiet` | Modo silencioso (solo guardar, no mostrar) | `-q` |
| `-h, --help` | Mostrar ayuda | `-h` |

### Ejemplos de Uso

**Mostrar información en pantalla:**
```bash
./system_recon.sh
```

**Guardar informe en archivo:**
```bash
./system_recon.sh -o informe_sistema.txt
```

**Modo silencioso (solo guardar):**
```bash
./system_recon.sh -o informe.txt -q
```

**Ejecutar con sudo para información completa:**
```bash
sudo ./system_recon.sh -o informe_completo.txt
```

---

## 📊 Salida de Ejemplo

```
╔═══════════════════════════════════════════════════════════╗
║       SYSTEM RECON - Reconocimiento de Sistema Linux     ║
║                   Uso Ético Únicamente                    ║
╚═══════════════════════════════════════════════════════════╝

[*] Sistema: ubuntu-server
[*] Usuario: manuel
[*] Fecha: 2024-10-28 16:00:15
============================================================

[*] INFORMACIÓN DEL SISTEMA
============================================================
[+] Hostname
ubuntu-server

[+] Sistema Operativo
Ubuntu 22.04.3 LTS

[+] Versión del Kernel
5.15.0-91-generic

[+] Arquitectura
x86_64

[+] Uptime
up 5 days, 3 hours, 24 minutes

[*] INFORMACIÓN DE RED
============================================================
[+] Interfaces de red
lo               UNKNOWN        127.0.0.1/8 ::1/128
eth0             UP             192.168.1.100/24 fe80::a00:27ff:fe4e:66a1/64

[+] Tabla de enrutamiento
default via 192.168.1.1 dev eth0
192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.100

[+] Puertos en escucha
tcp   LISTEN  0.0.0.0:22      sshd
tcp   LISTEN  0.0.0.0:80      nginx
tcp   LISTEN  0.0.0.0:3306    mysqld

[*] USUARIOS Y GRUPOS
============================================================
[+] Usuario actual
manuel

[+] ID del usuario
uid=1000(manuel) gid=1000(manuel) groups=1000(manuel),27(sudo)

[+] Usuarios con shell
root
manuel
admin

[*] PRIVILEGIOS Y PERMISOS
============================================================
[+] Permisos sudo del usuario
User manuel may run the following commands:
    (ALL : ALL) ALL

[+] Archivos con SUID
/usr/bin/sudo
/usr/bin/passwd
/usr/bin/chsh
/usr/bin/newgrp
...

[*] PROCESOS Y SERVICIOS
============================================================
[+] Procesos en ejecución (top 10 CPU)
USER       PID %CPU %MEM    VSZ   RSS COMMAND
www-data  1234  2.5  1.2 123456 12345 nginx
mysql     5678  1.8  5.4 234567 23456 mysqld
...

[*] ALMACENAMIENTO Y SISTEMA DE ARCHIVOS
============================================================
[+] Uso de disco
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   25G   23G  52% /
/dev/sdb1       100G   45G   50G  48% /data

...
```

---

## 🔧 Funcionamiento Técnico

### Arquitectura del Script

El script está organizado en secciones temáticas:

```bash
perform_recon() {
    print_section "INFORMACIÓN DEL SISTEMA"
    run_command "Hostname" "hostname"
    run_command "Sistema Operativo" "cat /etc/os-release | grep PRETTY_NAME"
    ...
}
```

Cada sección recopila información relacionada usando comandos nativos de Linux.

### Comandos Utilizados

| Categoría | Comandos |
|-----------|----------|
| Sistema | `hostname`, `uname`, `uptime`, `cat /etc/os-release` |
| Red | `ip`, `ss`, `cat /etc/resolv.conf` |
| Usuarios | `whoami`, `id`, `last`, `w`, `cat /etc/passwd` |
| Permisos | `sudo -l`, `find` (SUID/SGID) |
| Procesos | `ps`, `systemctl`, `crontab` |
| Software | `python3 --version`, `gcc --version`, `which` |
| Almacenamiento | `df`, `mount`, `lsblk` |
| Seguridad | `ufw status`, `iptables`, `getenforce`, `aa-status` |
| Logs | `tail /var/log/auth.log`, `tail /var/log/syslog` |

### Manejo de Errores

El script maneja errores silenciosamente:

```bash
run_command() {
    eval "$command" 2>/dev/null || echo "(No disponible)"
}
```

Esto permite que el script continúe aunque algunos comandos fallen (por falta de permisos o porque no existan).

---

## 📚 Casos de Uso

### 1. Post-Explotación en Pentesting (Laboratorio)

Después de obtener acceso a un sistema en un entorno de práctica:

```bash
./system_recon.sh -o recon_target.txt -q
```

### 2. Auditoría de Seguridad

Documentar la configuración de seguridad de un servidor:

```bash
sudo ./system_recon.sh -o auditoria_servidor_$(date +%Y%m%d).txt
```

### 3. Documentación de Sistemas

Generar documentación automática de la configuración de un servidor:

```bash
./system_recon.sh -o documentacion_servidor_web.txt
```

### 4. Troubleshooting

Recopilar información del sistema para diagnóstico de problemas:

```bash
./system_recon.sh -o troubleshooting_$(hostname).txt
```

### 5. Escalada de Privilegios (Laboratorio)

Identificar vectores de escalada de privilegios en máquinas de práctica:

```bash
./system_recon.sh | grep -A 20 "SUID\|sudo"
```

---

## ⚠️ Disclaimer Legal

**IMPORTANTE**: Esta herramienta es exclusivamente para fines educativos y de auditoría autorizada.

- ✅ **Permitido**: Usar en tus propios sistemas, laboratorios de práctica, sistemas con autorización explícita
- ❌ **Prohibido**: Ejecutar en sistemas comprometidos sin autorización legal

La recopilación de información de sistemas sin autorización puede ser ilegal. El autor **NO se hace responsable** del uso indebido de esta herramienta.

**Solo ejecuta en sistemas donde tengas autorización por escrito.**

---

## 🎓 Contexto Educativo

Este proyecto fue desarrollado como parte de mi formación en:

- **Grado Superior en Administración de Sistemas Informáticos en Red (ASIR)** - UNIR
- **Certificación eJPT v2** (Junior Penetration Tester) - INE Security
- **Formación en Pentesting Ético** - Hack4u

### Conocimientos Demostrados

- ✅ Administración de sistemas Linux
- ✅ Comprensión de la estructura del sistema de archivos Linux
- ✅ Análisis de configuraciones de seguridad
- ✅ Técnicas de post-explotación
- ✅ Scripting avanzado en Bash
- ✅ Metodologías de auditoría de sistemas

---

## 🔄 Comparación con Otras Herramientas

| Característica | System Recon (Bash) | LinPEAS | LinEnum |
|----------------|---------------------|---------|---------|
| Lenguaje | Bash | Bash/Python | Bash |
| Tamaño | ~8 KB | ~800 KB | ~50 KB |
| Detección de vectores | Básica | Avanzada | Media |
| Colores | Sí | Sí | Sí |
| Exportación | Texto | Texto/HTML | Texto |
| Propósito | Educativo | Profesional | Profesional |

**¿Cuándo usar este script?**
- Aprendizaje de reconocimiento de sistemas Linux
- Auditorías básicas de configuración
- Documentación de sistemas
- Entornos con recursos limitados

---

## 🛠️ Mejoras Futuras

- [ ] Detección automática de vectores de escalada de privilegios
- [ ] Análisis de configuraciones inseguras (permisos débiles, passwords por defecto)
- [ ] Exportación a formatos HTML y JSON
- [ ] Integración con bases de datos de vulnerabilidades (CVE)
- [ ] Modo de comparación entre dos sistemas
- [ ] Recomendaciones de hardening automáticas
- [ ] Soporte para contenedores Docker

---

## 📖 Recursos de Aprendizaje

Si quieres aprender más sobre reconocimiento de sistemas y escalada de privilegios:

- **Herramientas profesionales**: LinPEAS, LinEnum, Linux Smart Enumeration
- **Plataformas de práctica**: HackTheBox, TryHackMe (máquinas Linux)
- **Recursos**: GTFOBins, PEASS-ng, PayloadsAllTheThings
- **Libros**: "Linux Basics for Hackers" de OccupyTheWeb
- **Cursos**: Hack4u, TCM Security, Offensive Security (OSCP)

---

## 🔍 Vectores Comunes de Escalada de Privilegios

Este script ayuda a identificar:

1. **Binarios SUID/SGID**: Buscar en GTFOBins
2. **Permisos sudo**: Explotar configuraciones débiles
3. **Tareas cron**: Archivos ejecutables con permisos débiles
4. **Servicios vulnerables**: Versiones antiguas de software
5. **Archivos escribibles**: `/etc/passwd`, scripts de inicio
6. **Capabilities**: Permisos especiales de Linux
7. **Kernel exploits**: Versiones antiguas del kernel

---

## 📝 Interpretar los Resultados

### Archivos SUID Peligrosos

Si encuentras binarios como estos con SUID, investiga en GTFOBins:
- `find`, `vim`, `less`, `more`, `nano`
- `nmap` (versiones antiguas), `python`, `perl`
- `tar`, `zip`, `unzip`

### Permisos Sudo Interesantes

Configuraciones como estas pueden ser explotables:
```
(ALL) NOPASSWD: /usr/bin/vim
(ALL) NOPASSWD: /bin/bash
(root) NOPASSWD: /usr/bin/find
```

### Servicios en Puertos Internos

Servicios escuchando solo en localhost pueden ser tunelizados:
```
127.0.0.1:3306  (MySQL)
127.0.0.1:6379  (Redis)
```

---

## 📧 Contacto

**Manuel Sánchez Gutiérrez**  
- Email: manoloadra2@gmail.com  
- LinkedIn: [linkedin.com/in/manuel-sanchez-gutierrez](https://www.linkedin.com/in/manuel-sánchez-gutiérrez-b534ab336/)  
- GitHub: [github.com/tuusuario](https://github.com/tuusuario)

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.

---

## 🌟 Agradecimientos

- A la comunidad de pentesting por compartir conocimientos
- A los creadores de LinPEAS y LinEnum por inspirar esta herramienta
- A HackTheBox y TryHackMe por proporcionar entornos de práctica

---

**Recuerda**: El conocimiento de sistemas es fundamental para la seguridad. Usa esta herramienta de forma ética y responsable.

*"Know your system, secure your system."*
