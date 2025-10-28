#!/bin/bash

#####################################################################
# System Recon - Herramienta de Reconocimiento de Sistemas
# Autor: Manuel Sánchez Gutiérrez
# Fecha: Octubre 2024
# Descripción: Script para recopilar información del sistema local
#              Útil en fase de post-explotación o auditorías
# Uso: ./system_recon.sh -o informe.txt
# USO EDUCATIVO Y ÉTICO ÚNICAMENTE
#####################################################################

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

# Banner
print_banner() {
    echo -e "${CYAN}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║       SYSTEM RECON - Reconocimiento de Sistema Linux     ║"
    echo "║                   Uso Ético Únicamente                    ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Función para imprimir sección
print_section() {
    echo -e "\n${MAGENTA}[*] $1${NC}"
    echo "============================================================"
}

# Función para ejecutar comando y mostrar resultado
run_command() {
    local description=$1
    local command=$2
    
    echo -e "${BLUE}[+] $description${NC}"
    eval "$command" 2>/dev/null || echo -e "${YELLOW}    (No disponible)${NC}"
    echo ""
}

# Función de ayuda
show_help() {
    echo "Uso: $0 [OPCIONES]"
    echo ""
    echo "Opciones:"
    echo "  -o, --output ARCHIVO   Guardar informe completo en archivo"
    echo "  -q, --quiet            Modo silencioso (solo guardar en archivo)"
    echo "  -h, --help             Mostrar esta ayuda"
    echo ""
    echo "Ejemplos:"
    echo "  $0                     # Mostrar información en pantalla"
    echo "  $0 -o informe.txt      # Guardar en archivo"
    echo "  $0 -o informe.txt -q   # Solo guardar, no mostrar"
    exit 0
}

# Función principal de reconocimiento
perform_recon() {
    # INFORMACIÓN DEL SISTEMA
    print_section "INFORMACIÓN DEL SISTEMA"
    run_command "Hostname" "hostname"
    run_command "Sistema Operativo" "cat /etc/os-release | grep PRETTY_NAME | cut -d'\"' -f2"
    run_command "Versión del Kernel" "uname -r"
    run_command "Arquitectura" "uname -m"
    run_command "Uptime" "uptime -p"
    
    # INFORMACIÓN DE RED
    print_section "INFORMACIÓN DE RED"
    run_command "Interfaces de red" "ip -br addr show"
    run_command "Tabla de enrutamiento" "ip route"
    run_command "Servidores DNS" "cat /etc/resolv.conf | grep nameserver"
    run_command "Conexiones activas" "ss -tuln | head -20"
    run_command "Puertos en escucha" "ss -tlnp 2>/dev/null | grep LISTEN | head -10"
    
    # USUARIOS Y GRUPOS
    print_section "USUARIOS Y GRUPOS"
    run_command "Usuario actual" "whoami"
    run_command "ID del usuario" "id"
    run_command "Usuarios con shell" "cat /etc/passwd | grep -v nologin | grep -v false | cut -d: -f1"
    run_command "Usuarios con UID 0 (root)" "awk -F: '\$3 == 0 {print \$1}' /etc/passwd"
    run_command "Últimos logins" "last -n 10"
    run_command "Usuarios actualmente conectados" "w"
    
    # PRIVILEGIOS Y PERMISOS
    print_section "PRIVILEGIOS Y PERMISOS"
    run_command "Permisos sudo del usuario" "sudo -l 2>/dev/null"
    run_command "Archivos con SUID" "find / -perm -4000 -type f 2>/dev/null | head -20"
    run_command "Archivos con SGID" "find / -perm -2000 -type f 2>/dev/null | head -20"
    run_command "Archivos escribibles por todos" "find / -perm -002 -type f 2>/dev/null | head -20"
    
    # PROCESOS Y SERVICIOS
    print_section "PROCESOS Y SERVICIOS"
    run_command "Procesos en ejecución (top 10 CPU)" "ps aux --sort=-%cpu | head -11"
    run_command "Servicios activos" "systemctl list-units --type=service --state=running | head -15"
    run_command "Tareas cron del sistema" "cat /etc/crontab 2>/dev/null"
    run_command "Tareas cron del usuario" "crontab -l 2>/dev/null"
    
    # SOFTWARE INSTALADO
    print_section "SOFTWARE Y PAQUETES"
    run_command "Versión de Python" "python3 --version 2>/dev/null"
    run_command "Versión de GCC" "gcc --version 2>/dev/null | head -1"
    run_command "Versión de Git" "git --version 2>/dev/null"
    run_command "Herramientas de desarrollo" "which gcc g++ make perl python python3 2>/dev/null"
    
    # INFORMACIÓN DE ALMACENAMIENTO
    print_section "ALMACENAMIENTO Y SISTEMA DE ARCHIVOS"
    run_command "Uso de disco" "df -h | grep -v tmpfs | grep -v devtmpfs"
    run_command "Particiones montadas" "mount | grep -v tmpfs | grep -v devtmpfs"
    run_command "Dispositivos de bloque" "lsblk"
    
    # VARIABLES DE ENTORNO
    print_section "VARIABLES DE ENTORNO IMPORTANTES"
    run_command "PATH" "echo \$PATH"
    run_command "HOME" "echo \$HOME"
    run_command "SHELL" "echo \$SHELL"
    run_command "Variables de entorno sensibles" "env | grep -i 'password\|token\|key\|secret' 2>/dev/null"
    
    # ARCHIVOS SENSIBLES
    print_section "ARCHIVOS DE CONFIGURACIÓN SENSIBLES"
    run_command "Archivos de configuración SSH" "ls -la ~/.ssh/ 2>/dev/null"
    run_command "Historial de comandos" "tail -20 ~/.bash_history 2>/dev/null"
    run_command "Archivos .env" "find /var/www /home -name '.env' 2>/dev/null | head -10"
    run_command "Archivos de configuración de bases de datos" "find /etc -name '*sql*' -o -name '*db.conf' 2>/dev/null | head -10"
    
    # INFORMACIÓN DE SEGURIDAD
    print_section "CONFIGURACIÓN DE SEGURIDAD"
    run_command "Firewall (UFW)" "ufw status 2>/dev/null"
    run_command "Firewall (iptables)" "iptables -L -n 2>/dev/null | head -20"
    run_command "SELinux status" "getenforce 2>/dev/null"
    run_command "AppArmor status" "aa-status 2>/dev/null | head -10"
    
    # LOGS RECIENTES
    print_section "LOGS DEL SISTEMA (ÚLTIMAS ENTRADAS)"
    run_command "Logs de autenticación" "tail -20 /var/log/auth.log 2>/dev/null || tail -20 /var/log/secure 2>/dev/null"
    run_command "Logs del sistema" "tail -20 /var/log/syslog 2>/dev/null || tail -20 /var/log/messages 2>/dev/null"
}

# Variables por defecto
output_file=""
quiet_mode=false

# Procesar argumentos
while [[ $# -gt 0 ]]; do
    case $1 in
        -o|--output)
            output_file="$2"
            shift 2
            ;;
        -q|--quiet)
            quiet_mode=true
            shift
            ;;
        -h|--help)
            show_help
            ;;
        *)
            echo -e "${RED}[!] Opción desconocida: $1${NC}"
            show_help
            ;;
    esac
