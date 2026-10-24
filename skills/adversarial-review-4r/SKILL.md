---
name: adversarial-review-4r
description: Manual de ejecución de la revisión adversarial 4R (Risk, Requirements, Regression, Resilience) y refutador de falsos positivos.
---

# Skill: Adversarial Review 4R

## Propósito
Guiar al agente `@aff-reviewer` en la ejecución rigurosa y determinista de la revisión de código sobre `#git-changes` previa a la apertura de un Pull Request, complementada con una segunda pasada adversarial para refutar falsos positivos.

## Las 4 Dimensiones de Análisis

### 1. Risk (Riesgo y Seguridad)
- **Fuga de PII / Datos Privados:** ¿Hay identificadores reales, tarjetas o contraseñas en código, mocks o tests?
- **Persistencia Insegura:** ¿Hay consultas a bases de datos sin índice? ¿Hay claves de cache sin TTL?
- **Almacenamiento Móvil:** ¿Se usa `UserDefaults` en iOS o `SharedPreferences` sin cifrar en Android para datos sensibles?

### 2. Requirements (Requerimientos Funcionales)
- **Cobertura Given/When/Then:** ¿El código implementa todos los escenarios aprobados en la User Story?
- **Casos de Borde:** ¿Se contemplan valores nulos, colecciones vacías o respuestas de error de APIs externas?

### 3. Regression (Regresión y Contratos)
- **Suites Existentes:** ¿Se rompieron tests unitarios o de integración previos?
- **Incompatibilidad de API:** ¿Se modificó un DTO compartido rompiendo contratos con otras capas?

### 4. Resilience (Resiliencia y Manejo de Errores)
- **Timeouts y Caídas:** ¿Qué ocurre si el servicio downstream no responde? ¿Hay timeout configurado?
- **Fuga de Stacktraces:** ¿Se capturan las excepciones adecuadamente sin exponer trazas internas al cliente HTTP?

## Procedimiento de Dos Pasadas

### Pasada 1: Auditoría Crítica (`/review-4r`)
- Generar `review.md` listando hallazgos por severidad: `CRITICAL`, `HIGH`, `MEDIUM`, `LOW`, con archivo y línea.

### Pasada 2: Refutación Adversarial (`/review-refuter`)
- Para cada hallazgo `CRITICAL` o `HIGH`, actuar como abogado defensor técnico e investigar si el riesgo ya está mitigado por:
  - Manejo de excepciones en un `@ControllerAdvice` global.
  - Índices ya creados en scripts de migración.
  - Serializadores Jackson que enmascaran automáticamente el campo.
- Registrar la refutación en `review.md`. Solo los hallazgos que no puedan ser refutados bloquean el Gate G3.
