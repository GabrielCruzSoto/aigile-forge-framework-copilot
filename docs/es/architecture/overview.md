# Arquitectura Técnica y Modelo de Harness Declarativo

Este documento detalla los fundamentos de diseño y la arquitectura interna de **Aigile Forge Framework — Copilot Declarative Edition (AFF-Copilot)**.

---

## 1. Visión Arquitectónica

AFF-Copilot aborda un problema crítico en la ingeniería asistida por IA para empresas: **cómo guiar a equipos de desarrollo en sistemas complejos multi-repositorio sin requerir servidores complejos, plugins pesados o alterar la estructura de los repositorios corporativos.**

```
┌────────────────────────────────────────────────────────────────────────┐
│                   VS CODE MULTI-ROOT WORKSPACE                         │
│                      (cell.code-workspace)                             │
├───────────────────────────────┬────────────────────────────────────────┤
│  REPO DE ORQUESTACIÓN (AFF)   │       REPOSITORIOS DE CÓDIGO FUENTE    │
│  (Hub de Gobierno / Memoria)  │            (Desarrollo Activo)         │
│                               │                                        │
│  ├── cell.config.yaml         │  ├── repo-backend-ms/ (Spring Boot/Go) │
│  ├── knowledge/ (Dominio/Arq) │  ├── repo-frontend-web/ (Angular/React)│
│  ├── work/ (HU/Spikes/Specs)  │  ├── repo-mobile-android/ (Kotlin)     │
│  ├── sprints/ (Checkpoints)   │  └── repo-mobile-ios/ (Swift)          │
│  ├── .github/                 │                                        │
│  │   ├── agents/*.agent.md    │                                        │
│  │   ├── prompts/*.prompt.md  │                                        │
│  │   └── skills/**            │                                        │
│  └── scripts/                 │                                        │
└───────────────────────────────┴────────────────────────────────────────┘
```

El framework actúa como un **Hub Orquestador Centralizado**. Todos los artefactos de gobierno, contratos, especificaciones y métricas viven en el workspace de AFF, mientras que el código de producción se manipula directamente en sus respectivos repositorios independientes.

---

## 2. El Patrón Multi-Root Workspace

En lugar de clonar los repositorios dentro del framework o forzar un monorepo artificial, el framework utiliza la funcionalidad nativa de **Multi-Root Workspaces** de Visual Studio Code (`cell.code-workspace`).

### Ventajas Operativas:
1. **Acceso Unificado `@workspace`:** GitHub Copilot tiene visibilidad completa y simultánea del backend, la web, las apps móviles y las especificaciones del framework.
2. **Independencia de Repositorios Git:** Cada carpeta de código mantiene su propio historial de Git, ramas activas, remotos (`origin`), permisos y credenciales independientes.
3. **Cero Contaminación Remota (Zero Remote Footprint):** Las carpetas de configuración del framework (`.github/`, `knowledge/`, `cell.config.yaml`) no se envían a los repositorios remotos corporativos.

### Configuración del Workspace (`cell.code-workspace`):
```json
{
  "folders": [
    {
      "name": "⚙️ AFF - Framework Hub",
      "path": "."
    },
    {
      "name": "🌐 Backend - Microservices",
      "path": "../repo-backend-ms"
    },
    {
      "name": "💻 Frontend - Web App",
      "path": "../repo-frontend-web"
    },
    {
      "name": "📱 Mobile - Android Native",
      "path": "../repo-mobile-android"
    },
    {
      "name": "🍏 Mobile - iOS Native",
      "path": "../repo-mobile-ios"
    }
  ],
  "settings": {
    "github.copilot.chat.scope": "workspace",
    "files.exclude": {
      "**/.git": false
    }
  }
}
```

---

## 3. Aislamiento Local: Cero Huella Remota (`.git/info/exclude`)

Durante las fases iniciales de adopción, las organizaciones con políticas estrictas de seguridad o control de cambios prohíben commitear tooling local o archivos de configuración de IA en repositorios compartidos.

Para resolver esto, el script [`setup-framework.sh`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/scripts/setup-framework.sh) inyecta reglas de exclusión en `.git/info/exclude` de cada repositorio conectado. A diferencia de un archivo `.gitignore`, `.git/info/exclude` **nunca se commitea ni se envía al servidor remoto**, manteniendo el trabajo del agente 100% privado en la máquina del desarrollador.

