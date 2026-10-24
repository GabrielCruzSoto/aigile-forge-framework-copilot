# Catálogo de Procedimientos y Agent Skills (skills/)

Este documento detalla las **13 Agent Skills Procedimentales** que guían a los agentes de IA en **AFF-Copilot**. Cada skill es un protocolo paso a paso que estandariza la calidad de los entregables y elimina la improvisación del modelo de lenguaje.

---

## 1. Estructura y Anatomía de una Agent Skill

Cada skill reside en una carpeta propia dentro de [`skills/`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/skills/) y se replica automáticamente en [`.github/skills/`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/skills/) para su consumo por Copilot.

Una skill consta de:
```markdown
---
name: nombre-de-la-skill
description: Resumen conciso de cuándo y cómo debe invocarse esta habilidad.
---

# Nombre de la Habilidad

## 1. Propósito y Cuándo Aplicar
## 2. Entradas Requeridas
## 3. Procedimiento Paso a Paso (Checklist ejecutable)
## 4. Entregables y Estructura del Archivo de Salida
## 5. Criterios de Aceptación y Trampas Comunes (Gotchas)
```

---

## 2. Las 13 Agent Skills Procedimentales

### 1. `cell-onboarding-bootstrap`
- **Agente Principal:** `@aff-onboarding`
- **Entregables:** `cell.config.yaml`, `knowledge/*.md`, `.github/instructions/cell-context.instructions.md`.
- **Procedimiento:** Ejecuta la entrevista estructurada de 6 dimensiones (Identidad, Equipo, Empresa, Negocio, Arquitectura, WoW). Sanitiza datos sensibles y autogenera los archivos de contexto inicial.

---

### 2. `bilingual-elicitation`
- **Agente Principal:** `@aff-pm`
- **Entregable:** `work/HU-XXX/elicitation.md`.
- **Procedimiento:** Toma una historia de usuario preliminar o incompleta, analiza vacíos funcionales y genera un máximo de 10 preguntas P1 en formato bilingüe (Español / Inglés). Cada pregunta ofrece opciones predeterminadas para acelerar la toma de decisiones.

---

### 3. `spec-crafting-hydration`
- **Agente Principal:** `@aff-analyst`
- **Entregables:** `work/HU-XXX/spec.md`, `work/HU-XXX/task-cards/*.md`.
- **Procedimiento:** Procesa las respuestas de la elicitación y formaliza los criterios de aceptación en sintaxis Gherkin (*Given / When / Then*). Realiza el cálculo del Definition of Ready (Gate G1).

---

### 4. `contract-first-design`
- **Agente Principal:** `@aff-architect`
- **Entregables:** `work/HU-XXX/contract.md`, `work/HU-XXX/design.md`.
- **Procedimiento:** Diseña la especificación OpenAPI/REST, modelos de datos de entrada/salida, códigos de respuesta HTTP y reglas de persistencia. Define la compatibilidad con versiones previas (N / N-1).

---

### 5. `multi-channel-parity`
- **Agentes:** `@aff-architect`, `@aff-qa`
- **Entregable:** Sección de paridad en `work/HU-XXX/contract.md`.
- **Procedimiento:** Audita que el contrato sea 100% interoperable entre el canal Web (Angular/React) y los canales Móviles (Android Kotlin / iOS Swift). Asegura que los errores y validaciones se decidan en el backend.

---

### 6. `adversarial-review-4r`
- **Agente Principal:** `@aff-reviewer`
- **Entregable:** `work/HU-XXX/review.md`.
- **Procedimiento:** Inspecciona el diff del código fuente bajo 4 dimensiones:
  1. *Risk:* Seguridad, PII, recursos no liberados.
  2. *Requirements:* Cobertura de los criterios Given/When/Then.
  3. *Regression:* Impacto colateral en otras áreas del sistema.
  4. *Resilience:* Manejo robusto de errores y fallos de infraestructura.
  Incluye una fase de refutación para validar hallazgos antes de consolidar el reporte.

---

### 7. `work-unit-tdd`
- **Agentes:** `@aff-planner`, `@aff-implementer`
- **Entregables:** `work/HU-XXX/tasks.md`, código y pruebas unitarias.
- **Procedimiento:** Divide el requerimiento en tareas atómicas de ≤ 400 líneas. Ejecuta de forma estricta el ciclo TDD (*Test Driven Development*): prueba roja primero, código verde mínimo después, refactorización final.

---

### 8. `incident-rca-debugging`
- **Agentes:** `@aff-implementer`, `@aff-analyst`
- **Entregables:** `work/HU-XXX/rca.md`, prueba unitaria de regresión (en rojo).
- **Procedimiento:** Protocolo para resolver incidentes productivos o bugs complejos. Aplica la técnica de los *5 Porqués*, aísla el comportamiento anómalo en logs, y reproduce el fallo mediante una prueba automatizada antes de modificar código.

---

### 9. `pull-request-documentation`
- **Agentes:** `@aff-implementer`, `@aff-reviewer`
- **Entregable:** `work/HU-XXX/pr.md`.
- **Procedimiento:** Genera descripciones de Pull Request profesionales y trazables: resumen ejecutivo, tickets relacionados, pruebas realizadas, consideraciones de rollback y notas para el changelog.

---

### 10. `test-evidence-receipts`
- **Agente Principal:** `@aff-qa`
- **Entregables:** `work/HU-XXX/test-plan.md`, `work/HU-XXX/evidence.md`.
- **Procedimiento:** Crea la matriz de pruebas automatizadas y manuales. Recopila la salida de ejecución de suites de tests y emite un certificado digital de calidad (*Quality Receipt*) para la aprobación de despliegue (Gate G4).

---

### 11. `enterprise-security-audit`
- **Agente Principal:** `@aff-security`
- **Entregable:** `work/HU-XXX/security-review.md`.
- **Procedimiento:** Audita que no existan credenciales en texto plano, que los logs no contengan números de tarjeta o datos personales sensibles (PII), que las consultas a bases de datos empleen índices y que las caches implementen TTLs obligatorios.

---

### 12. `knowledge-curation`
- **Agente Principal:** `@aff-curator`
- **Entregables:** `knowledge/drift-report.md`, registros ADR en `knowledge/adr/`.
- **Procedimiento:** Compara periódicamente la realidad del código en los repositorios contra los documentos en `knowledge/`. Detecta documentación obsoleta (*drift*), archiva historias completadas y documenta decisiones técnicas relevantes.

---

### 13. `checkpoint-resume`
- **Agente Principal:** `@aff-orchestrator`
- **Entregable:** Sección de checkpoint en `sprints/state.yaml`.
- **Procedimiento:** Permite pausar cualquier tarea en curso en menos de 30 segundos mediante un snapshot del estado local (archivos modificados, rama activa y paso pendiente) para poder retomarla sin fricción tras una interrupción.
