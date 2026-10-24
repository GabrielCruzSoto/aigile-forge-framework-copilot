# AGENTS.md — Aigile Forge Framework · Copilot Declarative Edition (AFF-Copilot)

> Contrato declarativo de operación para células ágiles de ingeniería de software.
> Optimizado exclusivamente para **Visual Studio Code + GitHub Copilot Business**.
> CERO PII: Prohibido incluir identificadores personales reales, credenciales o secretos en código y prompts.

---

## 1. Identidad de la Célula y Principios

- **Modelo:** Harness 100% declarativo para equipos ágiles multi-repositorio (Backend, Web, Mobile).
- **Agnóstico:** Libre de información fija de empresa, negocio o equipo; configurable dinámicamente mediante el agente `@aff-onboarding`.
- **Arquitectura de IA:** Basada en `.github/` (agents, skills, prompts, instructions) en un workspace Multi-Root (`cell.code-workspace`) sin daemons externos ni servidores MCP.

---

## 2. Índice de Custom Agents de Copilot (`.github/agents/`)

| Agente | Archivo | Modifica Código | Propósito | Skills Asociadas |
|---|---|---|---|---|
| **`aff-onboarding`** | `aff-onboarding.agent.md` | Sí | **Agente Inicial:** Construye el contexto de célula (equipo, empresa, negocio, stack y workflow). | `cell-onboarding-bootstrap` |
| **`aff-orchestrator`** | `aff-orchestrator.agent.md` | No | Mapea sprint, inicializa contexto de tarea y gestiona `state.yaml`. | `checkpoint-resume` |
| **`aff-pm`** | `aff-pm.agent.md` | No | Genera hipótesis y preguntas bilingües P1/P2 para ceremonias ágiles. | `bilingual-elicitation` |
| **`aff-analyst`** | `aff-analyst.agent.md` | No | Hidrata tareas técnicas y clasifica criterios de aceptación (DoR). | `spec-crafting-hydration` |
| **`aff-architect`** | `aff-architect.agent.md` | No | Define `contract.md` y valida paridad 1:1 entre Web y Mobile. | `contract-first-design`, `multi-channel-parity` |
| **`aff-security`** | `aff-security.agent.md` | No | Audita OWASP, cero PII, índices en BD y stages de CI/CD. | `enterprise-security-audit` |
| **`aff-qa`** | `aff-qa.agent.md` | No | Construye `test-plan.md` y consolida evidencia multi-canal. | `test-evidence-receipts`, `multi-channel-parity` |
| **`aff-curator`** | `aff-curator.agent.md` | No | Knowledge Curator: sincroniza `knowledge/` y audita drift documental. | `knowledge-curation` |
| **`aff-planner`** | `aff-planner.agent.md` | No | Planifica unidades atómicas de trabajo (≤ 400 líneas). | `work-unit-tdd` |
| **`aff-implementer`** | `aff-implementer.agent.md` | Sí | Codifica test-first, resuelve bugs con RCA y documenta PRs. | `work-unit-tdd`, `incident-rca-debugging`, `pull-request-documentation` |
| **`aff-reviewer`** | `aff-reviewer.agent.md` | No | Ejecuta revisión adversarial 4R (*Risk, Req, Reg, Res*). | `adversarial-review-4r` |

---

## 3. Catálogo de Agent Skills (`skills/` y `.github/skills/`)

Cada skill define la **metodología procedimental, entradas, pasos y salidas verificables** para guiar a los agentes en la construcción rigurosa de cada entregable:

