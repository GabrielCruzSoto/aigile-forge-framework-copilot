# Catálogo de Agentes Declarativos (.github/agents/)

Este documento detalla los **11 Agentes Especializados de GitHub Copilot** integrados en **AFF-Copilot**, incluyendo sus archivos de definición, comandos asociados, entradas requeridas y artefactos generados.

---

## 1. Mapa de Especialización de Agentes

Cada agente cumple una función acotada y rigurosa dentro de la célula, garantizando que el modelo de lenguaje opere con el contexto justo y sin alucinaciones:

```
                    ┌─────────────────────────┐
                    │    @aff-onboarding      │  <── Onboarding Inicial
                    └────────────┬────────────┘
                                 │
                    ┌────────────▼────────────┐
                    │    @aff-orchestrator    │  <── Gobierno y Estado
                    └────────────┬────────────┘
         ┌───────────────────────┼───────────────────────┐
         │                       │                       │
┌────────▼────────┐     ┌────────▼────────┐     ┌────────▼────────┐
│    @aff-pm      │     │  @aff-analyst   │     │ @aff-architect  │
│ (Elicitación)   │     │ (Especificación)│     │  (Contratos)    │
└────────┬────────┘     └────────┬────────┘     └────────┬────────┘
         │                       │                       │
┌────────▼────────┐     ┌────────▼────────┐     ┌────────▼────────┐
│  @aff-planner   │     │@aff-implementer │     │  @aff-security  │
│ (Micro-Tareas)  │     │  (Ciclo TDD)    │     │   (Auditoría)   │
└────────┬────────┘     └────────┬────────┘     └────────┬────────┘
         │                       │                       │
┌────────▼────────┐     ┌────────▼────────┐     ┌────────▼────────┐
│  @aff-reviewer  │     │    @aff-qa      │     │  @aff-curator   │
│  (Revisión 4R)  │     │(Evidencias QA)  │     │(Base Conicim.)  │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

---

## 2. Detalle Exhaustivo de los 11 Agentes

### 1. `@aff-onboarding` — Agente Inicial de Onboarding
- **Archivo de Definición:** [`.github/agents/aff-onboarding.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-onboarding.agent.md)
- **Comando Principal:** `/init-cell`
- **Rol:** Guía al equipo en el levantamiento inicial de las 6 dimensiones de la célula (Identidad, Integrantes, Empresa, Negocio, Arquitectura y Formas de Trabajo).
- **Entradas:** Conversación interactiva con el usuario o plantillas de `templates/`.
- **Salidas:** `cell.config.yaml`, archivos en `knowledge/`, e instrucción `.github/instructions/cell-context.instructions.md`.

---

### 2. `@aff-orchestrator` — Orquestador y Guardián del Estado
- **Archivo de Definición:** [`.github/agents/aff-orchestrator.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-orchestrator.agent.md)
- **Comandos:** `/aff-intake`, `/checkpoint`, `/resume`, `/status`
- **Rol:** Administra la máquina de estados de la célula, asegura el cumplimiento de los Gates y gestiona los congelamientos/retomas de contexto.
- **Entradas:** Tickets crudos, peticiones de cambio de contexto.
- **Salidas:** `sprints/state.yaml`, estructura de carpetas en `work/HU-XXX/`.

---

### 3. `@aff-pm` — Product Manager y Elicitador Bilingüe
- **Archivo de Definición:** [`.github/agents/aff-pm.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-pm.agent.md)
- **Comandos:** `/elicit-ticket`, `/prepare-review`
- **Rol:** Desambigua requerimientos formulando hipótesis y preguntas cerradas P1 en formato bilingüe (ES/EN). Prepara el guion de demostración para el Sprint Review.
- **Entradas:** `work/HU-XXX/ticket-raw.md`, notas del Product Owner.
- **Salidas:** `work/HU-XXX/elicitation.md`, `work/HU-XXX/demo-script.md`.

---

### 4. `@aff-analyst` — Analista Funcional y Creador de DoR
- **Archivo de Definición:** [`.github/agents/aff-analyst.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-analyst.agent.md)
- **Comandos:** `/answers-to-spec`, `/hu-to-tasks`
- **Rol:** Transforma las respuestas de negocio en criterios de aceptación formales (*Given / When / Then*) y evalúa el cumplimiento del Definition of Ready (Gate G1).
- **Entradas:** `work/HU-XXX/elicitation.md` con respuestas del PO.
- **Salidas:** `work/HU-XXX/spec.md`.

---

### 5. `@aff-architect` — Arquitecto de Software y Paridad Multi-Canal
- **Archivo de Definición:** [`.github/agents/aff-architect.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-architect.agent.md)
- **Comandos:** `/contract-first`, `/sync-mobile-web-parity`
- **Rol:** Diseña interfaces REST y OpenAPI, define estrategias de persistencia/cache y certifica que los canales Web y Móvil mantengan consistencia 1:1 (Gate G2).
- **Entradas:** `work/HU-XXX/spec.md`, mapa de arquitectura en `knowledge/`.
- **Salidas:** `work/HU-XXX/contract.md`, `work/HU-XXX/design.md`.

