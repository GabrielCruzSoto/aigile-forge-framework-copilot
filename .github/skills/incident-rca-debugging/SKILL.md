---
name: incident-rca-debugging
description: Protocolo metódico para aislar bugs en logs, reproducir fallos con tests unitarios rojos y documentar la causa raíz (RCA).
---

# Skill: Incident Debugging and Root Cause Analysis (RCA)

## Propósito
Guiar a los agentes `@aff-implementer` y `@aff-analyst` durante la atención de incidentes o bugs críticos (Clase `H`), asegurando que no se apliquen parches ciegos y que cada corrección cuente con prueba reproductora y análisis de causa raíz.

## Metodología Paso a Paso

### 1. Triaje y Extracción de Síntomas
- Inspeccionar trazas y logs de error provistos en el reporte del incidente.
- Filtrar por identificador de correlación (`X-Correlation-Id`, `X-Trace-Id`).
- Identificar:
  - *Comportamiento Observado:* Qué falló, qué código HTTP o excepción se arrojó.
  - *Comportamiento Esperado:* Qué debió haber ocurrido según el contrato o regla de negocio.
  - *Payload o Estado Disparador:* Qué datos exactos provocaron la falla.

### 2. Creación del Test Rojo Reproductor (Mandatorio)
Antes de escribir cualquier línea de código de solución:
1. Crear o localizar la clase de test unitario o de integración correspondiente.
2. Escribir un test que replique exactamente el payload o condición de carrera que disparó el error.
3. Ejecutar el test localmente y **comprobar que falla en rojo**, arrojando el mismo síntoma observado en producción o QA.

### 3. Aplicación de la Solución Mínima
- Aplicar la corrección quirúrgica estrictamente necesaria para que el test rojo pase a verde.
- Ejecutar la suite completa del componente para certificar que la solución no introdujo regresiones.

### 4. Redacción del Documento `rca.md`
Generar `work/<BUG-KEY>-<slug>/rca.md` estructurado según la técnica de los **5 Porqués**:
- **Resumen del Incidente:** Severidad, servicios afectados y tiempo de impacto.
- **Causa Raíz Inmediata:** La línea o condición de código exacta que falló.
- **Los 5 Porqués:** Cadena causal que explica por qué ocurrió y por qué los tests previos no lo detectaron.
- **Medidas Preventivas:** Tests adicionales agregados, cambios en contratos o mejoras en monitoreo.
