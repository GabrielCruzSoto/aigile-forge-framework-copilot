# AGENTS.md — Aigile Forge Framework · Copilot Declarative Edition (AFF-Copilot)

> Contrato declarativo de operación para células ágiles de ingeniería de software.
> Optimizado exclusivamente para **Visual Studio Code + GitHub Copilot Business**.
> CERO PII: Prohibido incluir identificadores personales reales, credenciales o secretos en código y prompts.

---

## 1. Identidad de la Célula y Principios

- **Modelo:** Harness 100% declarativo para equipos ágiles multi-repositorio (Backend, Web, Mobile).
- **Agnóstico:** Libre de información fija de empresa, negocio o equipo; configurable dinámicamente mediante el agente `@aff-onboarding`.
- **Arquitectura de IA:** Basada en `.github/` (instructions, prompts, agents) en un workspace Multi-Root (`cell.code-workspace`) sin daemons externos ni servidores MCP.

---

## 2. Índice de Custom Agents de Copilot (`.github/agents/`)

| Agente | Archivo | Modifica Código | Propósito |
|---|---|---|---|
| **`aff-onboarding`** | `aff-onboarding.agent.md` | Sí | **Agente Inicial:** Construye el contexto de célula (equipo, empresa, negocio, stack y workflow). |
| **`aff-orchestrator`** | `aff-orchestrator.agent.md` | No | Mapea sprint, inicializa contexto de tarea y gestiona `state.yaml`. |
| **`aff-pm`** | `aff-pm.agent.md` | No | Genera hipótesis y preguntas bilingües P1/P2 para ceremonias ágiles. |
| **`aff-analyst`** | `aff-analyst.agent.md` | No | Hidrata tareas técnicas y clasifica criterios de aceptación (DoR). |
| **`aff-architect`** | `aff-architect.agent.md` | No | Define `contract.md` y valida paridad 1:1 entre Web y Mobile. |
| **`aff-security`** | `aff-security.agent.md` | No | Audita OWASP, cero PII, índices en BD y stages de CI/CD. |
| **`aff-qa`** | `aff-qa.agent.md` | No | Construye `test-plan.md` y consolida evidencia multi-canal. |
| **`aff-curator`** | `aff-curator.agent.md` | No | Sincroniza `knowledge/` y `.github/instructions/`. |
| **`aff-planner`** | `aff-planner.agent.md` | No | Planifica unidades atómicas de trabajo (≤ 400 líneas). |
| **`aff-implementer`** | `aff-implementer.agent.md` | Sí | Codifica test-first siguiendo instrucciones del stack técnico. |
| **`aff-reviewer`** | `aff-reviewer.agent.md` | No | Ejecuta revisión adversarial 4R (*Risk, Req, Reg, Res*). |

---

## 3. Catálogo de Prompts Invocables (`.github/prompts/`)

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

## 4. Reglas Innegociables para Desarrolladores y Copilot

1. **Cero Huella Remota Inicial:** No comitear configuraciones locales del framework en repositorios remotos durante Fases 0/1; excluirlos mediante `.git/info/exclude`.
2. **Paridad Multi-Canal Estricta:** Las validaciones de cliente y mensajes de error deben ser idénticos en Web y Mobile. Prohibido calcular reglas de negocio pesadas en los clientes.
3. **Bases de Datos Seguras:**
   - Consultas a colecciones/tablas transaccionales requieren índices declarados y documentados.
   - Toda clave de cache debe poseer `TTL` explícito y cero datos personales en texto claro.
4. **Almacenamiento Seguro Móvil:**
   - Android: `EncryptedSharedPreferences` / `Android KeyStore`.
   - iOS: `Keychain Services`. Estrictamente prohibido `UserDefaults` para datos de sesión o tokens.
5. **Calidad y GitFlow:** Commits atómicos (≤ 400 líneas), TDD estricto y PRs acompañados de evidencia 4R.
