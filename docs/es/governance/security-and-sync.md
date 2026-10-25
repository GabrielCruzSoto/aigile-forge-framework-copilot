# Gobierno, Seguridad Empresarial y Sincronización OneDrive

Este documento describe las políticas de seguridad de la información, el soporte multiplataforma y el mecanismo opcional de respaldo documental mediante OneDrive en **AFF-Copilot**.

---

## 1. Políticas de Seguridad de la Información

En entornos bancarios, de salud o corporativos regulados, la adopción de herramientas de IA exige garantías estrictas sobre el manejo de datos. AFF-Copilot incorpora controles de seguridad por diseño (*Security by Design*).

### A. Política Cero PII (Personally Identifiable Information)
- **Prohibición Total:** Queda estrictamente prohibido registrar datos reales de usuarios (RUT/DNI, números de tarjetas de crédito/débito, números de cuenta, direcciones, teléfonos o correos personales) en logs, especificaciones (`spec.md`), contratos (`contract.md`) o memoria de los agentes.
- **Datos Sintéticos:** Toda prueba, ejemplo de API o mock debe utilizar identificadores sintéticos no correlacionables con personas reales.

### B. Cero Secretos y Credenciales en Texto Plano
- Ningún archivo del framework ni de los repositorios de código puede contener API keys, contraseñas, certificados o tokens JWT.
- Las variables de entorno sensibles deben gestionarse mediante gestores de secretos corporativos (HashiCorp Vault, AWS Secrets Manager, Azure Key Vault).

### C. Auditoría Automatizada Pre-Commit (`aff-secret-scan.sh`)
El framework incluye un script de escaneo local que analiza los archivos antes de realizar commits:
```bash
./scripts/aff-secret-scan.sh
```
El script busca patrones de alta entropía, llaves privadas, tokens de nube (AWS, Azure, GCP, GitHub) y formatos comunes de números de tarjeta de crédito (algoritmo Luhn).

---

## 2. Compatibilidad Multiplataforma y Detección de Sistema Operativo

Todos los scripts de automatización del framework (`scripts/*.sh`) implementan **detección automática de sistema operativo**:

```bash
OS_TYPE="$(uname -s)"
case "${OS_TYPE}" in
    Linux*)     PLATFORM="linux" ;;
    Darwin*)    PLATFORM="macos" ;;
    CYGWIN*|MINGW*|MSYS*) PLATFORM="windows" ;;
    *)          PLATFORM="unknown" ;;
esac
```

Esto garantiza compatibilidad sin cambios entre:
- **Linux:** Ubuntu, Debian, Fedora, Arch, RHEL.
- **macOS:** Arquitecturas Intel y Apple Silicon (M1/M2/M3/M4) usando zsh o bash.
- **Windows:** Ejecución a través de **Git Bash** o terminales compatibles POSIX (MSYS2/Cygwin).

---

## 3. Sincronización Opcional con Microsoft OneDrive

### ¿Por qué OneDrive?
En muchas empresas, las células de desarrollo desean respaldar su base de conocimiento (`knowledge/`), especificaciones (`work/`) y configuraciones (`cell.config.yaml`) en la nube corporativa de Microsoft 365, pero **sin commitear estos artefactos en los repositorios de código de producción**.

AFF-Copilot resuelve esta necesidad mediante un mecanismo de sincronización unidireccional y desacoplado.

### Cómo Habilitar la Sincronización:
El asistente [`aigile-copilot`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/aigile-copilot) detecta automáticamente OneDrive Desktop al inicializar el workspace y activa la sincronización de gobernanza y documentos sin tocar los repositorios de código:

```bash
./aigile-copilot
```

El script configurará:
1. El archivo de configuración `.onedrive-sync.conf` en el workspace destino.
2. Un hook de Git en `.git/hooks/post-commit` dentro del workspace.

### Comportamiento del Hook Automático:
- **Disparo:** Cada vez que realizas un commit en el hub de AFF-Copilot, el hook ejecuta [`sync-onedrive.sh`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/scripts/sync-onedrive.sh) **en segundo plano** (`nohup ... &`).
- **No Bloqueante:** Tu flujo de trabajo en Git nunca se ralentiza ni se bloquea por la sincronización.
- **Filtro de Exclusiones Estricto:**
  - **SÍ se sincroniza:** `knowledge/`, `work/`, `sprints/`, `templates/`, `cell.config.yaml`, `AGENTS.md`, `README.md` y `docs/`.
  - **NUNCA se sincroniza:** `.git/`, repositorios de código conectados, `node_modules/`, binarios compilados, archivos `.env` o temporales.

### Comandos de Gestión Manual:
```bash
# Consultar el estado de la sincronización y la ruta configurada
./scripts/sync-onedrive.sh --status

# Ejecutar una sincronización manual inmediata
./scripts/sync-onedrive.sh

# Deshabilitar la sincronización
./scripts/sync-onedrive.sh --disable
```