---

## 4. Harness 100% Declarativo para GitHub Copilot

La mayoría de los frameworks de agentes dependen de protocolos propietarios, servidores MCP que se caen o daemons que consumen gigabytes de memoria. AFF-Copilot es **100% declarativo**: aprovecha las primitivas estándar que GitHub Copilot y VS Code leen de manera nativa:

| Componente | Ruta en el Workspace | Función Arquitectónica |
|---|---|---|
| **Custom Agents** | `.github/agents/*.agent.md` | Define la personalidad, rol, límites éticos y herramientas de cada agente especializado. |
| **Slash Prompts** | `.github/prompts/*.prompt.md` | Define las acciones ejecutables en el chat (`/init-cell`, `/elicit-ticket`, `/review-4r`). |
| **Instructions** | `.github/copilot-instructions.md`, `.github/instructions/*.instructions.md` | Inyecta contexto global persistente y reglas arquitectónicas obligatorias en cada interacción. |
| **Agent Skills** | `skills/*/SKILL.md` y `.github/skills/*/SKILL.md` | Provee procedimientos paso a paso y listas de verificación para evitar improvisación. |

---

## 5. Paridad Multi-Canal como Requisito de Arquitectura

En arquitecturas omnicanal, uno de los errores más costosos es la divergencia entre el comportamiento del sitio Web y las aplicaciones Móviles (iOS y Android).

AFF-Copilot introduce el principio de **Paridad Multi-Canal (1:1)**:
- **Contrato Único (`contract.md`):** Todos los endpoints y modelos JSON deben responder de forma idéntica sin importar el cliente que consuma la API.
- **Validaciones Centralizadas en Backend:** Se prohíbe que el cliente Web o Móvil calcule por su cuenta reglas críticas de negocio (descuentos, límites crediticios, validaciones de elegibilidad). El backend retorna el estado y las razones; los clientes solo renderizan.
- **Códigos y Mensajes de Error Homogéneos:** Si una transacción falla por fondos insuficientes, el backend emite un código estándar (`ERR_PAYMENT_INSUFFICIENT_FUNDS`) y ambos canales deben reaccionar con el mismo flujo de usuario.

---

## 6. Organización del Sistema de Archivos

```
aigile-forge-framework-copilot/
├── cell.code-workspace         # Definición del workspace Multi-Root
├── cell.config.yaml            # Configuración generada de la célula (generada en Onboarding)
├── AGENTS.md                   # Contrato maestro de agentes y catálogo operativo
├── README.md                   # Resumen en español y guía rápida
├── README.en.md                # Resumen en inglés y guía rápida
├── docs/                       # Documentación completa y guías
│   ├── es/                     # Documentación en español
│   └── en/                     # Documentación en inglés
├── knowledge/                  # Base de conocimiento persistente de la célula
│   ├── business-overview.md    # Dominio de negocio y reglas clave
│   ├── team-roster.md          # Integrantes y roles del equipo
│   ├── architecture-system-map.md # Diagramas de componentes, BD y APIs
│   └── team-workflow.md        # Ceremonias, ramas y políticas de calidad
├── work/                       # Carpeta activa de historias de usuario y tareas
│   └── HU-XXX/                 # Carpeta por historia (spec.md, contract.md, review.md)
├── sprints/                    # Planificación y checkpoints de avance
├── skills/                     # Directorio canónico de las 13 Agent Skills
├── .github/                    # Hub de configuración declarativa para Copilot
│   ├── agents/                 # Los 11 agentes especializados
│   ├── prompts/                # Comandos de chat (/slash)
│   ├── instructions/           # Instrucciones contextuales del workspace
│   └── skills/                 # Espejo de skills accesible para Copilot
└── scripts/                    # Scripts multiplataforma de automatización y gobierno
    ├── install-dependencies.sh # Verificación del entorno local
    ├── setup-framework.sh      # Inicialización del workspace y exclusiones
    ├── sync-onedrive.sh        # Sincronización documental con OneDrive
    └── aff-secret-scan.sh      # Auditoría local de seguridad pre-commit
```
