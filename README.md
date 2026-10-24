# Aigile Forge Framework — Copilot Declarative Edition (AFF-Copilot)
## Framework Declarativo de Ingeniería de Software Asistida por IA para Células Ágiles Empresariales

**Versión:** 1.0.0  
**Harness Base:** Visual Studio Code Multi-Root Workspace + GitHub Copilot Business (100% Declarativo)

---

## 1. Visión General y Propósito

**AFF-Copilot** es un framework de ingeniería de software asistida por IA diseñado para células ágiles que desarrollan soluciones multi-repositorio (Backend, Web y Aplicaciones Móviles) en entornos corporativos y regulados.

El framework es **100% agnóstico de empresa, negocio y equipo**. En lugar de requerir configuraciones estáticas cableadas a mano, incorpora un **Agente Inicial de Onboarding (`@aff-onboarding`)** que permite a cualquier célula levantar y configurar su contexto operativo en minutos.

Opera de forma **completamente declarativa** utilizando las capacidades nativas de **GitHub Copilot en VS Code** (`.github/copilot-instructions.md`, `*.instructions.md`, `*.prompt.md`, `*.agent.md`, `@workspace`), **sin requerir servidores MCP, daemons de fondo ni binarios externos**.

### Pilares de Arquitectura
1. **Agente Inicial de Onboarding (`@aff-onboarding`):** Construye dinámicamente todo el contexto de la célula: nombre del equipo, roster de integrantes, información de la empresa, dominio del negocio, mapa de arquitectura/infraestructura y protocolos de trabajo.
2. **Cero Huella Remota Inicial (Fases 0 y 1):** Utiliza un espacio de trabajo Multi-Root (`cell.code-workspace`) donde las reglas locales de `.git/info/exclude` evitan contaminar los repositorios remotos con configuraciones locales del framework durante las fases iniciales de adopción.
3. **Paridad Multi-Canal (1:1):** Asegura coherencia total de contratos, validaciones y códigos de error entre el frontend Web y las aplicaciones Mobile Nativas (Android e iOS), prohibiendo el cálculo de reglas de negocio críticas en los clientes.
4. **Elicitación Estructurada Bilingüe (ES / EN):** Desambigua historias de usuario y tareas técnicas que nacen con descripciones incompletas, formulando hipótesis y un máximo de 10 preguntas P1 con opciones por defecto para ceremonias ágiles.
5. **Revisión Determinista 4R con Refutador:** Aplica el protocolo de calidad *Risk, Requirements, Regression, Resilience* con una segunda pasada adversarial para validar hallazgos antes de abrir Pull Requests.
6. **Guardrails de Datos y Seguridad:** Cero fuga de PII en logs y memoria, índices obligatorios en bases de datos y TTLs mandatorios en capas de cache.

---

## 2. Onboarding: Cómo Armar el Contexto de tu Célula

Al abrir este framework por primera vez, el **Agente de Onboarding** te guiará para estructurar el contexto de tu equipo:

1. **Abrir el workspace en VS Code:**
   ```bash
   code cell.code-workspace
   ```
2. **Invocar al agente en Copilot Chat:**
   ```text
   @aff-onboarding /init-cell
   ```
3. **Completar las 6 dimensiones guiadas:**
   - **Nombre e Identidad del Equipo:** Nombre de la célula, slug y repositorios.
   - **Personal del Equipo:** Roster de integrantes (Líder Técnico, PO, Devs Backend/Frontend/Mobile, QA).
   - **Información de la Empresa:** Empresa cliente, regulaciones, hosting de repositorios y gestor de tareas.
   - **Información del Negocio:** Dominio funcional, glosario de términos clave y objetivos del producto.
   - **Arquitectura y Stack:** Catálogo de microservicios, bases de datos, cache y pipelines de CI/CD.
   - **Forma de Trabajo (Ways of Working):** Ceremonias, duración del sprint, estrategia de ramas (GitFlow/Trunk) y Gates de aprobación.

El agente poblará automáticamente `cell.config.yaml`, `knowledge/` y generará la instrucción contextual `.github/instructions/cell-context.instructions.md`.

---

## 3. Protocolo de Fases y Gates de la Célula

```text
[Sprint Planning / Refinamiento] ──> [/elicit-ticket] ──> [/answers-to-spec] ──> [Gate G1: DoR]
                                                                                     │
[Gate G2: Contrato/Paridad] <── [/design & /sync-mobile-web-parity] <────────────────┘
       │
       └──> [Implementación TDD en Repos] ──> [/review-4r & /review-refuter] ──> [Gate G3: PR]
                                                                                     │
[Sprint Review Demo] <── [/generate-receipt] <── [Gate G4: CI/CD & Deploy] <─────────┘
```

### Gates de Aprobación
- **G1 (Definition of Ready - DoR):** El Product Owner valida criterios de negocio y responde preguntas P1; el Líder Técnico confirma viabilidad técnica.
- **G2 (Contrato y Paridad de Canales):** Aprobación de `contract.md` y verificación de compatibilidad 1:1 entre Web y Mobile antes del desarrollo de interfaz.
- **G3 (Aprobación de Pull Request):** Revisión humana del PR acompañada por veredicto favorable de `/review-4r` y pipeline de CI en verde.
- **G4 (Pase a Ambientes / Producción):** Despliegue verificado por DevOps y el equipo técnico.

---

## 4. Catálogo de Agentes Declarativos (.github/agents/)

| Custom Agent | Slash Command Principal | Propósito Específico |
|---|---|---|
| **`aff-onboarding`** | `/init-cell` | **Agente Inicial:** Construye interactivamente el contexto de la célula. |
| **`aff-orchestrator`** | `/aff-intake`, `/checkpoint`, `/resume` | Gobierna jerarquía Sprint → HU → Tareas y mantiene `state.yaml`. |
| **`aff-pm`** | `/elicit-ticket`, `/prepare-review` | Elicita requerimientos en ES/EN y prepara el guion de Sprint Review. |
| **`aff-analyst`** | `/answers-to-spec`, `/hu-to-tasks` | Hidrata tareas técnicas y clasifica criterios de aceptación (DoR). |
| **`aff-architect`** | `/contract-first`, `/sync-mobile-web-parity` | Diseña contratos REST, persistencia, cache y valida paridad multi-canal. |
| **`aff-security`** | `/security-check` | Audita OWASP, cero PII, índices en BD y configuración de seguridad. |
| **`aff-qa`** | `/test-plan`, `/generate-receipt` | Elabora planes de prueba y consolida evidencias de calidad. |
| **`aff-curator`** | `/bootstrap-knowledge`, `/drift-check` | Mantiene sincronizada la base de conocimiento y `AGENTS.md`. |
| **`aff-planner`** | `/plan-tasks` | Desglosa tareas en unidades atómicas de implementación (≤ 400 líneas). |
| **`aff-implementer`** | `/implement-next` | Ciclo TDD estricto (Red-Green-Refactor) en la rama local. |
| **`aff-reviewer`** | `/review-4r`, `/review-refuter` | Revisión adversarial 4R y refutación de falsos positivos. |

---

## 5. Puesta en Marcha Local

```bash
# 1. Verificar herramientas de desarrollo y extensiones de VS Code
./scripts/install-dependencies.sh

# 2. Configurar exclusiones locales (.git/info/exclude) y Multi-Root
./scripts/setup-framework.sh

# 3. Abrir el workspace multi-root en VS Code
code cell.code-workspace

# 4. Validar seguridad pre-commit
./scripts/aff-secret-scan.sh
```
