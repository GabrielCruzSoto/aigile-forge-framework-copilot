# Guía de Puesta en Marcha e Inicialización de Célula (Onboarding)

Esta guía explica cómo instalar y configurar **AFF-Copilot** para cualquier equipo de desarrollo ágil en entornos corporativos.

---

## 1. Requisitos Previos

Antes de comenzar, asegúrate de contar con:
- **Visual Studio Code** (versión 1.90 o superior).
- **Extensión GitHub Copilot & GitHub Copilot Chat** con licencia activa (Copilot Individual, Business o Enterprise).
- **Git** instalado en el sistema operativo.
- **Entorno Shell:** Bash nativo en Linux/macOS, o Git Bash en Windows.

---

## 2. Instalación Paso a Paso

### Paso 1: Clonar el Repositorio de Orquestación
Clona el repositorio en tu espacio de trabajo local (o en la carpeta asignada para herramientas de agentes):
```bash
git clone <URL_REPOSITORIO_AFF_COPILOT> aigile-forge-framework-copilot
cd aigile-forge-framework-copilot
```

### Paso 2: Inicializar y Scaffoldear con `aigile-copilot`
Ejecuta el asistente interactivo unificado para verificar el entorno y scaffoldear el workspace de la célula:
```bash
./aigile-copilot
```
O ejecutándolo de forma directa con parámetros:
```bash
./aigile-copilot --lang es --name mi-celula --workspace /ruta/al/nuevo-workspace
```
Este script realiza las siguientes acciones críticas:
1. Permite seleccionar el idioma de trabajo y generación de artefactos (Español o Inglés).
2. Detecta el Sistema Operativo (Linux, macOS, Windows).
3. Comprueba las herramientas necesarias (`git`, `code`, `mvn`, `node`, `npm`, `rsync`) y muestra instrucciones de instalación en caso de faltar alguna.
4. Detecta OneDrive Desktop y configura el respaldo en la nube para documentación (cero código).
5. Verifica la presencia de la extensión de GitHub Copilot en VS Code.
6. Scaffoldea la estructura completa del workspace con paridad de canales (`repositories/API-REST`, `backend`, `frontend`, `mobile`, `knowledge/`, `work/`, `sprints/`, `templates/` y `.github/`).
7. Configura `<nombre_celula>-cell.code-workspace` y `<nombre_celula>-cell.config.yaml`.

*(Opcional: Si tu organización requiere respaldar la documentación de la célula en OneDrive, consulta la [Guía de Seguridad y Sincronización](../governance/security-and-sync.md)).*

---

## 3. Conectar los Repositorios de Código de la Célula

Abre el archivo [`cell.code-workspace`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/cell.code-workspace) y ajusta las rutas de las carpetas a tus repositorios locales reales:

```json
{
  "folders": [
    {
      "name": "⚙️ AFF - Framework Hub",
      "path": "."
    },
    {
      "name": "🌐 Backend - Microservices",
      "path": "../mi-backend-servicio"
    },
    {
      "name": "💻 Frontend - Web App",
      "path": "../mi-portal-web"
    },
    {
      "name": "📱 Mobile - App",
      "path": "../mi-app-movil"
    }
  ]
}
```

Luego abre el espacio de trabajo en VS Code:
```bash
code cell.code-workspace
```

---

## 4. Onboarding Interactivo con `@aff-onboarding`

Una vez dentro de VS Code, abre la ventana de **GitHub Copilot Chat** y ejecuta el comando de onboarding:

```text
@aff-onboarding /init-cell
```

El agente `@aff-onboarding` iniciará una conversación interactiva guiada para recopilar las **6 Dimensiones Críticas de la Célula**:

```
                       ┌──────────────────────────────────────┐
                       │       @aff-onboarding /init-cell      │
                       └──────────────────┬───────────────────┘
                                          │
            ┌─────────────────────────────┼─────────────────────────────┐
            │                             │                             │
   1. IDENTIDAD DE EQUIPO        2. ROSTER DE INTEGRANTES      3. EMPRESA Y CUMPLIMIENTO
   - Nombre de la célula         - Product Owner               - Organización
   - Slug operativo              - Líder Técnico               - Normativas / Regulatorio
   - Repositorios vinculados     - Devs (Back/Front/Mobile/QA) - Herramienta de tickets (Jira)
            │                             │                             │
            ├─────────────────────────────┼─────────────────────────────┤
            │                             │                             │
   4. DOMINIO DE NEGOCIO         5. MAPA DE ARQUITECTURA       6. FORMAS DE TRABAJO (WoW)
   - Glosario de términos        - Microservicios y APIs       - Duración de sprint
   - Objetivos del trimestre     - Bases de datos y caches     - Estrategia de ramas (GitFlow)
   - Canales y audiencias        - Ambientes e infraestructura - Políticas de Definition of Done
            │                             │                             │
            └─────────────────────────────┴─────────────────────────────┘
                                          │
                                          ▼
                       ┌──────────────────────────────────────┐
                       │     ARTEFACTOS GENERADOS EN VIVO     │
                       ├──────────────────────────────────────┤
                       │  • cell.config.yaml                  │
                       │  • knowledge/team-roster.md          │
                       │  • knowledge/business-overview.md    │
                       │  • knowledge/architecture-system.md  │
                       │  • knowledge/team-workflow.md        │
                       │  • .github/instructions/cell-context │
                       └──────────────────────────────────────┘
```

### Respuestas Aceleradas
Si tienes la información lista, puedes proporcionarle al agente el bloque completo o pedirle que use las plantillas de `templates/`:
- [`templates/cell.config.template.yaml`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/templates/cell.config.template.yaml)
- [`templates/team-roster.template.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/templates/team-roster.template.md)
- [`templates/business-overview.template.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/templates/business-overview.template.md)
- [`templates/architecture-system-map.template.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/templates/architecture-system-map.template.md)
- [`templates/team-workflow.template.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/templates/team-workflow.template.md)

---

## 5. Validación del Onboarding

Una vez completado el proceso, verifica que:
1. `cell.config.yaml` refleje el nombre y configuración real de tu equipo.
2. La carpeta `knowledge/` contenga la información de arquitectura y negocio sin datos sensibles.
3. El archivo `.github/instructions/cell-context.instructions.md` exista y esté listo para que el resto de los 10 agentes tengan contexto inmediato de la célula.

¡La célula está lista para iniciar su primer Sprint con el comando `@aff-orchestrator /aff-intake`!
