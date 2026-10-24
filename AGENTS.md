# AGENTS.md — Aigile Forge Framework · Scotiabank Edition (AFF-M)

> Contrato declarativo de operación para la célula "The Last of Code" (Seguros Digitales · Scotiabank).
> Optimizado exclusivamente para **Visual Studio Code + GitHub Copilot Business**.
> CERO PII: Prohibido incluir RUTs reales, nombres de clientes, pólizas reales o secretos bancarios.

---

## 1. Identidad de la Célula y Principios

- **Célula:** Seguros Digitales ("The Last of Code" · Mobdev para Scotiabank).
- **Stack Tecnológico:** Microservicios en Java 17/21 y Kotlin con Spring Boot, MongoDB, Redis, Web Angular, Android Nativo (Kotlin), iOS Nativo (Swift) y pipelines Jenkins.
- **VCS & Hosting:** Bitbucket Enterprise Server corporativo bajo GitFlow estricto.
- **Arquitectura de IA:** 100% Declarativa vía `.github/` en Multi-Root Workspace sin servidores MCP ni herramientas externas.

---

## 2. Índice de Custom Agents de Copilot (`.github/agents/`)

| Agente | Archivo | Modifica Código | Propósito |
|---|---|---|---|
| `aff-orchestrator` | `aff-orchestrator.agent.md` | No | Mapea sprint, inicializa contexto y gestiona `state.yaml`. |
| `aff-pm` | `aff-pm.agent.md` | No | Genera hipótesis y preguntas bilingües P1/P2 para ceremonias. |
| `aff-analyst` | `aff-analyst.agent.md` | No | Hidrata tareas de Jira y clasifica criterios de aceptación. |
| `aff-architect` | `aff-architect.agent.md` | No | Define `contract.md` y valida paridad Web / Android / iOS. |
| `aff-security` | `aff-security.agent.md` | No | Audita OWASP, cero PII, índices MongoDB y TTLs en Redis. |
| `aff-qa` | `aff-qa.agent.md` | No | Construye `test-plan.md` y consolida evidencia multi-canal. |
| `aff-curator` | `aff-curator.agent.md` | No | Sincroniza `knowledge/` y `.github/instructions/`. |
| `aff-planner` | `aff-planner.agent.md` | No | Planifica unidades atómicas de trabajo (≤ 400 líneas). |
| `aff-implementer` | `aff-implementer.agent.md` | Sí | Codifica test-first siguiendo instrucciones del stack. |
| `aff-reviewer` | `aff-reviewer.agent.md` | No | Ejecuta revisión adversarial 4R (*Risk, Req, Reg, Res*). |

---

## 3. Catálogo de Prompts Invocables (`.github/prompts/`)

- `/aff-intake`: Clasificación de HU/Incidente y setup de workspace.
- `/elicit-ticket`: Elicitación bilingüe (ES/EN) con máx 10 preguntas P1.
- `/answers-to-spec`: Actualización incremental de `spec.md` con changelog.
- `/contract-first`: Definición de contratos y schemas de integración.
- `/sync-mobile-web-parity`: Auditoría de paridad 1:1 Angular vs Android vs iOS.
- `/hu-to-tasks`: Hidratación de tareas hijas con checklist DoR.
- `/review-4r`: Revisión estricta de calidad antes de abrir PR.
- `/review-refuter`: Segunda pasada adversarial contra falsos positivos.
- `/jenkins-pr-check`: Verificación de etapas de Jenkinsfile localmente.

---

## 4. Reglas Innegociables para Desarrolladores y Copilot

1. **Cero Huella Remota Inicial:** No comitear carpetas `.github/` o de framework en los repositorios de Bitbucket Server; deben excluirse vía `.git/info/exclude`.
2. **Paridad Multi-Canal Estricta:** Las validaciones de formularios y mensajes de error deben ser idénticos en Web, Android e iOS. Prohibido calcular primas en apps móviles.
3. **Bases de Datos Seguras:**
   - En MongoDB: Toda consulta sobre pólizas/cotizaciones requiere `@CompoundIndex` documentado.
   - En Redis: Toda clave debe poseer `TTL` explícito y cero datos de clientes en texto claro.
4. **Almacenamiento Seguro Móvil:**
   - Android: `EncryptedSharedPreferences` / `Android KeyStore`.
   - iOS: `Keychain Services`. Estrictamente prohibido `UserDefaults` para datos de sesión o tokens.
5. **GitFlow y Bitbucket Server:** Commits directos a ramas maestras bloqueados. Todo cambio requiere PR con pipeline Jenkins en verde.
