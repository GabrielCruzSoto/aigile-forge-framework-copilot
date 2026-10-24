# Ciclo de Vida de 8 Fases y Human Gates (G1 a G4)

Este documento describe el flujo operativo end-to-end que sigue una célula de desarrollo en **AFF-Copilot**, desde que entra un requerimiento hasta que se entrega en producción con evidencia verificable.

---

## 1. Diagrama de Flujo del Ciclo de Vida

```text
[Sprint Backlog]
       │
       ▼
 ┌───────────┐      ┌───────────────┐      ┌─────────────────┐     [ GATE G1 ]
 │  FASE 1   │ ───> │    FASE 2     │ ───> │     FASE 3      │ ──> Definition of
 │  Intake   │      │  Elicitación  │      │ Análisis y DoR  │       Ready (DoR)
 └───────────┘      └───────────────┘      └─────────────────┘          │
                                                                        ▼
 ┌───────────┐      ┌───────────────┐      ┌─────────────────┐     [ GATE G2 ]
 │  FASE 6   │ <─── │    FASE 5     │ <─── │     FASE 4      │ <── Contrato y
 │  TDD Dev  │      │ Planificación │      │ Diseño Contrato │      Paridad 1:1
 └─────┬─────┘      └───────────────┘      └─────────────────┘
       │
       ▼
 ┌───────────┐     [ GATE G3 ]      ┌───────────────┐     [ GATE G4 ]
 │  FASE 7   │ ──> Aprobación ───>  │    FASE 8     │ ──> Despliegue y
 │ Review 4R │     de Pull Req      │ Entrega & Rec │      Curation
 └───────────┘                      └───────────────┘
```

---

## 2. Detalle de las 8 Fases Operativas

### Fase 1: Intake y Captura de Requerimiento
- **Agente:** `@aff-orchestrator`
- **Comando:** `/aff-intake`
- **Objetivo:** Recibir el ticket o historia de usuario desde el gestor de tareas (Jira/Azure DevOps), crear la carpeta de trabajo `work/HU-XXX/` e inicializar el seguimiento en `sprints/state.yaml`.
- **Entregable:** `work/HU-XXX/ticket-raw.md`.

### Fase 2: Elicitación Estructurada Bilingüe
- **Agente:** `@aff-pm`
- **Comando:** `/elicit-ticket`
- **Skill:** `bilingual-elicitation`
- **Objetivo:** Identificar ambigüedades, dependencias no resueltas y vacíos de negocio. Formula hipótesis y genera un máximo de 10 preguntas P1 en formato bilingüe (Español e Inglés) con opciones predefinidas para agilizar la sesión de refinamiento.
- **Entregable:** `work/HU-XXX/elicitation.md`.

### Fase 3: Análisis Funcional e Hidratación con DoR
- **Agente:** `@aff-analyst`
- **Comando:** `/answers-to-spec`
- **Skill:** `spec-crafting-hydration`
- **Objetivo:** Incorporar las respuestas del Product Owner, redactar criterios de aceptación formales en formato Gherkin (*Given / When / Then*) y clasificar la madurez del requerimiento.
- **Entregable:** `work/HU-XXX/spec.md`.
- **🚪 GATE G1 (Definition of Ready):** El Product Owner y el Líder Técnico firman la especificación. Si faltan definiciones de negocio o dependencias técnicas críticas, el ticket no pasa a diseño.

### Fase 4: Diseño Contract-First y Paridad Multi-Canal
- **Agente:** `@aff-architect`
- **Comandos:** `/contract-first`, `/sync-mobile-web-parity`
- **Skills:** `contract-first-design`, `multi-channel-parity`
- **Objetivo:** Definir la interfaz REST/OpenAPI, esquemas JSON de respuesta, transacciones de base de datos y validar que Web, Android e iOS consuman y manejen exactamente la misma lógica de errores.
- **Entregables:** `work/HU-XXX/contract.md`, `work/HU-XXX/design.md`.
- **🚪 GATE G2 (Aprobación de Contrato y Paridad):** Los desarrolladores de backend, frontend y mobile revisan el contrato. Ningún equipo inicia desarrollo de código de interfaz hasta que el contrato esté aprobado.

### Fase 5: Planificación de Unidades Atómicas de Trabajo
- **Agente:** `@aff-planner`
- **Comando:** `/plan-tasks`
- **Skill:** `work-unit-tdd`
- **Objetivo:** Desglosar la historia en micro-tareas atómicas independientes de implementación, limitadas estrictamente a un máximo de 400 líneas de cambio por tarea para garantizar code reviews ágiles.
- **Entregable:** `work/HU-XXX/tasks.md`.

