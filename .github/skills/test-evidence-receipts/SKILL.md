---
name: test-evidence-receipts
description: Protocolo para mapear suites de prueba 1:1 con criterios de aceptación y consolidar recibos verificables (Receipts).
---

# Skill: Test Evidence and Receipts Consolidation

## Propósito
Guiar al agente `@aff-qa` en la construcción de la matriz `test-plan.md` y en la consolidación de los resultados de pruebas ejecutadas en todas las capas en el certificado final de calidad `evidence.md` (`cell-receipt.md`).

## Metodología Paso a Paso

### 1. Construcción de `test-plan.md`
- Extraer todos los criterios Given/When/Then de `spec.md`.
- Para cada criterio, asignar la prueba correspondiente indicando:
  - *ID de Criterio:* `CA-01`, `CA-02`, etc.
  - *Tipo de Prueba:* Unitaria, Integración, Contrato (Pact/OpenAPI mock) o E2E.
  - *Repositorio y Clase de Test:* Ruta exacta del archivo de test.
  - *Comando de Ejecución:* Comando para reproducir la prueba.

### 2. Recolección de Evidencias de Ejecución
- Correr o capturar la salida de los test runners en cada capa:
  - Backend: Salida de JUnit / Maven Surefire / Gradle Test Runner.
  - Frontend: Salida de Karma / Jest / Vitest en modo headless.
  - Mobile: Salida de `./gradlew testDebugUnitTest` y `xcodebuild test`.
- Extraer métricas clave: Total de pruebas, pruebas pasadas, fallidas, tiempo de ejecución y cobertura de código.

### 3. Consolidación en `evidence.md` (`cell-receipt.md`)
Generar el recibo formal de evidencia que acompaña al Pull Request (Gate G3) con la siguiente estructura:
- **Resumen Ejecutivo:** Total criterios cubiertos vs total criterios de la HU.
- **Tabla de Trazabilidad 1:1:** Criterio CA -> Nombre de Test -> Estado (`PASS` / `FAIL`).
- **Resumen de Cobertura y Seguridad:** Cobertura de líneas por componente y resultado del escáner de seguridad.
- **Declaración de Conformidad:** Veredicto final firmado por el rol QA para autorizar la apertura del PR.
