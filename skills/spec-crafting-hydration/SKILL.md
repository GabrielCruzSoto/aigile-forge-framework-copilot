---
name: spec-crafting-hydration
description: Cómo redactar especificaciones funcionales vivas con criterios Given/When/Then e hidratar tareas técnicas con Definition of Ready (DoR).
---

# Skill: Spec Crafting and Task Hydration

## Propósito
Guiar al agente `@aff-analyst` en la redacción iterativa de `spec.md` y en la generación de tarjetas técnicas hidratadas (`task-cards/<TASK-KEY>.md`) listas para pasar a desarrollo.

## Flujo de Ejecución Paso a Paso

### 1. Construcción y Mantenimiento de `spec.md`
- Recibir las respuestas validadas desde las ceremonias ágiles o el archivo `elicitation.md`.
- Mantener un **Changelog de Versiones** en `spec.md` (`v0.1 -> v1.0 -> v1.1`) con fecha, autor y resumen de cambios.
- Redactar cada criterio de aceptación en sintaxis Gherkin estricta:
  ```markdown
  ### CA-01: Validar saldo antes de la transferencia
  - **Estado de Madurez:** `[HIPOTESIS | CONFIRMADO | VALIDADO]`
  - **Origen:** `Q1 (elicitation.md)`
  - **Escenario:**
    - **Given** un usuario autenticado con cuenta activa
    - **When** intenta transferir un monto superior a su saldo disponible
    - **Then** el sistema rechaza la operación con código `ERR_INSUFFICIENT_FUNDS`
  ```

### 2. Ciclo de Madurez de Criterios
1. `HIPOTESIS`: Criterio inferido técnicamente, no confirmado por el PO. Bloquea el inicio de desarrollo.
2. `CONFIRMADO`: Aprobado explícitamente por el PO en Planning o Refinamiento (Gate G1). Habilita implementación.
3. `VALIDADO`: Comprobado con pruebas automatizadas o en la demo de Sprint Review.

### 3. Hidratación de Tareas Hijas (`task-cards/<TASK-KEY>.md`)
Para cada tarea que en el gestor de tareas (Jira) solo tiene un título:
1. **Identificar la Capa y Repositorio:** Backend, Frontend Web, Mobile Android, Mobile iOS o Batch.
2. **Asignar Criterios Específicos:** Copiar los criterios Given/When/Then que corresponden estrictamente a esa tarea.
3. **Mapear Archivos Afectados en `@workspace`:** Listar rutas exactas de código y tests a crear o modificar.
4. **Verificar el Checklist de Definition of Ready (DoR):**
   - [ ] Contratos definidos en `contract.md`.
   - [ ] Cero criterios en `HIPOTESIS` asignados a esta tarea.
   - [ ] Mocks disponibles (si es frontend o mobile).
   - [ ] Índices y caching validados (si es backend).
5. **Generar Bloque para Jira:** Formatear el bloque markdown listo para copiar y pegar en la tarjeta externa.