---

### 6. `@aff-planner` — Planificador de Tareas Atómicas
- **Archivo de Definición:** [`.github/agents/aff-planner.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-planner.agent.md)
- **Comando:** `/plan-tasks`
- **Rol:** Desglosa historias de usuario en unidades de trabajo atómicas orientadas a TDD, con un tope estricto de 400 líneas de cambio por tarea.
- **Entradas:** `work/HU-XXX/spec.md`, `work/HU-XXX/contract.md`.
- **Salidas:** `work/HU-XXX/tasks.md`.

---

### 7. `@aff-implementer` — Ingeniero de Software TDD
- **Archivo de Definición:** [`.github/agents/aff-implementer.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-implementer.agent.md)
- **Comandos:** `/implement-next`, `/debug-incident`
- **Rol:** Implementa código de producción siguiendo el ciclo estricto Red-Green-Refactor dentro de las carpetas de los repositorios de código.
- **Entradas:** `work/HU-XXX/tasks.md`, código fuente existente.
- **Salidas:** Código fuente modificado, pruebas unitarias y commits locales en la rama correspondiente.

---

### 8. `@aff-reviewer` — Revisor Adversarial 4R
- **Archivo de Definición:** [`.github/agents/aff-reviewer.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-reviewer.agent.md)
- **Comandos:** `/review-4r`, `/review-refuter`
- **Rol:** Audita el código antes de la apertura del PR en cuatro dimensiones (*Risk, Requirements, Regression, Resilience*) e incluye un refutador para descartar falsos positivos.
- **Entradas:** `git diff` de la rama de trabajo, `work/HU-XXX/spec.md`.
- **Salidas:** `work/HU-XXX/review.md` (Gate G3).

---

### 9. `@aff-qa` — Ingeniero de Aseguramiento de Calidad
- **Archivo de Definición:** [`.github/agents/aff-qa.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-qa.agent.md)
- **Comandos:** `/test-plan`, `/generate-receipt`
- **Rol:** Diseña la matriz de pruebas (unitarias, integración, e2e) y compila el Recibo Consolidado de Evidencias con trazabilidad a los criterios de negocio.
- **Entradas:** `work/HU-XXX/spec.md`, resultados de ejecución de tests.
- **Salidas:** `work/HU-XXX/test-plan.md`, `work/HU-XXX/evidence.md`.

---

### 10. `@aff-security` — Auditor de Seguridad y Cumplimiento
- **Archivo de Definición:** [`.github/agents/aff-security.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-security.agent.md)
- **Comando:** `/security-check`
- **Rol:** Verifica estándares OWASP, ausencia de información sensible o PII en logs, presencia de índices en bases de datos y configuraciones seguras de almacenamiento local.
- **Entradas:** Código fuente, configuraciones de infraestructura (`application.yaml`, Dockerfiles).
- **Salidas:** `work/HU-XXX/security-review.md`.

---

### 11. `@aff-curator` — Curador de Conocimiento de la Célula
- **Archivo de Definición:** [`.github/agents/aff-curator.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-curator.agent.md)
- **Comandos:** `/bootstrap-knowledge`, `/drift-check`
- **Rol:** Detecta discrepancias (*drift*) entre el código implementado y la documentación existente, archiva historias completadas y redacta Registros de Decisiones Arquitectónicas (ADRs).
- **Entradas:** Historias terminadas en `work/`, `knowledge/`.
- **Salidas:** `knowledge/adr/*.md`, `knowledge/drift-report.md`.

---

## 3. Guía de Invocación en VS Code

Para interactuar con cualquiera de los agentes en **GitHub Copilot Chat**:
1. Escribe la mención del agente seguida de su comando o instrucción:
   ```text
   @aff-architect /contract-first para el endpoint de consulta de estado de transacción
   ```
2. Para que el agente inspeccione archivos de otros repositorios en el Multi-Root workspace, usa `#file` o añade `@workspace`:
   ```text
   @aff-reviewer /review-4r comparando contra #file:spec.md
   ```