### Fase 6: Implementación con Ciclo TDD
- **Agente:** `@aff-implementer`
- **Comando:** `/implement-next`
- **Skill:** `work-unit-tdd`
- **Objetivo:** Ejecutar la tarea activa aplicando el ciclo **Red-Green-Refactor**:
  1. *Rojo:* Escribir prueba unitaria o de integración que falle.
  2. *Verde:* Escribir el código mínimo necesario para que la prueba pase.
  3. *Refactor:* Limpiar código manteniendo suites de pruebas en verde.
- **Entregable:** Código fuente, pruebas automatizadas y commits locales en la rama del repositorio correspondiente.

### Fase 7: Revisión Adversarial 4R y Refutación
- **Agente:** `@aff-reviewer`
- **Comandos:** `/review-4r`, `/review-refuter`
- **Skill:** `adversarial-review-4r`
- **Objetivo:** Auditar el código antes de abrir el Pull Request bajo cuatro perspectivas:
  - **Risk:** Fugas de datos, vulnerabilidades OWASP, timeouts.
  - **Requirements:** Cumplimiento estricto de los Given/When/Then de `spec.md`.
  - **Regression:** Impacto en componentes existentes y cobertura de pruebas.
  - **Resilience:** Manejo de excepciones, degradación elegante y transacciones.
  - **Refutador:** Segunda pasada para desafiar hallazgos y descartar falsos positivos.
- **Entregable:** `work/HU-XXX/review.md`.
- **🚪 GATE G3 (Pull Request y Merge):** El Pull Request en el repositorio de código es revisado por un par humano, respaldado por el veredicto favorable del reporte 4R y con los pipelines de CI en verde.

### Fase 8: Recibo de Pruebas, Entrega y Knowledge Curation
- **Agentes:** `@aff-qa`, `@aff-curator`
- **Comandos:** `/generate-receipt`, `/bootstrap-knowledge`
- **Skills:** `test-evidence-receipts`, `knowledge-curation`
- **Objetivo:** Consolidar evidencias de pruebas automatizadas y manuales en un documento trazable (*Receipt*), preparar el guion para el Sprint Review y actualizar la base de conocimiento (`knowledge/`).
- **Entregables:** `work/HU-XXX/evidence.md`, `knowledge/architecture-system-map.md`.
- **🚪 GATE G4 (Pase a Ambientes y Despliegue):** Aprobación para despliegue en entornos de pruebas (Staging/UAT) y posterior promoción a Producción.

---

## 3. Matriz de Human Gates

Los **Human Gates** son puntos de control no delegables a la inteligencia artificial donde una persona con rol definido debe dar su aprobación explícita:

| Gate | Nombre | Responsable Humano | Criterio de Aprobación | Artefacto Clave |
|---|---|---|---|---|
| **G1** | **Definition of Ready (DoR)** | Product Owner & Tech Lead | Cero preguntas P1 abiertas; criterios Given/When/Then completos. | `work/HU-XXX/spec.md` |
| **G2** | **Contrato & Paridad** | Tech Lead & Devs Canales | Esquema OpenAPI acordado; paridad Web/Mobile verificada. | `work/HU-XXX/contract.md` |
| **G3** | **Pull Request Approval** | Tech Lead & Peer Reviewer | 4R Review favorable; tests en verde; sin cambios fuera de scope. | `work/HU-XXX/review.md` |
| **G4** | **Pase a Producción / UAT** | DevOps, PO & QA | Recibo de evidencia completo; pruebas de humo satisfactorias. | `work/HU-XXX/evidence.md` |

---

## 4. Congelamiento y Retoma de Trabajo (`checkpoint-resume`)

Si durante el ciclo de vida ocurre un cambio de prioridad, una interrupción o el desarrollador debe cambiar de contexto:

1. **Congelar estado:**
   ```text
   @aff-orchestrator /checkpoint
   ```
   El framework genera un snapshot de la rama, los archivos modificados y el estado del sprint en `sprints/state.yaml`.
2. **Retomar estado:**
   ```text
   @aff-orchestrator /resume
   ```
   El agente restaura el contexto exacto donde se quedó la célula, listando la siguiente micro-tarea pendiente en `tasks.md`.