done

# Imprimir banner
if [ "$quiet_mode" = false ]; then
    print_banner
fi

# Información del escaneo
if [ "$quiet_mode" = false ]; then
    echo -e "${CYAN}[*] Sistema: $(hostname)${NC}"
    echo -e "${CYAN}[*] Usuario: $(whoami)${NC}"
    echo -e "${CYAN}[*] Fecha: $(date '+%Y-%m-%d %H:%M:%S')${NC}"
    echo "============================================================"
fi

# Ejecutar reconocimiento
if [ -n "$output_file" ]; then
    # Guardar en archivo
    {
        echo "======================================================================"
        echo "         INFORME DE RECONOCIMIENTO DE SISTEMA LINUX"
        echo "======================================================================"
        echo ""
        echo "Fecha: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Hostname: $(hostname)"
        echo "Usuario: $(whoami)"
        echo ""
        perform_recon
        echo ""
        echo "======================================================================"
        echo "                    FIN DEL INFORME"
        echo "======================================================================"
    } > "$output_file" 2>&1
    
    if [ "$quiet_mode" = false ]; then
        echo -e "\n${GREEN}[+] Informe guardado en: $output_file${NC}"
    fi
else
    # Mostrar en pantalla
    perform_recon
fi

# Disclaimer
if [ "$quiet_mode" = false ]; then
    echo ""
    echo -e "${YELLOW}[!] Disclaimer: Esta herramienta es solo para uso educativo y ético.${NC}"
    echo -e "${YELLOW}[!] Solo ejecuta en sistemas donde tengas autorización.${NC}"
    echo ""
fi