| Skill | Agente Ejecutor | Entregable que Produce | Propósito Procedimental |
|---|---|---|---|
| **`cell-onboarding-bootstrap`** | `aff-onboarding` | `cell.config.yaml`, `knowledge/**` | Guía de entrevista estructurada de 6 dimensiones para inicializar la célula. |
| **`bilingual-elicitation`** | `aff-pm` | `elicitation.md` | Protocolo para formular hipótesis y máximo 10 preguntas P1 (ES/EN) con defaults. |
| **`spec-crafting-hydration`** | `aff-analyst` | `spec.md`, `task-cards/*.md` | Redacción Given/When/Then con madurez e hidratación de tareas vacías con DoR. |
| **`contract-first-design`** | `aff-architect` | `contract.md`, `design.md` | Diseño de endpoints REST, schemas JSON, mocks sintéticos y compatibilidad N/N-1. |
| **`multi-channel-parity`** | `aff-architect`, `aff-qa` | `contract.md#parity` | Checklist y matriz de verificación 1:1 entre Web, Android e iOS. |
| **`adversarial-review-4r`** | `aff-reviewer` | `review.md` | Ejecución de las 4 dimensiones (Risk, Req, Reg, Res) y refutador de falsos positivos. |
| **`work-unit-tdd`** | `aff-planner`, `aff-implementer` | `tasks.md`, código + tests | Descomposición en unidades ≤ 400 líneas, ciclo Red-Green-Refactor y commits. |
| **`incident-rca-debugging`** | `aff-implementer`, `aff-analyst` | `rca.md`, test rojo | Protocolo metódico de aislamiento en logs, test rojo reproductor y 5 Porqués. |
| **`pull-request-documentation`** | `aff-implementer`, `aff-reviewer` | `pr.md` | Confección de PRs trazables con impacto, notas de release y plan de rollback. |
| **`test-evidence-receipts`** | `aff-qa` | `test-plan.md`, `evidence.md` | Matriz de trazabilidad 1:1 de pruebas y consolidación de certificado RDD (Receipt). |
| **`enterprise-security-audit`** | `aff-security` | `security-review.md` | Clasificación de datos, detección de PII, índices en BD, TTL en cache y Keystore/Keychain. |
| **`knowledge-curation`** | `aff-curator` | `drift-report.md`, ADRs | Protocolo de auditoría de drift código vs docs, poda de obsoletos y ADRs. |
| **`checkpoint-resume`** | `aff-orchestrator` | `state.yaml#checkpoint` | Protocolo de congelamiento en < 30s con commit temporal y retoma con rebase. |

---

## 4. Catálogo de Prompts Invocables (`.github/prompts/`)

- `/init-cell`: **Onboarding:** Construye el contexto maestro de la célula de forma interactiva.
- `/aff-intake`: Clasificación de User Story / Incidente y setup de workspace.
- `/elicit-ticket`: Elicitación bilingüe (ES/EN) con máx 10 preguntas P1.
- `/answers-to-spec`: Actualización incremental de `spec.md` con changelog.
- `/contract-first`: Definición de contratos y schemas de integración.
- `/sync-mobile-web-parity`: Auditoría de paridad 1:1 Web vs Mobile (Android / iOS).
- `/hu-to-tasks`: Hidratación de tareas hijas con checklist DoR.
- `/review-4r`: Revisión estricta de calidad antes de abrir Pull Request.
- `/review-refuter`: Segunda pasada adversarial contra falsos positivos.

---

## 5. Reglas Innegociables para Desarrolladores y Copilot

1. **Cero Huella Remota Inicial:** No comitear configuraciones locales del framework en repositorios remotos durante Fases 0/1; excluirlos mediante `.git/info/exclude`.
2. **Paridad Multi-Canal Estricta:** Las validaciones de cliente y mensajes de error deben ser idénticos en Web y Mobile. Prohibido calcular reglas de negocio pesadas en los clientes.
3. **Bases de Datos Seguras:**
   - Consultas a colecciones/tablas transaccionales requieren índices declarados y documentados.
   - Toda clave de cache debe poseer `TTL` explícito y cero datos personales en texto claro.
4. **Almacenamiento Seguro Móvil:**
   - Android: `EncryptedSharedPreferences` / `Android KeyStore`.
   - iOS: `Keychain Services`. Estrictamente prohibido `UserDefaults` para datos de sesión o tokens.
5. **Calidad y GitFlow:** Commits atómicos (≤ 400 líneas), TDD estricto y PRs acompañados de evidencia 4R.
