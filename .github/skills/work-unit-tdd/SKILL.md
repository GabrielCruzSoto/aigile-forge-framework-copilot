---
name: work-unit-tdd
description: Descomposición de tareas en unidades atómicas (<= 400 líneas), ciclo TDD estricto y Conventional Commits.
---

# Skill: Work Unit Planning and Strict TDD

## Propósito
Guiar a los agentes `@aff-planner` e `@aff-implementer` en la ejecución metódica de la implementación técnica mediante unidades de trabajo atómicas y desarrollo guiado por pruebas (TDD).

## Metodología Paso a Paso

### 1. Planificación de Unidades Atómicas (`tasks.md`)
El agente `@aff-planner` toma la tarjeta técnica (`task-cards/<TASK-KEY>.md`) y la divide en unidades manejables:
- **Budget de Tamaño:** Cada unidad debe involucrar aproximadamente `≤ 400 líneas` de código autoral y tests.
- **Estructura de Cada Unidad:**
  - *Objetivo:* Qué comportamiento puntual se introduce.
  - *Archivos a Tocar:* Ruta de archivo fuente y ruta de archivo de test.
  - *Comando Local de Verificación:* Comando exacto para comprobar el resultado (ej. `./mvnw test -Dtest=OrderServiceTest`).

### 2. Ciclo TDD Estricto (`Red -> Green -> Refactor`)
El agente `@aff-implementer` procesa una unidad a la vez:
1. **Fase Roja (Red):**
   - Escribir primero el test unitario que describe el comportamiento esperado del criterio Given/When/Then.
   - Ejecutar el test localmente y comprobar que falla por la razón esperada.
2. **Fase Verde (Green):**
   - Escribir la cantidad mínima necesaria de código de producción para que el test pase.
   - Ejecutar el comando de verificación y comprobar que la suite está en verde.
3. **Fase Refactor:**
   - Limpiar el diseño, eliminar duplicación y optimizar legibilidad sin alterar el comportamiento.
   - Re-ejecutar los tests locales para garantizar no regresión.

### 3. Commit Atómico por Unidad de Trabajo
- Un commit por cada unidad completada con éxito.
- Formato **Conventional Commits**:
  - `feat(<component>): add validation for transaction amount`
  - `test(<component>): add boundary tests for empty payload`
  - `refactor(<component>): extract pricing policy calculation helper`
- **Prohibido:** No incluir firmas de IA ("Co-Authored-By" con modelos de IA).
