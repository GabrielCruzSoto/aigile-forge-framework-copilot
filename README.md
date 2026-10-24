# Aigile Forge Framework — Copilot Edition (AFF-M)
## Framework Declarativo de Ingeniería de Software Asistida por IA para Mobdev–Scotiabank (Célula "The Last of Code" · Seguros Digitales)

**Versión:** 1.0.0  
**Cliente:** Scotiabank  
**Proveedor:** Mobdev  
**Harness Base:** VS Code Multi-Root Workspace + GitHub Copilot Business (100% Declarativo)

---

## 1. Visión General y Propósito

**AFF-M** es la edición especializada de Aigile Forge Framework concebida para la célula de Seguros Digitales ("The Last of Code"), administrada directamente por **Scotiabank**. 

Diseñado específicamente para operar en entornos corporativos y altamente regulados bajo estrictas políticas de InfoSec y DevOps bancario, este framework se implementa de manera **100% declarativa** aprovechando las capacidades nativas de **GitHub Copilot en Visual Studio Code** (`.github/copilot-instructions.md`, `*.instructions.md`, `*.prompt.md`, `*.agent.md`, `@workspace`), **sin requerir servidores MCP, binarios externos ni daemons locales**.

### Pilares de Arquitectura
1. **Cero Huella Remota en Bitbucket Server (Fases 0 y 1):** Utiliza un espacio de trabajo Multi-Root (`the-last-of-code.code-workspace`) donde la primera raíz alberga la configuración del framework, mientras que las reglas locales de `.git/info/exclude` previenen que cualquier archivo temporal de IA se suba a Bitbucket Enterprise Server sin autorización formal.
2. **Paridad Multi-Canal Absoluta (1:1):** Garantiza coherencia total entre el portal **Web (Angular)** y las aplicaciones nativas **Android (Kotlin)** e **iOS (Swift)**, prohibiendo el cálculo de primas en los dispositivos cliente y sincronizando payloads JSON y códigos de error.
3. **Elicitación Estructurada Bilingüe (ES / EN):** Aborda el problema de tareas de Jira que nacen "solo con título", generando hipótesis técnicas y un máximo de 10 preguntas P1 con opción por defecto para refinamientos y planning.
4. **Revisión Determinista 4R con Refutador:** Aplica el protocolo de calidad *Risk, Requirements, Regression, Resilience* con una segunda pasada adversarial para descartar falsos positivos antes de bloquear Pull Requests.
5. **Guardrails Bancarios Mandatorios:** Bloqueo de PII (RUTs, nombres, números de póliza reales), consultas indexadas obligatorias en MongoDB, `TTL` obligatorio en Redis y verificación previa de etapas de `Jenkinsfile`.

---

## 2. Protocolo de Fases y Gates Bancarios

```text
[Sprint Planning / Refinamiento] ──> [/elicit-ticket] ──> [/answers-to-spec] ──> [Gate G1: DoR]
                                                                                     │
[Gate G2: Contrato/Paridad] <── [/design & /sync-mobile-web-parity] <────────────────┘
       │
       └──> [Implementación TDD en Repos] ──> [/review-4r & /review-refuter] ──> [Gate G3: PR Bitbucket]
                                                                                     │
[Sprint Review Demo] <── [/generate-receipt] <── [Gate G4: Jenkins & Argo CD] <──────┘
```

### Gates Humanos del Banco
- **G1 (Definition of Ready - DoR):** El Product Owner del banco confirma los criterios de negocio y responde preguntas P1. El Líder Técnico valida que la `spec.md` no tenga criterios en estado `HIPOTESIS` para la tarea a iniciar.
- **G2 (Contrato y Paridad de Canales):** Aprobación del `contract.md` y verificación de compatibilidad 1:1 entre Angular, Android e iOS antes de comenzar desarrollo de UI.
- **G3 (Aprobación de Pull Request en Bitbucket Server):** Revisión humana del PR acompañada por veredicto favorable de `/review-4r` y pipeline de Jenkins en verde.
- **G4 (Promoción y Despliegue):** Aprobación de paso a ambientes IST/UAT y Producción ejecutada por DevOps mediante Jenkins y Argo CD.

---

## 3. Catálogo de Agentes Declarativos (.github/agents/)

| Custom Agent | Slash Command Principal | Propósito Específico |
|---|---|---|
| **`aff-orchestrator`** | `/aff-intake`, `/checkpoint`, `/resume` | Gobernar jerarquía Sprint → HU → Tareas y mantener `state.yaml`. |
| **`aff-pm`** | `/elicit-ticket`, `/prepare-review` | Elicitar requerimientos en ES/EN y preparar el guion de demo de Sprint Review. |
| **`aff-analyst`** | `/answers-to-spec`, `/hu-to-tasks` | Hidratar tareas de Jira y clasificar criterios (Hipótesis/Confirmado/Validado). |
| **`aff-architect`** | `/contract-first`, `/sync-mobile-web-parity` | Diseñar contratos REST, esquemas MongoDB, claves Redis y paridad móvil. |
| **`aff-security`** | `/security-check`, `/jenkins-pr-check` | Auditar cumplimiento OWASP, cero PII, índices de BD y stages de Jenkins. |
| **`aff-qa`** | `/test-plan`, `/generate-receipt` | Elaborar planes de prueba y consolidar evidencias multi-canal. |
| **`aff-curator`** | `/bootstrap-knowledge`, `/drift-check` | Mantener sincronizada la base de conocimiento y `AGENTS.md`. |
| **`aff-planner`** | `/plan-tasks` | Desglosar tareas en unidades atómicas (≤ 400 líneas). |
| **`aff-implementer`** | `/implement-next` | Ciclo TDD estricto (Red-Green-Refactor) en la rama local. |
| **`aff-reviewer`** | `/review-4r`, `/review-refuter` | Revisión adversarial 4R y refutación de falsos positivos. |

---

## 4. Estructura del Workspace Multi-Root

Abrir `the-last-of-code.code-workspace` en VS Code para vincular:
1. `cell-hub-the-last-of-code` (gobernanza, conocimiento y `.github/`).
2. Repositorios de microservicios backend Java / Kotlin.
3. Repositorio frontend web Angular.
4. Repositorio app móvil Android (Kotlin).
5. Repositorio app móvil iOS (Swift).

---

## 5. Setup y Puesta en Marcha

```bash
# 1. Verificar herramientas de compilación y extensiones de VS Code
./scripts/install-dependencies.sh

# 2. Configurar exclusiones locales (.git/info/exclude) y Multi-Root
./scripts/setup-framework.sh

# 3. Validar seguridad pre-commit
./scripts/aff-secret-scan.sh
```
